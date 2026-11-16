#include "../include/irq.h"
#include <stddef.h> // Needed for NULL in C

void (*plic_irq_handlers[8])(void) = {NULL};
int plic_irq_priorities[8] = {-1, -1, -1, -1, -1, -1, -1, -1};
int plic_idx_sort[8] = {0, 1, 2, 3, 4, 5, 6, 7};
void (*timer_irq_handler)(void) = NULL;

void init_interrupts(void) {
  // A. Point mtvec to our handler (Direct mode: lowest 2 bits are 00)
  write_csr(mtvec, (unsigned long)trap_handler);

  // B. Enable Machine External Interrupts in the 'mie' register
  set_csr(mie, MIE_MEIE);

  // C. Enable Global Machine Interrupts in the 'mstatus' register
  set_csr(mstatus, MSTATUS_MIE);
}

void __attribute__((interrupt("machine"), aligned(4))) trap_handler(void) {
  unsigned long cause = read_csr(mcause);

  // Check if MSB is set (Interrupt vs Exception)
  if ((long)cause < 0) {
    unsigned long exception_code = cause & ~(1UL << (sizeof(long) * 8 - 1));
    if (exception_code == IRQ_M_EXT) {
      plic_irq_handler();
    } else if (exception_code == IRQ_M_TIMER) {
      if (timer_irq_handler) {
        timer_irq_handler();
      }
    }
  } else {
    // Synchronous Exception (Fault / Crash)
    uart_polled_puts("\r\n\r\n=== CPU EXCEPTION / CRASH DETECTED ===\r\n");
    uart_print_hex("mcause: 0x", (uint32_t)cause);
    uart_print_hex("mepc  : 0x", (uint32_t)read_csr(mepc));
    uart_print_hex("mtval : 0x", (uint32_t)read_csr(mtval));

    // Optional: Dump Stack Backtrace
    // We grab the stack pointer (sp) at the moment of exception
    register uint32_t *stack_ptr asm("sp");

    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
    extern uint32_t _stack_top; // Defined by link.ld as top of CPU_RAM
    uint32_t *stack_top_ptr = &_stack_top;

    // Scan memory from current stack pointer up to stack top
    while (stack_ptr < stack_top_ptr) {
      uint32_t val = *stack_ptr;
      // Check if value points to valid SHARED_RAM code section (0x00000000 to
      // 0x00004000)
      if (val >= 0x00000000 && val < 0x00004000) {
        uart_print_hex("  from instruction addr: 0x", val);
      }
      stack_ptr++;
    }

    uart_polled_puts("System halted.\r\n");
    while (1) {
      // Hang indefinitely for debugger attachment
    }
  }
}

void plic_irq_handler(void) {

  uint32_t pending = *PLIC_IRQ_PEND;

  for (int i = 0; i < 8; i++) {
    int current_idx = plic_idx_sort[i];

    if ((pending & (1 << current_idx)) != 0) {
      if (plic_irq_handlers[current_idx] &&
          plic_irq_priorities[current_idx] != -1) {
        plic_irq_handlers[current_idx]();

        // THIS ASSUMES THE HANDLER CLEARS THE STATE CAUSING THE INTERRUPT,
        // OTHERWISE THE IRQ WILL TRIGGER AGAIN
        *PLIC_CLAIM_REG = 1 << current_idx;
      }
    }
  }
}

void reg_irq_handler(void (*_plic_irq_handler)(void), int priority,
                     uint32_t actv_mask, int arr_idx) {

  plic_irq_handlers[arr_idx] = _plic_irq_handler;
  plic_irq_priorities[arr_idx] = priority;

  *PLIC_IRQ_ACTV |= actv_mask;

  resort_by_prior();
}

void resort_by_prior() {

  for (int i = 0; i < 8; i++) {
    plic_idx_sort[i] = i;
  }

  // 19-Comparator Sorting Network for N=8
  // Layer 1
  CS(0, 1);
  CS(2, 3);
  CS(4, 5);
  CS(6, 7);
  // Layer 2
  CS(0, 2);
  CS(1, 3);
  CS(4, 6);
  CS(5, 7);
  // Layer 3
  CS(1, 2);
  CS(5, 6);
  CS(0, 4);
  CS(3, 7);
  // Layer 4
  CS(1, 5);
  CS(2, 6);
  // Layer 5
  CS(1, 4);
  CS(3, 6);
  // Layer 6
  CS(2, 4);
  CS(3, 5);
  // Layer 7
  CS(3, 4);
}

void reg_timer_irq(void (*_timer_irq_handler)(void)) {
  timer_irq_handler = _timer_irq_handler;
}
