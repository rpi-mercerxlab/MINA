#include <stdint.h>
#include <stdlib.h>

#ifndef GPIO_H
#define GPIO_H

#define GPIO_BASE 0x20003000

// Register Memory Map
#define GPIO_IO ((volatile uint32_t *)(GPIO_BASE + 0x00))
#define GPIO_T ((volatile uint32_t *)(GPIO_BASE + 0x04))

#define HIGH 1
#define LOW 0

// define interrupt registers later

void set_input(int gpio_num);
void set_output(int gpio_num);
void set_state(int gpio_num, int val);
void get_state(int gpio_num, int val);

#endif
