#include <stdint.h>
#include <stdio.h>

#ifndef IRQ_H
#define IRQ_H

/* --- CSR Helper Macros --- */
#define read_csr(reg)                                                          \
  ({                                                                           \
    unsigned long __tmp;                                                       \
    asm volatile("csrr %0, " #reg : "=r"(__tmp));                              \
    __tmp;                                                                     \
  })

#define write_csr(reg, val) ({ asm volatile("csrw " #reg ", %0" ::"rK"(val)); })

#define set_csr(reg, bit)                                                      \
  ({                                                                           \
    unsigned long __tmp;                                                       \
    asm volatile("csrrs %0, " #reg ", %1" : "=r"(__tmp) : "rK"(bit));          \
    __tmp;                                                                     \
  })

/* --- Constants --- */
// Machine External Interrupt code is 11
#define IRQ_M_EXT 11
// Timer Interrupt code is 7
#define IRQ_M_TIMER 7
// Software Interrupt code is 3
#define IRQ_M_SOFT 3
// MIE bit in mstatus (bit 3)
#define MSTATUS_MIE (1 << 3)
// MEIE bit in mie (bit 11)
#define MIE_MEIE (1 << 11)

/* --- PLIC Addresses --- */
// PLIC base addr
#define PLIC_BASE 0x20000000

// Register Memory Map
#define PLIC_IRQ_ACTV ((volatile uint32_t *)(PLIC_BASE + 0x00))
#define PLIC_IRQ_PEND ((volatile uint32_t *)(PLIC_BASE + 0x04))
#define PLIC_CLAIM_REG ((volatile uint32_t *)(PLIC_BASE + 0x08))

#define PLIC_UART_MASK (1 << 0)
#define PLIC_CDMA_MASK (1 << 1)
#define PLIC_GPIO_MASK (1 << 2)
#define PLIC_SPI_MASK (1 << 3)
#define PLIC_NPU_MASK (1 << 4)

extern void (*plic_irq_handlers[8])(void);
extern int plic_irq_priorities[8];
extern int plic_idx_sort[8];

void init_interrupts(void);
void __attribute__((interrupt("machine"), aligned(4))) trap_handler(void);

extern void (*timer_irq_handler)(void);
void reg_timer_irq(void (*_timer_irq_handler)(void));

void plic_irq_handler(void);

void reg_irq_handler(void (*_plic_irq_handler)(void), int priority,
                     uint32_t actv_mask, int arr_idx);

#define reg_UART_irq(irq_handler, priority)                                    \
  reg_irq_handler(irq_handler, priority, PLIC_UART_MASK, 0)
#define reg_CDMA_irq(irq_handler, priority)                                    \
  reg_irq_handler(irq_handler, priority, PLIC_CDMA_MASK, 1)
#define reg_GPIO_irq(irq_handler, priority)                                    \
  reg_irq_handler(irq_handler, priority, PLIC_GPIO_MASK, 2)
#define reg_SPI_irq(irq_handler, priority)                                     \
  reg_irq_handler(irq_handler, priority, PLIC_SPI_MASK, 3)
#define reg_NPU_irq(irq_handler, priority)                                     \
  reg_irq_handler(irq_handler, priority, PLIC_NPU_MASK, 4)

#define CS(a, b)                                                               \
  do {                                                                         \
    if (plic_irq_priorities[plic_idx_sort[a]] <                                \
        plic_irq_priorities[plic_idx_sort[b]]) {                               \
      int tmp = plic_idx_sort[a];                                              \
      plic_idx_sort[a] = plic_idx_sort[b];                                     \
      plic_idx_sort[b] = tmp;                                                  \
    }                                                                          \
  } while (0)

void resort_by_prior();

#endif
