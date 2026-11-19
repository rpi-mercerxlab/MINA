#include "drivers.h"
#include <stdint.h>

#define MNIST_PIXELS 784u
#define MNIST_TILES 98u // 784 / 8
#define MNIST_CLASSES 10u

// Vector addresses from NPU MNIST assembly
#define NPU_X_VEC_BASE 0u     // Input X:   vectors [0..783]   (98 tiles * 8)
#define NPU_OUT_VEC_BASE 816u // Output Y:  vectors [816..831] (2 tiles * 8)
#define WORDS_PER_VEC 2u // 64-bit vector / 32-bit host word (NUM_BANKS = 2)

// Set to 1 if your NPU uses signed int8 inputs (maps GUI 0..255 -> 0..127)
#define SCALE_INPUT_TO_INT7 1

// Set to 1 if Layer 2 (ACT_NONE) outputs signed int8 (-128..127) and you want
// to clamp negatives to 0 before sending to the 0..255 GUI bar graph.
// Set to 0 to send raw unsigned bytes.
#define CLAMP_SIGNED_OUTPUT 1

volatile int npu_done_flag = 0;
static uint8_t rx_image[MNIST_PIXELS];

static void npu_wait_halted(void) {
  NPU_HALT();
  while (!NPU_IS_HALTED()) {
    // Wait for fetch_halted before host accesses scratchpad RAM
  }
}

void npu_irq_handler(void) {
  NPU_HALT();
  NPU_CLEAR_IRQ();
  npu_done_flag = 1;
}

// Zero out the entire input region [0..783] once so unused batch rows (1..7)
// are 0
static void clear_input_scratchpad(void) {
  volatile uint32_t *sp = NPU_SCRATCHPAD_BASE;
  uint32_t total_words = (MNIST_TILES * 8u) * WORDS_PER_VEC;
  for (uint32_t i = 0; i < total_words; ++i) {
    sp[i] = 0u;
  }
}

// Receive 784 raw pixel bytes in row-major order from the Python GUI
static void uart_read_image(uint8_t *buf) {
  for (uint32_t i = 0; i < MNIST_PIXELS; ++i) {
    // Replace uart_getc() with your driver's blocking byte-read function if
    // named differently
    buf[i] = (uint8_t)uart_getc();
  }
}

// Pack 784 pixels into batch row 0 of the 98 input tiles (vectors 0, 8, 16,
// ..., 776)
static void load_image_to_npu(const uint8_t *img) {
  volatile uint32_t *sp = NPU_SCRATCHPAD_BASE;

  for (uint32_t tile = 0; tile < MNIST_TILES; ++tile) {
    uint32_t vec_addr = NPU_X_VEC_BASE + (tile * 8u); // Batch row 0
    uint32_t word_base = vec_addr * WORDS_PER_VEC;
    const uint8_t *px = &img[tile * 8u];

    for (uint32_t half = 0; half < WORDS_PER_VEC; ++half) {
      uint32_t packed = 0u;
      for (uint32_t lane = 0; lane < 4u; ++lane) {
        uint8_t val = px[half * 4u + lane];
#if SCALE_INPUT_TO_INT7
        val >>= 1; // 0..255 -> 0..127
#endif
        packed |= ((uint32_t)val << (8u * lane));
      }
      sp[word_base + half] = packed;
    }
  }
}

static uint8_t format_output_byte(uint8_t raw) {
#if CLAMP_SIGNED_OUTPUT
  int8_t s = (int8_t)raw;
  return (s < 0)
             ? 0u
             : (uint8_t)(s << 1); // Map 0..127 -> 0..254 for full bar height
#else
  return raw;
#endif
}

// Read batch row 0's 10 output classes and transmit as 10 raw bytes over UART
static void send_results_over_uart(void) {
  volatile uint32_t *sp = NPU_SCRATCHPAD_BASE;

  // Tile 0, batch row 0 -> vector 816 (digits 0..7)
  uint32_t t0_word_base = NPU_OUT_VEC_BASE * WORDS_PER_VEC;
  uint32_t w0 = sp[t0_word_base + 0u]; // digits 0..3
  uint32_t w1 = sp[t0_word_base + 1u]; // digits 4..7

  // Tile 1, batch row 0 -> vector 824 (digits 8..9 in lower 2 bytes)
  uint32_t t1_word_base = (NPU_OUT_VEC_BASE + 8u) * WORDS_PER_VEC;
  uint32_t w2 = sp[t1_word_base + 0u]; // digits 8..9 (+ 2 pad bytes)

  for (uint32_t lane = 0; lane < 4u; ++lane) {
    uart_putc(format_output_byte((uint8_t)(w0 >> (8u * lane))));
  }
  for (uint32_t lane = 0; lane < 4u; ++lane) {
    uart_putc(format_output_byte((uint8_t)(w1 >> (8u * lane))));
  }
  for (uint32_t lane = 0; lane < 2u; ++lane) {
    uart_putc(format_output_byte((uint8_t)(w2 >> (8u * lane))));
  }
}

int main(void) {
  // 1. Put NPU in a known halted/reset state and clear any stale IRQ
  NPU_HALT();
  NPU_RESET();
  NPU_CLEAR_IRQ();
  npu_wait_halted();

  // 2. Initialize CPU interrupts and UART driver
  init_interrupts();
  uart_init();
  reg_NPU_irq(npu_irq_handler, 1);

  // 3. Clear unused batch rows in scratchpad
  clear_input_scratchpad();

  while (1) {
    // Block until a full 784-byte image arrives from the Python GUI
    uart_read_image(rx_image);

    // Load image into scratchpad while NPU is halted
    npu_wait_halted();
    load_image_to_npu(rx_image);

    // Reset PC to 0 and run inference
    npu_done_flag = 0;
    NPU_RESET();
    npu_wait_halted();
    NPU_START();

    // Wait for TRG_INT interrupt from NPU
    while (!npu_done_flag) {
      // Wait for completion
    }
    npu_done_flag = 0;

    // Ensure NPU is halted, then read OUT [816..824] and send 10 bytes back
    npu_wait_halted();
    send_results_over_uart();
  }

  return 0;
}
