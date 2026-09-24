#include "../include/gpio.h"

void set_input(int gpio_num) { *GPIO_T |= (1 << gpio_num); }
void set_output(int gpio_num) { *GPIO_T &= ~(1 << gpio_num); }
