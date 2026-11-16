#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>

#ifndef NPU_H
#define NPU_H

#define NPU_BASE 0x40000000

// Register Memory Map
#define NPU_CSR ((volatile uint32_t *)(NPU_BASE + 0x00))
#define NPU_STATUS ((volatile uint32_t *)(NPU_BASE + 0x04))
#define NPU_PC_IDX ((volatile uint32_t *)(NPU_BASE + 0x08))
#define NPU_IRQ_ADDR ((volatile uint32_t *)(NPU_BASE + 0x0C))

#define NPU_WEIGHT_BASE ((volatile uint32_t *)(NPU_BASE + 0x200000))
#define NPU_SCRATCHPAD_BASE ((volatile uint32_t *)(NPU_BASE + 0x300000))

#define NPU_INSTR_COUNT 1024u
#define NPU_INSTR_OFFSET 0x100000u
#define NPU_INSTR_STRIDE 8u
#define NPU_INSTR_MASK UINT64_C(0xFFFFFFFFF)

#define NPU_INSTR_LO(i)                                                        \
  (*(volatile uint32_t *)((uintptr_t)(NPU_BASE) + NPU_INSTR_OFFSET +           \
                          (uintptr_t)(i) * NPU_INSTR_STRIDE))

#define NPU_INSTR_HI(i)                                                        \
  (*(volatile uint32_t *)((uintptr_t)(NPU_BASE) + NPU_INSTR_OFFSET +           \
                          (uintptr_t)(i) * NPU_INSTR_STRIDE + 4u))

/* i is an instruction index, 0–1023. */
static inline void npu_instr_write(uint32_t i, uint64_t instruction) {
  NPU_INSTR_LO(i) = (uint32_t)instruction;
  NPU_INSTR_HI(i) = (uint32_t)((instruction >> 32) & 0xFu);
}

static inline uint64_t npu_instr_read(uint32_t i) {
  uint32_t lo = NPU_INSTR_LO(i);
  uint32_t hi = NPU_INSTR_HI(i);

  return ((uint64_t)(hi & 0xFu) << 32) | lo;
}

// Full register reads
#define NPU_READ_CONTROL() (*NPU_CSR)
#define NPU_READ_STATUS() (*NPU_STATUS)
#define NPU_READ_PC() (*NPU_PC_IDX & 0x3FFu)
#define NPU_READ_IRQ_ADDR() (*NPU_IRQ_ADDR & 0xFFFu)

// CONTROL fields
#define NPU_RUN_ENABLED() ((NPU_READ_CONTROL() & (1u << 0)) != 0u)

// STATUS fields
#define NPU_IS_HALTED() ((NPU_READ_STATUS() & (1u << 0)) != 0u)

#define NPU_RUN_REQUESTED() ((NPU_READ_STATUS() & (1u << 1)) != 0u)

#define NPU_HAS_AXIL_MEM() ((NPU_READ_STATUS() & (1u << 2)) != 0u)

#define NPU_RESET_BUSY() ((NPU_READ_STATUS() & (1u << 3)) != 0u)

#define NPU_IRQ_PENDING() ((NPU_READ_STATUS() & (1u << 4)) != 0u)

#define NPU_MODE_PENDING() ((NPU_READ_STATUS() & (1u << 5)) != 0u)

// Memory reads: i is a 32-bit word index
#define NPU_READ_WEIGHT(i) (NPU_WEIGHT_BASE[(i)])
#define NPU_READ_SCRATCHPAD(i) (NPU_SCRATCHPAD_BASE[(i)])

#define NPU_START() (*NPU_CSR = (1u << 0))
#define NPU_HALT() (*NPU_CSR = 0u)
#define NPU_RESET() (*NPU_CSR = (1u << 1))

// Clear interrupt while preserving the current RUN setting
#define NPU_CLEAR_IRQ() (*NPU_CSR = (*NPU_CSR & 1u) | (1u << 3))

#endif
