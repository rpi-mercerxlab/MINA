#include "drivers.h"
#include <stdint.h>

#define NPU_SOURCE_OFFSET 0x200u // Byte offset -> Vector 0x40 (Word 128)
#define NPU_RESULT_OFFSET 0x400u // Byte offset -> Vector 0x80 (Word 256)
#define MATRIX_DIM 8u

uint8_t simple_counter = 0;
volatile int npu_done_flag = 0;

static void npu_wait_halted(void) {
  NPU_HALT();
  while (!NPU_IS_HALTED()) {
    // Wait for fetch_halted + QUIESCE_CYCLES (7 cycles)
  }
}

/*
 * Scratchpad vectors [0x40 .. 0x47] hold COLUMNS of Matrix A.
 * Vector k (word 2*k and 2*k+1) holds A[0..7][k].
 */
static void fill_matrix(void) {
  volatile uint32_t *dst =
      NPU_SCRATCHPAD_BASE + (NPU_SOURCE_OFFSET / sizeof(uint32_t));

  uint8_t base = simple_counter;
  for (uint32_t col = 0; col < MATRIX_DIM; ++col) {
    for (uint32_t half = 0; half < 2u; ++half) {
      uint32_t packed = 0;
      for (uint32_t lane = 0; lane < 4u; ++lane) {
        uint32_t row = half * 4u + lane;
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
        packed |= ((uint32_t)val << (8u * lane));
      }
      dst[col * 2u + half] = packed;
    }
  }
  simple_counter = (uint8_t)((simple_counter + 64u) & 0x7Fu);
}

static void uart_print_u8(uint8_t value) {
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
  uart_putc('0' + value % 10);
}

static void print_matrix(void) {
  volatile uint32_t *src =
      NPU_SCRATCHPAD_BASE + (NPU_RESULT_OFFSET / sizeof(uint32_t));

  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
    for (uint32_t word = 0; word < 2u; ++word) {
      uint32_t packed = src[row * 2u + word];
      for (uint32_t lane = 0; lane < 4u; ++lane) {
        uint8_t value = (uint8_t)(packed >> (8u * lane));
        uart_print_u8(value);
        uart_putc(' ');
      }
    }
    uart_putc('\r');
    uart_putc('\n');
  }
  uart_putc('\r');
  uart_putc('\n');
}

void npu_irq_handler(void) {
  // 1. Halt NPU and wait for safe_halted so AXI-Lite owns Scratchpad RAM
  npu_wait_halted();

  // 2. Clear NPU interrupt line
  NPU_CLEAR_IRQ();

  // 3. Read result matrix C from 0x400 and print over UART
  print_matrix();

  // 4. Write next counter matrix A into 0x200
  fill_matrix();

  // 5. Reset NPU PC to 0 and restart execution
  NPU_RESET();
  while (!NPU_IS_HALTED()) {
  }
  NPU_START();
}

static void uart_print_u32(uint32_t val) {
  char buf[10];
  int i = 0;
  if (val == 0) {
    uart_putc('0');
    return;
  }
  while (val > 0) {
    buf[i++] = '0' + (val % 10);
    val /= 10;
  }
  while (i > 0) {
    uart_putc(buf[--i]);
  }
}

int main(void) {
  init_interrupts();
  uart_init();
  reg_NPU_irq(npu_irq_handler, 1);

  uart_puts("Starting program, loaded interrupts\n");

  // Ensure NPU is halted and reset before touching Scratchpad RAM
  NPU_RESET();
  while (!NPU_IS_HALTED()) {
  }

  // Load initial Matrix A into Scratchpad at offset 0x200
  fill_matrix();

  // Start NPU execution from PC = 0
  NPU_START();

  uint32_t counter = 0;

  while (1) {
    counter++;
    if (counter == 100000000) {
      uart_puts("Program counter, NPU: ");

      uart_print_u32((int)NPU_PC_IDX);

      uart_putc('\n');
      counter = 0;
    }
  }

  return 0;
}
