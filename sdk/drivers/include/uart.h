#include <stdint.h>

#ifndef UART_H
#define UART_H

// UART Base Address
#define UART_BASE 0x20002000

// Register Memory Map
#define UART_RX_FIFO ((volatile uint32_t *)(UART_BASE + 0x00))
#define UART_TX_FIFO ((volatile uint32_t *)(UART_BASE + 0x04))
#define UART_STATUS ((volatile uint32_t *)(UART_BASE + 0x08))
#define UART_CTRL ((volatile uint32_t *)(UART_BASE + 0x0C))
#define UART_IRQ_EN ((volatile uint32_t *)(UART_BASE + 0x10))
#define UART_IRQ_STATUS ((volatile uint32_t *)(UART_BASE + 0x14))

// Status Register Bitmasks
#define STATUS_RX_AVAIL (1 << 0)
#define STATUS_RX_FULL (1 << 1)
#define STATUS_TX_EMPTY (1 << 2)
#define STATUS_TX_FULL (1 << 3)
#define STATUS_BOOT_ACTIVE (1 << 4)
#define STATUS_RX_OVERRUN (1 << 5)
#define STATUS_FRAMING_ERR (1 << 6)

// Control Register Bitmasks
#define CTRL_RST_TX (1 << 0)
#define CTRL_RST_RX (1 << 1)
#define CTRL_CLR_ERRORS (1 << 2)

// IRQ CTRL
#define IRQ_RX_AVAIL (1 << 0)
#define IRQ_TX_EMPTY (1 << 1)
#define IRQ_RX_OVERRUN (1 << 2)
#define IRQ_FRAME_ERROR (1 << 3)

// puts one char to tx
void uart_putc(char c);

// get the char from rx
char uart_getc(void);

// put string to tx
void uart_puts(const char *str);

void uart_isr(void);
void uart_init();

void uart_polled_putc(char c);
void uart_polled_puts(const char *str);
void uart_print_hex(const char *prefix, uint32_t val);

#endif
