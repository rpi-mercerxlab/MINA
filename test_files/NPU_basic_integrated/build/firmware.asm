
/tmp/mina_build_ozkNlV/firmware.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
.section .text.init
.global _start

_start:
    /* 1. Disable interrupts globally (good practice before setup) */
    csrw mstatus, zero
   0:	30001073          	csrw	mstatus,zero
    
    /* 2. Set up the Global Pointer */
    .option push
    .option norelax
    la gp, __global_pointer$
   4:	10001197          	auipc	gp,0x10001
   8:	83c18193          	addi	gp,gp,-1988 # 10000840 <__global_pointer$>
    .option pop

    /* 3. Set up the Stack Pointer */
    la sp, _stack_top
   c:	10010117          	auipc	sp,0x10010
  10:	ff410113          	addi	sp,sp,-12 # 10010000 <_stack_top>

    /* 4. Copy .data from SHARED_RAM to CPU_RAM */
    la a0, _data_load_start /* Source address */
  14:	00001517          	auipc	a0,0x1
  18:	c9c50513          	addi	a0,a0,-868 # cb0 <_data_load_start>
    la a1, _sdata           /* Destination address */
  1c:	10000597          	auipc	a1,0x10000
  20:	fe458593          	addi	a1,a1,-28 # 10000000 <plic_idx_sort>
    la a2, _edata           /* End of destination */
  24:	10000617          	auipc	a2,0x10000
  28:	01c60613          	addi	a2,a2,28 # 10000040 <npu_done_flag>
    bgeu a1, a2, end_copy_data /* Skip if no data */
  2c:	00c5fa63          	bgeu	a1,a2,40 <end_copy_data>

00000030 <copy_data_loop>:
copy_data_loop:
    lw t0, 0(a0)            /* Load word from SHARED_RAM */
  30:	00052283          	lw	t0,0(a0)
    sw t0, 0(a1)            /* Store word to CPU_RAM */
  34:	0055a023          	sw	t0,0(a1)
    addi a0, a0, 4          /* Increment source pointer */
  38:	0511                	addi	a0,a0,4
    addi a1, a1, 4          /* Increment destination pointer */
  3a:	0591                	addi	a1,a1,4
    bltu a1, a2, copy_data_loop
  3c:	fec5eae3          	bltu	a1,a2,30 <copy_data_loop>

00000040 <end_copy_data>:
end_copy_data:

    /* 5. Zero out the .bss section in CPU_RAM */
    la a0, _sbss
  40:	10000517          	auipc	a0,0x10000
  44:	00050513          	mv	a0,a0
    la a1, _ebss
  48:	10001597          	auipc	a1,0x10001
  4c:	93058593          	addi	a1,a1,-1744 # 10000978 <_ebss>
    bgeu a0, a1, end_clear_bss /* Skip if no bss */
  50:	00b57763          	bgeu	a0,a1,5e <end_clear_bss>

00000054 <clear_bss_loop>:
clear_bss_loop:
    sw zero, 0(a0)
  54:	00052023          	sw	zero,0(a0) # 10000040 <npu_done_flag>
    addi a0, a0, 4
  58:	0511                	addi	a0,a0,4
    bltu a0, a1, clear_bss_loop
  5a:	feb56de3          	bltu	a0,a1,54 <clear_bss_loop>

0000005e <end_clear_bss>:
end_clear_bss:

    /* 6. Jump to main C function */
    call main
  5e:	22f9                	jal	22c <main>

00000060 <inf_loop>:

    /* 7. Catch return from main (should not happen in bare-metal) */
inf_loop:
    j inf_loop
  60:	a001                	j	60 <inf_loop>

00000062 <fill_matrix>:
 */
static void fill_matrix(void) {
  volatile uint32_t *dst =
      NPU_SCRATCHPAD_BASE + (NPU_SOURCE_OFFSET / sizeof(uint32_t));

  uint8_t base = simple_counter;
  62:	10000e37          	lui	t3,0x10000
  66:	044e4303          	lbu	t1,68(t3) # 10000044 <simple_counter>
  6a:	40300837          	lui	a6,0x40300
  for (uint32_t col = 0; col < MATRIX_DIM; ++col) {
  6e:	403008b7          	lui	a7,0x40300
  72:	00830793          	addi	a5,t1,8
  uint8_t base = simple_counter;
  76:	20080813          	addi	a6,a6,512 # 40300200 <_stack_top+0x302f0200>
  for (uint32_t col = 0; col < MATRIX_DIM; ++col) {
  7a:	24088893          	addi	a7,a7,576 # 40300240 <_stack_top+0x302f0240>
    for (uint32_t half = 0; half < 2u; ++half) {
      uint32_t packed = 0;
      for (uint32_t lane = 0; lane < 4u; ++lane) {
        uint32_t row = half * 4u + lane;
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  7e:	00878693          	addi	a3,a5,8
        packed |= ((uint32_t)val << (8u * lane));
  82:	07f7f613          	andi	a2,a5,127
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  86:	02078713          	addi	a4,a5,32
  8a:	02878513          	addi	a0,a5,40
        packed |= ((uint32_t)val << (8u * lane));
  8e:	07f6f693          	andi	a3,a3,127
  92:	0622                	slli	a2,a2,0x8
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  94:	ff878f13          	addi	t5,a5,-8
  98:	01078593          	addi	a1,a5,16
        packed |= ((uint32_t)val << (8u * lane));
  9c:	06c2                	slli	a3,a3,0x10
  9e:	07f77713          	andi	a4,a4,127
  a2:	07f57513          	andi	a0,a0,127
  a6:	8ed1                	or	a3,a3,a2
  a8:	0542                	slli	a0,a0,0x10
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  aa:	01878e93          	addi	t4,a5,24
  ae:	03078613          	addi	a2,a5,48
        packed |= ((uint32_t)val << (8u * lane));
  b2:	07ff7f13          	andi	t5,t5,127
  b6:	07f5f593          	andi	a1,a1,127
  ba:	0722                	slli	a4,a4,0x8
  bc:	01e6e6b3          	or	a3,a3,t5
  c0:	8f49                	or	a4,a4,a0
  c2:	05e2                	slli	a1,a1,0x18
  c4:	07fef513          	andi	a0,t4,127
  c8:	07f67613          	andi	a2,a2,127
  cc:	8dd5                	or	a1,a1,a3
  ce:	8f49                	or	a4,a4,a0
  d0:	01861693          	slli	a3,a2,0x18
      }
      dst[col * 2u + half] = packed;
  d4:	00b82023          	sw	a1,0(a6)
        packed |= ((uint32_t)val << (8u * lane));
  d8:	8f55                	or	a4,a4,a3
      dst[col * 2u + half] = packed;
  da:	00e82223          	sw	a4,4(a6)
  for (uint32_t col = 0; col < MATRIX_DIM; ++col) {
  de:	0821                	addi	a6,a6,8
  e0:	0785                	addi	a5,a5,1
  e2:	f9181ee3          	bne	a6,a7,7e <fill_matrix+0x1c>
    }
  }
  simple_counter = (uint8_t)((simple_counter + 64u) & 0x7Fu);
  e6:	04030793          	addi	a5,t1,64
  ea:	07f7f793          	andi	a5,a5,127
  ee:	04fe0223          	sb	a5,68(t3)
}
  f2:	8082                	ret

000000f4 <npu_irq_handler>:
  }
  uart_putc('\r');
  uart_putc('\n');
}

void npu_irq_handler(void) {
  f4:	7179                	addi	sp,sp,-48
  NPU_HALT();
  f6:	400006b7          	lui	a3,0x40000
void npu_irq_handler(void) {
  fa:	d606                	sw	ra,44(sp)
  fc:	d422                	sw	s0,40(sp)
  fe:	d226                	sw	s1,36(sp)
 100:	d04a                	sw	s2,32(sp)
 102:	ce4e                	sw	s3,28(sp)
 104:	cc52                	sw	s4,24(sp)
 106:	ca56                	sw	s5,20(sp)
 108:	c85a                	sw	s6,16(sp)
 10a:	c65e                	sw	s7,12(sp)
 10c:	c462                	sw	s8,8(sp)
 10e:	c266                	sw	s9,4(sp)
  NPU_HALT();
 110:	0006a023          	sw	zero,0(a3) # 40000000 <_stack_top+0x2fff0000>
  while (!NPU_IS_HALTED()) {
 114:	00468713          	addi	a4,a3,4
 118:	431c                	lw	a5,0(a4)
 11a:	8b85                	andi	a5,a5,1
 11c:	dff5                	beqz	a5,118 <npu_irq_handler+0x24>
  // 1. Halt NPU and wait for safe_halted so AXI-Lite owns Scratchpad RAM
  npu_wait_halted();

  // 2. Clear NPU interrupt line
  NPU_CLEAR_IRQ();
 11e:	429c                	lw	a5,0(a3)
 120:	40300b37          	lui	s6,0x40300
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 124:	ccccd4b7          	lui	s1,0xccccd
  NPU_CLEAR_IRQ();
 128:	8b85                	andi	a5,a5,1
 12a:	0087e793          	ori	a5,a5,8
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 12e:	51eb8bb7          	lui	s7,0x51eb8
  NPU_CLEAR_IRQ();
 132:	c29c                	sw	a5,0(a3)
 134:	408b0b13          	addi	s6,s6,1032 # 40300408 <_stack_top+0x302f0408>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 138:	ccd48493          	addi	s1,s1,-819 # cccccccd <_stack_top+0xbccbcccd>
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 13c:	51fb8b93          	addi	s7,s7,1311 # 51eb851f <_stack_top+0x41ea851f>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 140:	4c25                	li	s8,9
    for (uint32_t word = 0; word < 2u; ++word) {
 142:	ff8b0a93          	addi	s5,s6,-8
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 146:	06300a13          	li	s4,99
      uint32_t packed = src[row * 2u + word];
 14a:	000aa983          	lw	s3,0(s5)
 14e:	4c81                	li	s9,0
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 150:	02000913          	li	s2,32
        uint8_t value = (uint8_t)(packed >> (8u * lane));
 154:	0199d433          	srl	s0,s3,s9
 158:	0ff47413          	zext.b	s0,s0
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 15c:	02000513          	li	a0,32
 160:	0a8a7f63          	bgeu	s4,s0,21e <npu_irq_handler+0x12a>
 164:	03743533          	mulhu	a0,s0,s7
 168:	8115                	srli	a0,a0,0x5
 16a:	03050513          	addi	a0,a0,48
 16e:	25b000ef          	jal	bc8 <uart_putc>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 172:	02943533          	mulhu	a0,s0,s1
 176:	810d                	srli	a0,a0,0x3
 178:	02953733          	mulhu	a4,a0,s1
 17c:	830d                	srli	a4,a4,0x3
 17e:	00271793          	slli	a5,a4,0x2
 182:	97ba                	add	a5,a5,a4
 184:	0786                	slli	a5,a5,0x1
 186:	8d1d                	sub	a0,a0,a5
 188:	03050513          	addi	a0,a0,48
 18c:	0ff57513          	zext.b	a0,a0
 190:	239000ef          	jal	bc8 <uart_putc>
  uart_putc('0' + value % 10);
 194:	02943733          	mulhu	a4,s0,s1
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 198:	0ca1                	addi	s9,s9,8
  uart_putc('0' + value % 10);
 19a:	830d                	srli	a4,a4,0x3
 19c:	00271793          	slli	a5,a4,0x2
 1a0:	97ba                	add	a5,a5,a4
 1a2:	0786                	slli	a5,a5,0x1
 1a4:	40f40533          	sub	a0,s0,a5
 1a8:	03050513          	addi	a0,a0,48
 1ac:	0ff57513          	zext.b	a0,a0
 1b0:	219000ef          	jal	bc8 <uart_putc>
        uart_putc(' ');
 1b4:	02000513          	li	a0,32
 1b8:	211000ef          	jal	bc8 <uart_putc>
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 1bc:	f92c9ce3          	bne	s9,s2,154 <npu_irq_handler+0x60>
    for (uint32_t word = 0; word < 2u; ++word) {
 1c0:	0a91                	addi	s5,s5,4
 1c2:	f95b14e3          	bne	s6,s5,14a <npu_irq_handler+0x56>
    uart_putc('\r');
 1c6:	4535                	li	a0,13
 1c8:	201000ef          	jal	bc8 <uart_putc>
    uart_putc('\n');
 1cc:	4529                	li	a0,10
 1ce:	1fb000ef          	jal	bc8 <uart_putc>
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
 1d2:	403007b7          	lui	a5,0x40300
 1d6:	0b21                	addi	s6,s6,8
 1d8:	44878793          	addi	a5,a5,1096 # 40300448 <_stack_top+0x302f0448>
 1dc:	f6fb13e3          	bne	s6,a5,142 <npu_irq_handler+0x4e>
  uart_putc('\r');
 1e0:	4535                	li	a0,13
 1e2:	1e7000ef          	jal	bc8 <uart_putc>
  uart_putc('\n');
 1e6:	4529                	li	a0,10
 1e8:	1e1000ef          	jal	bc8 <uart_putc>

  // 3. Read result matrix C from 0x400 and print over UART
  print_matrix();

  // 4. Write next counter matrix A into 0x200
  fill_matrix();
 1ec:	3d9d                	jal	62 <fill_matrix>

  // 5. Reset NPU PC to 0 and restart execution
  NPU_RESET();
 1ee:	400006b7          	lui	a3,0x40000
 1f2:	4789                	li	a5,2
 1f4:	c29c                	sw	a5,0(a3)
  while (!NPU_IS_HALTED()) {
 1f6:	00468713          	addi	a4,a3,4 # 40000004 <_stack_top+0x2fff0004>
 1fa:	431c                	lw	a5,0(a4)
 1fc:	8b85                	andi	a5,a5,1
 1fe:	dff5                	beqz	a5,1fa <npu_irq_handler+0x106>
  }
  NPU_START();
}
 200:	50b2                	lw	ra,44(sp)
 202:	5422                	lw	s0,40(sp)
  NPU_START();
 204:	4785                	li	a5,1
 206:	c29c                	sw	a5,0(a3)
}
 208:	5492                	lw	s1,36(sp)
 20a:	5902                	lw	s2,32(sp)
 20c:	49f2                	lw	s3,28(sp)
 20e:	4a62                	lw	s4,24(sp)
 210:	4ad2                	lw	s5,20(sp)
 212:	4b42                	lw	s6,16(sp)
 214:	4bb2                	lw	s7,12(sp)
 216:	4c22                	lw	s8,8(sp)
 218:	4c92                	lw	s9,4(sp)
 21a:	6145                	addi	sp,sp,48
 21c:	8082                	ret
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 21e:	1ab000ef          	jal	bc8 <uart_putc>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 222:	02000513          	li	a0,32
 226:	f68c75e3          	bgeu	s8,s0,190 <npu_irq_handler+0x9c>
 22a:	b7a1                	j	172 <npu_irq_handler+0x7e>

0000022c <main>:
  while (i > 0) {
    uart_putc(buf[--i]);
  }
}

int main(void) {
 22c:	7179                	addi	sp,sp,-48
 22e:	d606                	sw	ra,44(sp)
 230:	d422                	sw	s0,40(sp)
 232:	d226                	sw	s1,36(sp)
 234:	d04a                	sw	s2,32(sp)
 236:	ce4e                	sw	s3,28(sp)
 238:	cc52                	sw	s4,24(sp)
  init_interrupts();
 23a:	286d                	jal	2f4 <init_interrupts>
  uart_init();
 23c:	159000ef          	jal	b94 <uart_init>
  reg_NPU_irq(npu_irq_handler, 1);
 240:	0f400513          	li	a0,244
 244:	4691                	li	a3,4
 246:	4641                	li	a2,16
 248:	4585                	li	a1,1
 24a:	2e51                	jal	5de <reg_irq_handler>

  uart_puts("Starting program, loaded interrupts\n");
 24c:	6505                	lui	a0,0x1
 24e:	c7050513          	addi	a0,a0,-912 # c70 <uart_puts+0x20>
 252:	1ff000ef          	jal	c50 <uart_puts>

  // Ensure NPU is halted and reset before touching Scratchpad RAM
  NPU_RESET();
 256:	40000437          	lui	s0,0x40000
 25a:	4709                	li	a4,2
 25c:	c018                	sw	a4,0(s0)
  while (!NPU_IS_HALTED()) {
 25e:	00440793          	addi	a5,s0,4 # 40000004 <_stack_top+0x2fff0004>
 262:	4398                	lw	a4,0(a5)
 264:	8b05                	andi	a4,a4,1
 266:	df75                	beqz	a4,262 <main+0x36>
  }

  // Load initial Matrix A into Scratchpad at offset 0x200
  fill_matrix();
 268:	3bed                	jal	62 <fill_matrix>

  // Start NPU execution from PC = 0
  NPU_START();
 26a:	4785                	li	a5,1
 26c:	c01c                	sw	a5,0(s0)

  uint32_t counter = 0;
 26e:	6985                	lui	s3,0x1
    buf[i++] = '0' + (val % 10);
 270:	ccccd437          	lui	s0,0xccccd
 274:	00e10913          	addi	s2,sp,14
 278:	00310493          	addi	s1,sp,3

  while (1) {
    counter++;
    if (counter == 100000000) {
      uart_puts("Program counter, NPU: ");
 27c:	c9898993          	addi	s3,s3,-872 # c98 <uart_puts+0x48>
    buf[i++] = '0' + (val % 10);
 280:	ccd40413          	addi	s0,s0,-819 # cccccccd <_stack_top+0xbccbcccd>
      uart_puts("Program counter, NPU: ");
 284:	854e                	mv	a0,s3
 286:	1cb000ef          	jal	c50 <uart_puts>
 28a:	400007b7          	lui	a5,0x40000
 28e:	0050                	addi	a2,sp,4
 290:	07a1                	addi	a5,a5,8 # 40000008 <_stack_top+0x2fff0008>
    buf[i++] = '0' + (val % 10);
 292:	0287b733          	mulhu	a4,a5,s0
  while (val > 0) {
 296:	0605                	addi	a2,a2,1
    buf[i++] = '0' + (val % 10);
 298:	830d                	srli	a4,a4,0x3
 29a:	00271693          	slli	a3,a4,0x2
 29e:	96ba                	add	a3,a3,a4
 2a0:	0686                	slli	a3,a3,0x1
 2a2:	8f95                	sub	a5,a5,a3
 2a4:	03078793          	addi	a5,a5,48
 2a8:	fef60fa3          	sb	a5,-1(a2)
    val /= 10;
 2ac:	87ba                	mv	a5,a4
  while (val > 0) {
 2ae:	fec912e3          	bne	s2,a2,292 <main+0x66>
  while (i > 0) {
 2b2:	00d10a13          	addi	s4,sp,13
    uart_putc(buf[--i]);
 2b6:	000a4503          	lbu	a0,0(s4)
  while (i > 0) {
 2ba:	1a7d                	addi	s4,s4,-1
    uart_putc(buf[--i]);
 2bc:	10d000ef          	jal	bc8 <uart_putc>
  while (i > 0) {
 2c0:	ff449be3          	bne	s1,s4,2b6 <main+0x8a>

      uart_print_u32((int)NPU_PC_IDX);

      uart_putc('\n');
 2c4:	4529                	li	a0,10
 2c6:	103000ef          	jal	bc8 <uart_putc>
      counter = 0;
 2ca:	bf6d                	j	284 <main+0x58>

000002cc <set_input>:
#include "../include/gpio.h"

void set_input(int gpio_num) { *GPIO_T |= (1 << gpio_num); }
 2cc:	20003737          	lui	a4,0x20003
 2d0:	4354                	lw	a3,4(a4)
 2d2:	4785                	li	a5,1
 2d4:	00a797b3          	sll	a5,a5,a0
 2d8:	8fd5                	or	a5,a5,a3
 2da:	c35c                	sw	a5,4(a4)
 2dc:	8082                	ret

000002de <set_output>:
void set_output(int gpio_num) { *GPIO_T &= ~(1 << gpio_num); }
 2de:	20003737          	lui	a4,0x20003
 2e2:	4354                	lw	a3,4(a4)
 2e4:	4785                	li	a5,1
 2e6:	00a797b3          	sll	a5,a5,a0
 2ea:	fff7c793          	not	a5,a5
 2ee:	8ff5                	and	a5,a5,a3
 2f0:	c35c                	sw	a5,4(a4)
 2f2:	8082                	ret

000002f4 <init_interrupts>:
int plic_idx_sort[8] = {0, 1, 2, 3, 4, 5, 6, 7};
void (*timer_irq_handler)(void) = NULL;

void init_interrupts(void) {
  // A. Point mtvec to our handler (Direct mode: lowest 2 bits are 00)
  write_csr(mtvec, (unsigned long)trap_handler);
 2f4:	38c00793          	li	a5,908
 2f8:	30579073          	csrw	mtvec,a5

  // B. Enable Machine External Interrupts in the 'mie' register
  set_csr(mie, MIE_MEIE);
 2fc:	6785                	lui	a5,0x1
 2fe:	80078793          	addi	a5,a5,-2048 # 800 <_deactivate_timer.part.0+0x6>
 302:	3047a7f3          	csrrs	a5,mie,a5

  // C. Enable Global Machine Interrupts in the 'mstatus' register
  set_csr(mstatus, MSTATUS_MIE);
 306:	300467f3          	csrrsi	a5,mstatus,8
}
 30a:	8082                	ret

0000030c <plic_irq_handler>:
  } else {
    // Handle synchronous exceptions (faults, illegal instructions, ecalls) here
  }
}

void plic_irq_handler(void) {
 30c:	7179                	addi	sp,sp,-48

  uint32_t pending = *PLIC_IRQ_PEND;
 30e:	200007b7          	lui	a5,0x20000
void plic_irq_handler(void) {
 312:	c85a                	sw	s6,16(sp)
 314:	c65e                	sw	s7,12(sp)
 316:	10000b37          	lui	s6,0x10000
  uint32_t pending = *PLIC_IRQ_PEND;
 31a:	0047ab83          	lw	s7,4(a5) # 20000004 <_stack_top+0xfff0004>

  for (int i = 0; i < 8; i++) {
 31e:	000b0b13          	mv	s6,s6
void plic_irq_handler(void) {
 322:	d04a                	sw	s2,32(sp)
 324:	ca56                	sw	s5,20(sp)
          plic_irq_priorities[current_idx] != -1) {
        plic_irq_handlers[current_idx]();

        // THIS ASSUMES THE HANDLER CLEARS THE STATE CAUSING THE INTERRUPT,
        // OTHERWISE THE IRQ WILL TRIGGER AGAIN
        *PLIC_CLAIM_REG = 1 << current_idx;
 326:	20000ab7          	lui	s5,0x20000
void plic_irq_handler(void) {
 32a:	d226                	sw	s1,36(sp)
 32c:	ce4e                	sw	s3,28(sp)
 32e:	cc52                	sw	s4,24(sp)
 330:	c462                	sw	s8,8(sp)
 332:	d606                	sw	ra,44(sp)
 334:	d422                	sw	s0,40(sp)
 336:	84da                	mv	s1,s6
 338:	020b0a13          	addi	s4,s6,32 # 10000020 <plic_irq_priorities>
      if (plic_irq_handlers[current_idx] &&
 33c:	81018913          	addi	s2,gp,-2032 # 10000050 <plic_irq_handlers>
        *PLIC_CLAIM_REG = 1 << current_idx;
 340:	0aa1                	addi	s5,s5,8 # 20000008 <_stack_top+0xfff0008>
    if ((pending & (1 << current_idx)) != 0) {
 342:	4985                	li	s3,1
      if (plic_irq_handlers[current_idx] &&
 344:	5c7d                	li	s8,-1
    int current_idx = plic_idx_sort[i];
 346:	409c                	lw	a5,0(s1)
    if ((pending & (1 << current_idx)) != 0) {
 348:	00f99433          	sll	s0,s3,a5
      if (plic_irq_handlers[current_idx] &&
 34c:	00279713          	slli	a4,a5,0x2
    if ((pending & (1 << current_idx)) != 0) {
 350:	017477b3          	and	a5,s0,s7
      if (plic_irq_handlers[current_idx] &&
 354:	00e906b3          	add	a3,s2,a4
    if ((pending & (1 << current_idx)) != 0) {
 358:	cb91                	beqz	a5,36c <plic_irq_handler+0x60>
      if (plic_irq_handlers[current_idx] &&
 35a:	429c                	lw	a5,0(a3)
          plic_irq_priorities[current_idx] != -1) {
 35c:	975a                	add	a4,a4,s6
      if (plic_irq_handlers[current_idx] &&
 35e:	c799                	beqz	a5,36c <plic_irq_handler+0x60>
 360:	5318                	lw	a4,32(a4)
 362:	01870563          	beq	a4,s8,36c <plic_irq_handler+0x60>
        plic_irq_handlers[current_idx]();
 366:	9782                	jalr	a5
        *PLIC_CLAIM_REG = 1 << current_idx;
 368:	008aa023          	sw	s0,0(s5)
  for (int i = 0; i < 8; i++) {
 36c:	0491                	addi	s1,s1,4
 36e:	fd449ce3          	bne	s1,s4,346 <plic_irq_handler+0x3a>
      }
    }
  }
}
 372:	50b2                	lw	ra,44(sp)
 374:	5422                	lw	s0,40(sp)
 376:	5492                	lw	s1,36(sp)
 378:	5902                	lw	s2,32(sp)
 37a:	49f2                	lw	s3,28(sp)
 37c:	4a62                	lw	s4,24(sp)
 37e:	4ad2                	lw	s5,20(sp)
 380:	4b42                	lw	s6,16(sp)
 382:	4bb2                	lw	s7,12(sp)
 384:	4c22                	lw	s8,8(sp)
 386:	6145                	addi	sp,sp,48
 388:	8082                	ret
 38a:	0001                	nop

0000038c <trap_handler>:
void __attribute__((interrupt("machine"), aligned(4))) trap_handler(void) {
 38c:	7139                	addi	sp,sp,-64
 38e:	de06                	sw	ra,60(sp)
 390:	dc16                	sw	t0,56(sp)
 392:	da1a                	sw	t1,52(sp)
 394:	d81e                	sw	t2,48(sp)
 396:	d62a                	sw	a0,44(sp)
 398:	d42e                	sw	a1,40(sp)
 39a:	d232                	sw	a2,36(sp)
 39c:	d036                	sw	a3,32(sp)
 39e:	ce3a                	sw	a4,28(sp)
 3a0:	cc3e                	sw	a5,24(sp)
 3a2:	ca42                	sw	a6,20(sp)
 3a4:	c846                	sw	a7,16(sp)
 3a6:	c672                	sw	t3,12(sp)
 3a8:	c476                	sw	t4,8(sp)
 3aa:	c27a                	sw	t5,4(sp)
 3ac:	c07e                	sw	t6,0(sp)
  unsigned long cause = read_csr(mcause);
 3ae:	342027f3          	csrr	a5,mcause
  if ((long)cause < 0) {
 3b2:	0207c563          	bltz	a5,3dc <trap_handler+0x50>
}
 3b6:	50f2                	lw	ra,60(sp)
 3b8:	52e2                	lw	t0,56(sp)
 3ba:	5352                	lw	t1,52(sp)
 3bc:	53c2                	lw	t2,48(sp)
 3be:	5532                	lw	a0,44(sp)
 3c0:	55a2                	lw	a1,40(sp)
 3c2:	5612                	lw	a2,36(sp)
 3c4:	5682                	lw	a3,32(sp)
 3c6:	4772                	lw	a4,28(sp)
 3c8:	47e2                	lw	a5,24(sp)
 3ca:	4852                	lw	a6,20(sp)
 3cc:	48c2                	lw	a7,16(sp)
 3ce:	4e32                	lw	t3,12(sp)
 3d0:	4ea2                	lw	t4,8(sp)
 3d2:	4f12                	lw	t5,4(sp)
 3d4:	4f82                	lw	t6,0(sp)
 3d6:	6121                	addi	sp,sp,64
 3d8:	30200073          	mret
    unsigned long exception_code = cause & ~(1UL << (sizeof(long) * 8 - 1));
 3dc:	0786                	slli	a5,a5,0x1
 3de:	8385                	srli	a5,a5,0x1
    if (exception_code == IRQ_M_EXT) {
 3e0:	472d                	li	a4,11
 3e2:	00e78c63          	beq	a5,a4,3fa <trap_handler+0x6e>
    } else if (exception_code == IRQ_M_TIMER) {
 3e6:	471d                	li	a4,7
 3e8:	fce797e3          	bne	a5,a4,3b6 <trap_handler+0x2a>
      if (timer_irq_handler) {
 3ec:	100007b7          	lui	a5,0x10000
 3f0:	0487a783          	lw	a5,72(a5) # 10000048 <timer_irq_handler>
 3f4:	d3e9                	beqz	a5,3b6 <trap_handler+0x2a>
        timer_irq_handler();
 3f6:	9782                	jalr	a5
}
 3f8:	bf7d                	j	3b6 <trap_handler+0x2a>
      plic_irq_handler();
 3fa:	3f09                	jal	30c <plic_irq_handler>
 3fc:	bf6d                	j	3b6 <trap_handler+0x2a>

000003fe <resort_by_prior>:
  *PLIC_IRQ_ACTV |= actv_mask;

  resort_by_prior();
}

void resort_by_prior() {
 3fe:	1141                	addi	sp,sp,-16

  for (int i = 0; i < 8; i++) {
    plic_idx_sort[i] = i;
 400:	100007b7          	lui	a5,0x10000
 404:	00078793          	mv	a5,a5
void resort_by_prior() {
 408:	c622                	sw	s0,12(sp)
 40a:	c426                	sw	s1,8(sp)
 40c:	c24a                	sw	s2,4(sp)
 40e:	c04e                	sw	s3,0(sp)
    plic_idx_sort[i] = i;
 410:	4709                	li	a4,2
 412:	c798                	sw	a4,8(a5)
 414:	470d                	li	a4,3
 416:	c7d8                	sw	a4,12(a5)
 418:	4711                	li	a4,4
 41a:	cb98                	sw	a4,16(a5)
 41c:	4715                	li	a4,5
 41e:	cbd8                	sw	a4,20(a5)
 420:	4719                	li	a4,6
 422:	cf98                	sw	a4,24(a5)
  }

  // 19-Comparator Sorting Network for N=8
  // Layer 1
  CS(0, 1);
 424:	0207a283          	lw	t0,32(a5) # 10000020 <plic_irq_priorities>
    plic_idx_sort[i] = i;
 428:	471d                	li	a4,7
  CS(0, 1);
 42a:	53c4                	lw	s1,36(a5)
    plic_idx_sort[i] = i;
 42c:	cfd8                	sw	a4,28(a5)
 42e:	4705                	li	a4,1
 430:	0007a023          	sw	zero,0(a5)
 434:	c3d8                	sw	a4,4(a5)
  CS(0, 1);
 436:	8eba                	mv	t4,a4
 438:	4401                	li	s0,0
 43a:	0092da63          	bge	t0,s1,44e <resort_by_prior+0x50>
 43e:	8696                	mv	a3,t0
 440:	c398                	sw	a4,0(a5)
 442:	82a6                	mv	t0,s1
 444:	0007a223          	sw	zero,4(a5)
 448:	84b6                	mv	s1,a3
 44a:	843a                	mv	s0,a4
 44c:	4e81                	li	t4,0
  CS(2, 3);
 44e:	578c                	lw	a1,40(a5)
 450:	57d8                	lw	a4,44(a5)
 452:	4f0d                	li	t5,3
 454:	4809                	li	a6,2
 456:	00e5db63          	bge	a1,a4,46c <resort_by_prior+0x6e>
 45a:	86ae                	mv	a3,a1
 45c:	01e7a423          	sw	t5,8(a5)
 460:	0107a623          	sw	a6,12(a5)
 464:	85ba                	mv	a1,a4
 466:	8f42                	mv	t5,a6
 468:	8736                	mv	a4,a3
 46a:	480d                	li	a6,3
  CS(4, 5);
 46c:	5b94                	lw	a3,48(a5)
 46e:	5bd0                	lw	a2,52(a5)
 470:	4e15                	li	t3,5
 472:	4311                	li	t1,4
 474:	00c6db63          	bge	a3,a2,48a <resort_by_prior+0x8c>
 478:	8536                	mv	a0,a3
 47a:	01c7a823          	sw	t3,16(a5)
 47e:	0067aa23          	sw	t1,20(a5)
 482:	86b2                	mv	a3,a2
 484:	8e1a                	mv	t3,t1
 486:	862a                	mv	a2,a0
 488:	4315                	li	t1,5
  CS(6, 7);
 48a:	5f88                	lw	a0,56(a5)
 48c:	03c7af83          	lw	t6,60(a5)
 490:	439d                	li	t2,7
 492:	4899                	li	a7,6
 494:	01f55b63          	bge	a0,t6,4aa <resort_by_prior+0xac>
 498:	892a                	mv	s2,a0
 49a:	0077ac23          	sw	t2,24(a5)
 49e:	0117ae23          	sw	a7,28(a5)
 4a2:	857e                	mv	a0,t6
 4a4:	83c6                	mv	t2,a7
 4a6:	8fca                	mv	t6,s2
 4a8:	489d                	li	a7,7
  // Layer 2
  CS(0, 2);
 4aa:	00b2db63          	bge	t0,a1,4c0 <resort_by_prior+0xc2>
 4ae:	89ae                	mv	s3,a1
 4b0:	8942                	mv	s2,a6
 4b2:	0107a023          	sw	a6,0(a5)
 4b6:	c780                	sw	s0,8(a5)
 4b8:	8596                	mv	a1,t0
 4ba:	8822                	mv	a6,s0
 4bc:	82ce                	mv	t0,s3
 4be:	844a                	mv	s0,s2
  CS(1, 3);
 4c0:	00e4dc63          	bge	s1,a4,4d8 <resort_by_prior+0xda>
 4c4:	89a6                	mv	s3,s1
 4c6:	8976                	mv	s2,t4
 4c8:	01d7a623          	sw	t4,12(a5)
 4cc:	01e7a223          	sw	t5,4(a5)
 4d0:	84ba                	mv	s1,a4
 4d2:	8efa                	mv	t4,t5
 4d4:	874e                	mv	a4,s3
 4d6:	8f4a                	mv	t5,s2
  CS(4, 6);
 4d8:	00a6dc63          	bge	a3,a0,4f0 <resort_by_prior+0xf2>
 4dc:	89aa                	mv	s3,a0
 4de:	8946                	mv	s2,a7
 4e0:	0117a823          	sw	a7,16(a5)
 4e4:	0067ac23          	sw	t1,24(a5)
 4e8:	8536                	mv	a0,a3
 4ea:	889a                	mv	a7,t1
 4ec:	86ce                	mv	a3,s3
 4ee:	834a                	mv	t1,s2
  CS(5, 7);
 4f0:	01f65c63          	bge	a2,t6,508 <resort_by_prior+0x10a>
 4f4:	89b2                	mv	s3,a2
 4f6:	8972                	mv	s2,t3
 4f8:	01c7ae23          	sw	t3,28(a5)
 4fc:	0077aa23          	sw	t2,20(a5)
 500:	867e                	mv	a2,t6
 502:	8e1e                	mv	t3,t2
 504:	8fce                	mv	t6,s3
 506:	83ca                	mv	t2,s2
  // Layer 3
  CS(1, 2);
 508:	00b4dc63          	bge	s1,a1,520 <resort_by_prior+0x122>
 50c:	89a6                	mv	s3,s1
 50e:	8976                	mv	s2,t4
 510:	01d7a423          	sw	t4,8(a5)
 514:	0107a223          	sw	a6,4(a5)
 518:	84ae                	mv	s1,a1
 51a:	8ec2                	mv	t4,a6
 51c:	85ce                	mv	a1,s3
 51e:	884a                	mv	a6,s2
  CS(5, 6);
 520:	00a65c63          	bge	a2,a0,538 <resort_by_prior+0x13a>
 524:	89b2                	mv	s3,a2
 526:	8972                	mv	s2,t3
 528:	01c7ac23          	sw	t3,24(a5)
 52c:	0117aa23          	sw	a7,20(a5)
 530:	862a                	mv	a2,a0
 532:	8e46                	mv	t3,a7
 534:	854e                	mv	a0,s3
 536:	88ca                	mv	a7,s2
  CS(0, 4);
 538:	00d2d763          	bge	t0,a3,546 <resort_by_prior+0x148>
 53c:	0067a023          	sw	t1,0(a5)
 540:	cb80                	sw	s0,16(a5)
 542:	8696                	mv	a3,t0
 544:	8322                	mv	t1,s0
  CS(3, 7);
 546:	01f75863          	bge	a4,t6,556 <resort_by_prior+0x158>
 54a:	01e7ae23          	sw	t5,28(a5)
 54e:	0077a623          	sw	t2,12(a5)
 552:	877e                	mv	a4,t6
 554:	8f1e                	mv	t5,t2
  // Layer 4
  CS(1, 5);
 556:	00c4dc63          	bge	s1,a2,56e <resort_by_prior+0x170>
 55a:	82a6                	mv	t0,s1
 55c:	8ff6                	mv	t6,t4
 55e:	01d7aa23          	sw	t4,20(a5)
 562:	01c7a223          	sw	t3,4(a5)
 566:	84b2                	mv	s1,a2
 568:	8ef2                	mv	t4,t3
 56a:	8616                	mv	a2,t0
 56c:	8e7e                	mv	t3,t6
  CS(2, 6);
 56e:	00a5dc63          	bge	a1,a0,586 <resort_by_prior+0x188>
 572:	82aa                	mv	t0,a0
 574:	8fc6                	mv	t6,a7
 576:	0117a423          	sw	a7,8(a5)
 57a:	0107ac23          	sw	a6,24(a5)
 57e:	852e                	mv	a0,a1
 580:	88c2                	mv	a7,a6
 582:	8596                	mv	a1,t0
 584:	887e                	mv	a6,t6
  // Layer 5
  CS(1, 4);
 586:	00d4d863          	bge	s1,a3,596 <resort_by_prior+0x198>
 58a:	0067a223          	sw	t1,4(a5)
 58e:	01d7a823          	sw	t4,16(a5)
 592:	86a6                	mv	a3,s1
 594:	8376                	mv	t1,t4
  CS(3, 6);
 596:	00a75863          	bge	a4,a0,5a6 <resort_by_prior+0x1a8>
 59a:	01e7ac23          	sw	t5,24(a5)
 59e:	0117a623          	sw	a7,12(a5)
 5a2:	872a                	mv	a4,a0
 5a4:	8f46                	mv	t5,a7
  // Layer 6
  CS(2, 4);
 5a6:	00d5d863          	bge	a1,a3,5b6 <resort_by_prior+0x1b8>
 5aa:	0067a423          	sw	t1,8(a5)
 5ae:	0107a823          	sw	a6,16(a5)
 5b2:	86ae                	mv	a3,a1
 5b4:	8342                	mv	t1,a6
  CS(3, 5);
 5b6:	00c75863          	bge	a4,a2,5c6 <resort_by_prior+0x1c8>
 5ba:	01e7aa23          	sw	t5,20(a5)
 5be:	01c7a623          	sw	t3,12(a5)
 5c2:	8732                	mv	a4,a2
 5c4:	8f72                	mv	t5,t3
  // Layer 7
  CS(3, 4);
 5c6:	00d75663          	bge	a4,a3,5d2 <resort_by_prior+0x1d4>
 5ca:	0067a623          	sw	t1,12(a5)
 5ce:	01e7a823          	sw	t5,16(a5)
}
 5d2:	4432                	lw	s0,12(sp)
 5d4:	44a2                	lw	s1,8(sp)
 5d6:	4912                	lw	s2,4(sp)
 5d8:	4982                	lw	s3,0(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret

000005de <reg_irq_handler>:
  *PLIC_IRQ_ACTV |= actv_mask;
 5de:	200008b7          	lui	a7,0x20000
 5e2:	0008a803          	lw	a6,0(a7) # 20000000 <_stack_top+0xfff0000>
  plic_irq_priorities[arr_idx] = priority;
 5e6:	100007b7          	lui	a5,0x10000
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 5ea:	068a                	slli	a3,a3,0x2
 5ec:	81018713          	addi	a4,gp,-2032 # 10000050 <plic_irq_handlers>
  plic_irq_priorities[arr_idx] = priority;
 5f0:	00078793          	mv	a5,a5
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 5f4:	9736                	add	a4,a4,a3
  plic_irq_priorities[arr_idx] = priority;
 5f6:	97b6                	add	a5,a5,a3
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 5f8:	c308                	sw	a0,0(a4)
  plic_irq_priorities[arr_idx] = priority;
 5fa:	d38c                	sw	a1,32(a5)
  *PLIC_IRQ_ACTV |= actv_mask;
 5fc:	00c86833          	or	a6,a6,a2
 600:	0108a023          	sw	a6,0(a7)
  resort_by_prior();
 604:	bbed                	j	3fe <resort_by_prior>

00000606 <reg_timer_irq>:

void reg_timer_irq(void (*_timer_irq_handler)(void)) {
  timer_irq_handler = _timer_irq_handler;
 606:	100007b7          	lui	a5,0x10000
 60a:	04a7a423          	sw	a0,72(a5) # 10000048 <timer_irq_handler>
}
 60e:	8082                	ret

00000610 <init_ring_buffer>:
#include "../include/ring_buff.h"

void init_ring_buffer(ring_buffer_t *rb) {
  // No malloc needed! The memory is already allocated as part of the struct.
  rb->head = 0;
 610:	10050023          	sb	zero,256(a0)
  rb->tail = 0;
 614:	100500a3          	sb	zero,257(a0)
}
 618:	8082                	ret

0000061a <reset_ring_buffer>:

void reset_ring_buffer(ring_buffer_t *rb) {
 61a:	10050023          	sb	zero,256(a0)
 61e:	100500a3          	sb	zero,257(a0)
 622:	8082                	ret

00000624 <insert_rb>:
}

bool insert_rb(ring_buffer_t *rb, char c) {
  // Calculate what the next head position will be.
  // uint8_t naturally wraps from 255 back to 0.
  uint8_t next_head = (uint8_t)(rb->head + 1);
 624:	10054703          	lbu	a4,256(a0)

  // If the next head hits the tail, the buffer is full.
  // Note: This design sacrifices 1 byte of capacity, holding a max of 255
  // items.
  if (next_head == rb->tail) {
 628:	10154683          	lbu	a3,257(a0)
  uint8_t next_head = (uint8_t)(rb->head + 1);
 62c:	00170793          	addi	a5,a4,1 # 20003001 <_stack_top+0xfff3001>
 630:	0ff7f793          	zext.b	a5,a5
  if (next_head == rb->tail) {
 634:	00f68963          	beq	a3,a5,646 <insert_rb+0x22>
    return false;
  }

  rb->buffer[rb->head] = c;
 638:	972a                	add	a4,a4,a0
 63a:	00b70023          	sb	a1,0(a4)
  rb->head = next_head;
 63e:	10f50023          	sb	a5,256(a0)

  return true;
 642:	4505                	li	a0,1
 644:	8082                	ret
    return false;
 646:	4501                	li	a0,0
}
 648:	8082                	ret

0000064a <pop_rb>:

bool pop_rb(ring_buffer_t *rb, char *c) {
  // If head and tail are at the same position, the buffer is empty.
  if (rb->head == rb->tail) {
 64a:	10154703          	lbu	a4,257(a0)
 64e:	10054683          	lbu	a3,256(a0)
bool pop_rb(ring_buffer_t *rb, char *c) {
 652:	87aa                	mv	a5,a0
  if (rb->head == rb->tail) {
 654:	00e68e63          	beq	a3,a4,670 <pop_rb+0x26>
    return false;
  }

  *c = rb->buffer[rb->tail];
 658:	972a                	add	a4,a4,a0
 65a:	00074703          	lbu	a4,0(a4)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0

  return true;
 65e:	4505                	li	a0,1
  *c = rb->buffer[rb->tail];
 660:	00e58023          	sb	a4,0(a1)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0
 664:	1017c703          	lbu	a4,257(a5)
 668:	972a                	add	a4,a4,a0
 66a:	10e780a3          	sb	a4,257(a5)
  return true;
 66e:	8082                	ret
    return false;
 670:	4501                	li	a0,0
}
 672:	8082                	ret

00000674 <init_timers>:
#include "../include/timer.h"
#include <stdint.h>

void init_timers() {
 674:	1141                	addi	sp,sp,-16
 676:	c606                	sw	ra,12(sp)

  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 678:	20000737          	lui	a4,0x20000
 67c:	56fd                	li	a3,-1
 67e:	c714                	sw	a3,8(a4)
  *TIMER_COMP_PART2 = 0xFFFFFFFF;

  reg_timer_irq(master_timer_isr);
 680:	6505                	lui	a0,0x1
  *TIMER_COMP_PART2 = 0xFFFFFFFF;
 682:	c754                	sw	a3,12(a4)
  reg_timer_irq(master_timer_isr);
 684:	8b050513          	addi	a0,a0,-1872 # 8b0 <master_timer_isr>
 688:	3fbd                	jal	606 <reg_timer_irq>

  set_csr(mie, MIE_MTIE);
 68a:	08000793          	li	a5,128
 68e:	3047a7f3          	csrrs	a5,mie,a5
}
 692:	40b2                	lw	ra,12(sp)
 694:	0141                	addi	sp,sp,16
 696:	8082                	ret

00000698 <read_time>:

uint64_t read_time() {
  uint32_t lo = *TIMER_COMP_PART1;
 698:	200007b7          	lui	a5,0x20000
 69c:	4788                	lw	a0,8(a5)

  uint32_t hi = *TIMER_COMP_PART2;
 69e:	200007b7          	lui	a5,0x20000

  return (((uint64_t)hi) << 32) | lo;
}
 6a2:	47cc                	lw	a1,12(a5)
 6a4:	8082                	ret

000006a6 <set_compare>:

void set_compare(uint64_t comp) {
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 6a6:	200007b7          	lui	a5,0x20000
 6aa:	56fd                	li	a3,-1
 6ac:	c794                	sw	a3,8(a5)

  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 6ae:	c7cc                	sw	a1,12(a5)

  *TIMER_COMP_PART1 = (uint32_t)comp;
 6b0:	c788                	sw	a0,8(a5)
}
 6b2:	8082                	ret

000006b4 <swap_in_heap>:

void swap_in_heap(int a_i, int b_i) {
  irq_timer_t *temp = timer_heap[a_i];
 6b4:	83018793          	addi	a5,gp,-2000 # 10000070 <timer_heap>
  timer_heap[a_i] = timer_heap[b_i];
 6b8:	058a                	slli	a1,a1,0x2
 6ba:	95be                	add	a1,a1,a5
  irq_timer_t *temp = timer_heap[a_i];
 6bc:	050a                	slli	a0,a0,0x2
  timer_heap[a_i] = timer_heap[b_i];
 6be:	4194                	lw	a3,0(a1)
  irq_timer_t *temp = timer_heap[a_i];
 6c0:	97aa                	add	a5,a5,a0
 6c2:	4398                	lw	a4,0(a5)
  timer_heap[a_i] = timer_heap[b_i];
 6c4:	c394                	sw	a3,0(a5)
  timer_heap[b_i] = temp;
 6c6:	c198                	sw	a4,0(a1)
}
 6c8:	8082                	ret

000006ca <min_heapify>:

// first call should be, num_timers, 0
void min_heapify(int sz, int i) {
  int smallest = i;
  int left = 2 * i + 1;
 6ca:	00159793          	slli	a5,a1,0x1
 6ce:	00178693          	addi	a3,a5,1 # 20000001 <_stack_top+0xfff0001>
  int right = 2 * i + 2;

  if (left < sz &&
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 6d2:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
  int right = 2 * i + 2;
 6d6:	0789                	addi	a5,a5,2
  if (left < sz &&
 6d8:	06a6de63          	bge	a3,a0,754 <min_heapify+0x8a>
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 6dc:	00269713          	slli	a4,a3,0x2
 6e0:	00259613          	slli	a2,a1,0x2
 6e4:	9742                	add	a4,a4,a6
 6e6:	00c80333          	add	t1,a6,a2
 6ea:	00072883          	lw	a7,0(a4) # 20000000 <_stack_top+0xfff0000>
 6ee:	00032e03          	lw	t3,0(t1)
 6f2:	0048a703          	lw	a4,4(a7)
  if (left < sz &&
 6f6:	004e2303          	lw	t1,4(t3)
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 6fa:	0008a883          	lw	a7,0(a7)
  if (left < sz &&
 6fe:	00676863          	bltu	a4,t1,70e <min_heapify+0x44>
 702:	04e31963          	bne	t1,a4,754 <min_heapify+0x8a>
 706:	000e2303          	lw	t1,0(t3)
 70a:	0468f563          	bgeu	a7,t1,754 <min_heapify+0x8a>
    smallest = left;
  }

  if (right < sz &&
 70e:	00a7dd63          	bge	a5,a0,728 <min_heapify+0x5e>
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 712:	00279313          	slli	t1,a5,0x2
 716:	9342                	add	t1,t1,a6
 718:	00032e03          	lw	t3,0(t1)
  if (right < sz &&
 71c:	004e2303          	lw	t1,4(t3)
 720:	00e36563          	bltu	t1,a4,72a <min_heapify+0x60>
 724:	06e30563          	beq	t1,a4,78e <min_heapify+0xc4>
 728:	87b6                	mv	a5,a3
    smallest = right;
  }

  if (smallest != i) {
 72a:	06b78163          	beq	a5,a1,78c <min_heapify+0xc2>
  timer_heap[a_i] = timer_heap[b_i];
 72e:	00279713          	slli	a4,a5,0x2
 732:	9742                	add	a4,a4,a6
  irq_timer_t *temp = timer_heap[a_i];
 734:	00c806b3          	add	a3,a6,a2
  timer_heap[a_i] = timer_heap[b_i];
 738:	00072883          	lw	a7,0(a4)
  irq_timer_t *temp = timer_heap[a_i];
 73c:	4290                	lw	a2,0(a3)
    swap_in_heap(i, smallest);
    min_heapify(sz, smallest);
 73e:	85be                	mv	a1,a5
  timer_heap[a_i] = timer_heap[b_i];
 740:	0116a023          	sw	a7,0(a3)
  int left = 2 * i + 1;
 744:	00159793          	slli	a5,a1,0x1
 748:	00178693          	addi	a3,a5,1
  timer_heap[b_i] = temp;
 74c:	c310                	sw	a2,0(a4)
  int right = 2 * i + 2;
 74e:	0789                	addi	a5,a5,2
  if (left < sz &&
 750:	f8a6c6e3          	blt	a3,a0,6dc <min_heapify+0x12>
  if (right < sz &&
 754:	00a7c363          	blt	a5,a0,75a <min_heapify+0x90>
 758:	8082                	ret
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 75a:	00259613          	slli	a2,a1,0x2
 75e:	00279713          	slli	a4,a5,0x2
 762:	00c806b3          	add	a3,a6,a2
 766:	9742                	add	a4,a4,a6
 768:	0006a303          	lw	t1,0(a3)
 76c:	00072883          	lw	a7,0(a4)
  if (right < sz &&
 770:	00432683          	lw	a3,4(t1)
 774:	0048a703          	lw	a4,4(a7)
 778:	fad769e3          	bltu	a4,a3,72a <min_heapify+0x60>
 77c:	00e69863          	bne	a3,a4,78c <min_heapify+0xc2>
 780:	00032683          	lw	a3,0(t1)
 784:	0008a703          	lw	a4,0(a7)
 788:	fad761e3          	bltu	a4,a3,72a <min_heapify+0x60>
  }
}
 78c:	8082                	ret
  if (right < sz &&
 78e:	000e2703          	lw	a4,0(t3)
 792:	f9176ce3          	bltu	a4,a7,72a <min_heapify+0x60>
 796:	87b6                	mv	a5,a3
 798:	bf49                	j	72a <min_heapify+0x60>

0000079a <sift_up>:

void sift_up(int i) {
  int parent = (i - 1) / 2;
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 79a:	04a05f63          	blez	a0,7f8 <sift_up+0x5e>
 79e:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 7a2:	00251793          	slli	a5,a0,0x2
 7a6:	97b2                	add	a5,a5,a2
 7a8:	0007a303          	lw	t1,0(a5)
  int parent = (i - 1) / 2;
 7ac:	fff50713          	addi	a4,a0,-1
 7b0:	8705                	srai	a4,a4,0x1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 7b2:	00032e83          	lw	t4,0(t1)
 7b6:	00432e03          	lw	t3,4(t1)
 7ba:	a809                	j	7cc <sift_up+0x32>
  timer_heap[a_i] = timer_heap[b_i];
 7bc:	c10c                	sw	a1,0(a0)
  timer_heap[b_i] = temp;
 7be:	0067a023          	sw	t1,0(a5)
    swap_in_heap(i, parent);

    // Move up the tree
    i = parent;
    parent = (i - 1) / 2;
 7c2:	96c2                	add	a3,a3,a6
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 7c4:	853a                	mv	a0,a4
 7c6:	cb0d                	beqz	a4,7f8 <sift_up+0x5e>
 7c8:	4016d713          	srai	a4,a3,0x1
 7cc:	00271793          	slli	a5,a4,0x2
 7d0:	00f606b3          	add	a3,a2,a5
 7d4:	428c                	lw	a1,0(a3)
  timer_heap[a_i] = timer_heap[b_i];
 7d6:	050a                	slli	a0,a0,0x2
    parent = (i - 1) / 2;
 7d8:	fff70813          	addi	a6,a4,-1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 7dc:	0045a883          	lw	a7,4(a1)
  timer_heap[b_i] = temp;
 7e0:	87b6                	mv	a5,a3
  timer_heap[a_i] = timer_heap[b_i];
 7e2:	9532                	add	a0,a0,a2
    parent = (i - 1) / 2;
 7e4:	01f85693          	srli	a3,a6,0x1f
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 7e8:	fd1e6ae3          	bltu	t3,a7,7bc <sift_up+0x22>
 7ec:	01c89663          	bne	a7,t3,7f8 <sift_up+0x5e>
 7f0:	0005a883          	lw	a7,0(a1)
 7f4:	fd1ee4e3          	bltu	t4,a7,7bc <sift_up+0x22>
  }
}
 7f8:	8082                	ret

000007fa <_deactivate_timer.part.0>:
  // 1. Mark as inactive so the pool slot can be reused
  timer->active = false;

  // 2. Find the timer in the heap (O(N) search, but MAX_TIMERS is small)
  int heap_idx = -1;
  for (int i = 0; i < num_timers; i++) {
 7fa:	80c1a683          	lw	a3,-2036(gp) # 1000004c <num_timers>
  timer->active = false;
 7fe:	00050a23          	sb	zero,20(a0)
  for (int i = 0; i < num_timers; i++) {
 802:	06d05063          	blez	a3,862 <_deactivate_timer.part.0+0x68>
 806:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 80a:	87b2                	mv	a5,a2
 80c:	4581                	li	a1,0
 80e:	a021                	j	816 <_deactivate_timer.part.0+0x1c>
 810:	0585                	addi	a1,a1,1
 812:	04d58863          	beq	a1,a3,862 <_deactivate_timer.part.0+0x68>
    if (timer_heap[i] == timer) {
 816:	4398                	lw	a4,0(a5)
  for (int i = 0; i < num_timers; i++) {
 818:	0791                	addi	a5,a5,4
    if (timer_heap[i] == timer) {
 81a:	fee51be3          	bne	a0,a4,810 <_deactivate_timer.part.0+0x16>
  if (heap_idx == -1) {
    return false; // Timer was active but not in heap (state error)
  }

  // 3. Replace the removed timer with the last timer in the heap
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 81e:	fff68513          	addi	a0,a3,-1
 822:	00251793          	slli	a5,a0,0x2
 826:	97b2                	add	a5,a5,a2
 828:	4398                	lw	a4,0(a5)
bool _deactivate_timer(irq_timer_t *timer) {
 82a:	1141                	addi	sp,sp,-16
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 82c:	00259793          	slli	a5,a1,0x2
bool _deactivate_timer(irq_timer_t *timer) {
 830:	c606                	sw	ra,12(sp)
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 832:	97b2                	add	a5,a5,a2
  num_timers--;
 834:	80a1a623          	sw	a0,-2036(gp) # 1000004c <num_timers>
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 838:	c398                	sw	a4,0(a5)

  // 4. Restore the heap property
  if (heap_idx < num_timers) {
 83a:	02a5d663          	bge	a1,a0,866 <_deactivate_timer.part.0+0x6c>
    int parent = (heap_idx - 1) / 2;

    // If the new node is smaller than its parent, it needs to bubble up
    if (heap_idx > 0 &&
 83e:	c5ad                	beqz	a1,8a8 <_deactivate_timer.part.0+0xae>
    int parent = (heap_idx - 1) / 2;
 840:	fff58793          	addi	a5,a1,-1
 844:	8785                	srai	a5,a5,0x1
        timer_heap[heap_idx]->expires_at < timer_heap[parent]->expires_at) {
 846:	078a                	slli	a5,a5,0x2
 848:	963e                	add	a2,a2,a5
 84a:	4210                	lw	a2,0(a2)
    if (heap_idx > 0 &&
 84c:	435c                	lw	a5,4(a4)
 84e:	4254                	lw	a3,4(a2)
 850:	04d7e963          	bltu	a5,a3,8a2 <_deactivate_timer.part.0+0xa8>
 854:	04f68363          	beq	a3,a5,89a <_deactivate_timer.part.0+0xa0>
      sift_up(heap_idx);
    }
    // Otherwise, it might need to bubble down
    else {
      min_heapify(num_timers, heap_idx);
 858:	3d8d                	jal	6ca <min_heapify>
      set_compare(0xFFFFFFFFFFFFFFFFULL);
    }
  }

  return true;
}
 85a:	40b2                	lw	ra,12(sp)
  return true;
 85c:	4505                	li	a0,1
}
 85e:	0141                	addi	sp,sp,16
 860:	8082                	ret
    return false;
 862:	4501                	li	a0,0
}
 864:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 866:	ed99                	bnez	a1,884 <_deactivate_timer.part.0+0x8a>
    if (num_timers > 0) {
 868:	cd19                	beqz	a0,886 <_deactivate_timer.part.0+0x8c>
      set_compare(timer_heap[0]->expires_at);
 86a:	4218                	lw	a4,0(a2)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 86c:	200007b7          	lui	a5,0x20000
 870:	55fd                	li	a1,-1
      set_compare(timer_heap[0]->expires_at);
 872:	4350                	lw	a2,4(a4)
 874:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 876:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 878:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 87a:	c794                	sw	a3,8(a5)
}
 87c:	40b2                	lw	ra,12(sp)
  return true;
 87e:	4505                	li	a0,1
}
 880:	0141                	addi	sp,sp,16
 882:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 884:	fd65                	bnez	a0,87c <_deactivate_timer.part.0+0x82>
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 886:	200007b7          	lui	a5,0x20000
 88a:	577d                	li	a4,-1
 88c:	c798                	sw	a4,8(a5)
}
 88e:	40b2                	lw	ra,12(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 890:	c7d8                	sw	a4,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 892:	c798                	sw	a4,8(a5)
  return true;
 894:	4505                	li	a0,1
}
 896:	0141                	addi	sp,sp,16
 898:	8082                	ret
    if (heap_idx > 0 &&
 89a:	4214                	lw	a3,0(a2)
 89c:	431c                	lw	a5,0(a4)
 89e:	fad7fde3          	bgeu	a5,a3,858 <_deactivate_timer.part.0+0x5e>
      sift_up(heap_idx);
 8a2:	852e                	mv	a0,a1
 8a4:	3ddd                	jal	79a <sift_up>
  if (heap_idx == 0 || num_timers == 0) {
 8a6:	bfd9                	j	87c <_deactivate_timer.part.0+0x82>
      min_heapify(num_timers, heap_idx);
 8a8:	350d                	jal	6ca <min_heapify>
  if (heap_idx == 0 || num_timers == 0) {
 8aa:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 8ae:	bf75                	j	86a <_deactivate_timer.part.0+0x70>

000008b0 <master_timer_isr>:

void master_timer_isr() {
 8b0:	1101                	addi	sp,sp,-32
 8b2:	c452                	sw	s4,8(sp)
  // Loop to handle cases where multiple timers expire at the same time,
  // or if a callback execution delays us past the next timer's expiration.
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 8b4:	80c1a783          	lw	a5,-2036(gp) # 1000004c <num_timers>
void master_timer_isr() {
 8b8:	ce06                	sw	ra,28(sp)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 8ba:	04f05f63          	blez	a5,918 <master_timer_isr+0x68>
 8be:	ca26                	sw	s1,20(sp)
 8c0:	c84a                	sw	s2,16(sp)
 8c2:	c64e                	sw	s3,12(sp)
 8c4:	200009b7          	lui	s3,0x20000
 8c8:	20000937          	lui	s2,0x20000
 8cc:	cc22                	sw	s0,24(sp)
 8ce:	c256                	sw	s5,4(sp)
 8d0:	83018493          	addi	s1,gp,-2000 # 10000070 <timer_heap>
 8d4:	09a1                	addi	s3,s3,8 # 20000008 <_stack_top+0xfff0008>
 8d6:	0931                	addi	s2,s2,12 # 2000000c <_stack_top+0xfff000c>
 8d8:	4080                	lw	s0,0(s1)
  uint32_t lo = *TIMER_COMP_PART1;
 8da:	0009a683          	lw	a3,0(s3)
  uint32_t hi = *TIMER_COMP_PART2;
 8de:	00092783          	lw	a5,0(s2)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 8e2:	4058                	lw	a4,4(s0)
 8e4:	06e7e263          	bltu	a5,a4,948 <master_timer_isr+0x98>
 8e8:	04f70d63          	beq	a4,a5,942 <master_timer_isr+0x92>

    // 1. Get the timer at the top of the heap
    irq_timer_t *top_timer = timer_heap[0];

    // 2. Run the callback function
    if (top_timer->callback_function != NULL) {
 8ec:	481c                	lw	a5,16(s0)
 8ee:	c391                	beqz	a5,8f2 <master_timer_isr+0x42>
      // Cast the void* to a function pointer and execute it
      void (*callback)(void) = (void (*)(void))top_timer->callback_function;
      callback();
 8f0:	9782                	jalr	a5
    }

    // 3. Handle periodic vs absolute
    if (top_timer->period > 0) {
 8f2:	441c                	lw	a5,8(s0)
 8f4:	4454                	lw	a3,12(s0)
 8f6:	00d7e733          	or	a4,a5,a3
 8fa:	e31d                	bnez	a4,920 <master_timer_isr+0x70>
  if (timer == NULL || !timer->active) {
 8fc:	01444783          	lbu	a5,20(s0)
 900:	c399                	beqz	a5,906 <master_timer_isr+0x56>
  timer->active = false;
 902:	8522                	mv	a0,s0
 904:	3ddd                	jal	7fa <_deactivate_timer.part.0>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 906:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
 90a:	fd5047e3          	bgtz	s5,8d8 <master_timer_isr+0x28>
 90e:	4462                	lw	s0,24(sp)
 910:	44d2                	lw	s1,20(sp)
 912:	4942                	lw	s2,16(sp)
 914:	49b2                	lw	s3,12(sp)
 916:	4a92                	lw	s5,4(sp)
  }

  if (num_timers > 0) {
    set_compare(timer_heap[0]->expires_at);
  }
}
 918:	40f2                	lw	ra,28(sp)
 91a:	4a22                	lw	s4,8(sp)
 91c:	6105                	addi	sp,sp,32
 91e:	8082                	ret
      top_timer->expires_at += top_timer->period;
 920:	4018                	lw	a4,0(s0)
 922:	4050                	lw	a2,4(s0)
      min_heapify(num_timers, 0);
 924:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
      top_timer->expires_at += top_timer->period;
 928:	97ba                	add	a5,a5,a4
 92a:	00e7b733          	sltu	a4,a5,a4
 92e:	96b2                	add	a3,a3,a2
 930:	9736                	add	a4,a4,a3
 932:	c01c                	sw	a5,0(s0)
 934:	c058                	sw	a4,4(s0)
      min_heapify(num_timers, 0);
 936:	8556                	mv	a0,s5
 938:	4581                	li	a1,0
 93a:	3b41                	jal	6ca <min_heapify>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 93c:	f9504ee3          	bgtz	s5,8d8 <master_timer_isr+0x28>
 940:	b7f9                	j	90e <master_timer_isr+0x5e>
 942:	401c                	lw	a5,0(s0)
 944:	faf6f4e3          	bgeu	a3,a5,8ec <master_timer_isr+0x3c>
    set_compare(timer_heap[0]->expires_at);
 948:	4098                	lw	a4,0(s1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 94a:	200007b7          	lui	a5,0x20000
 94e:	55fd                	li	a1,-1
    set_compare(timer_heap[0]->expires_at);
 950:	4350                	lw	a2,4(a4)
 952:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 954:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 956:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 958:	c794                	sw	a3,8(a5)
 95a:	bf55                	j	90e <master_timer_isr+0x5e>

0000095c <register_isr_periodic>:
  if (num_timers == MAX_TIMERS) {
 95c:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 960:	04000793          	li	a5,64
 964:	0af88e63          	beq	a7,a5,a20 <register_isr_periodic+0xc4>
    if (timer_pool[i].active == false) {
 968:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 96c:	11484783          	lbu	a5,276(a6)
irq_timer_handler register_isr_periodic(uint64_t period, void *cb) {
 970:	1101                	addi	sp,sp,-32
 972:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 974:	cbc5                	beqz	a5,a24 <register_isr_periodic+0xc8>
 976:	12c80793          	addi	a5,a6,300
  int i = 0;
 97a:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 97c:	0007c683          	lbu	a3,0(a5) # 20000000 <_stack_top+0xfff0000>
 980:	07e1                	addi	a5,a5,24
      i++;
 982:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 984:	fee5                	bnez	a3,97c <register_isr_periodic+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 986:	00171793          	slli	a5,a4,0x1
 98a:	00e78333          	add	t1,a5,a4
 98e:	030e                	slli	t1,t1,0x3
 990:	10080693          	addi	a3,a6,256
 994:	969a                	add	a3,a3,t1
  uint32_t lo = *TIMER_COMP_PART1;
 996:	20000e37          	lui	t3,0x20000
  timer_pool[i].expires_at = read_time() + period;
 99a:	97ba                	add	a5,a5,a4
  uint32_t lo = *TIMER_COMP_PART1;
 99c:	008e2703          	lw	a4,8(t3) # 20000008 <_stack_top+0xfff0008>
 9a0:	832a                	mv	t1,a0
  uint32_t hi = *TIMER_COMP_PART2;
 9a2:	00ce2503          	lw	a0,12(t3)
  timer_pool[i].expires_at = read_time() + period;
 9a6:	006702b3          	add	t0,a4,t1
 9aa:	00e2b733          	sltu	a4,t0,a4
 9ae:	952e                	add	a0,a0,a1
 9b0:	078e                	slli	a5,a5,0x3
 9b2:	97c2                	add	a5,a5,a6
 9b4:	972a                	add	a4,a4,a0
  timer_pool[i].active = true;
 9b6:	4385                	li	t2,1
  timer_heap[num_timers - 1] = &timer_pool[i];
 9b8:	00289f13          	slli	t5,a7,0x2
  timer_pool[i].expires_at = read_time() + period;
 9bc:	10e7a223          	sw	a4,260(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 9c0:	9f42                	add	t5,t5,a6
  num_timers++;
 9c2:	00788733          	add	a4,a7,t2
  sift_up(num_timers - 1);
 9c6:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + period;
 9c8:	1057a023          	sw	t0,256(a5)
  timer_pool[i].period = period;
 9cc:	1067a423          	sw	t1,264(a5)
 9d0:	10b7a623          	sw	a1,268(a5)
  timer_pool[i].callback_function = cb;
 9d4:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 9d8:	10778a23          	sb	t2,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 9dc:	00df2023          	sw	a3,0(t5)
 9e0:	c636                	sw	a3,12(sp)
  num_timers++;
 9e2:	80e1a623          	sw	a4,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 9e6:	3b55                	jal	79a <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 9e8:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 9ec:	46b2                	lw	a3,12(sp)
 9ee:	20000eb7          	lui	t4,0x20000
 9f2:	20000e37          	lui	t3,0x20000
 9f6:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 9f8:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 9fa:	00d78663          	beq	a5,a3,a06 <register_isr_periodic+0xaa>
}
 9fe:	40f2                	lw	ra,28(sp)
  return new_handler;
 a00:	8536                	mv	a0,a3
}
 a02:	6105                	addi	sp,sp,32
 a04:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 a06:	42d8                	lw	a4,4(a3)
 a08:	429c                	lw	a5,0(a3)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a0a:	567d                	li	a2,-1
 a0c:	00ce2023          	sw	a2,0(t3)
}
 a10:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 a12:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 a16:	00fe2023          	sw	a5,0(t3)
  return new_handler;
 a1a:	8536                	mv	a0,a3
}
 a1c:	6105                	addi	sp,sp,32
 a1e:	8082                	ret
    return (irq_timer_handler){};
 a20:	4501                	li	a0,0
}
 a22:	8082                	ret
    if (timer_pool[i].active == false) {
 a24:	10080693          	addi	a3,a6,256
  int i = 0;
 a28:	4701                	li	a4,0
 a2a:	b7b5                	j	996 <register_isr_periodic+0x3a>

00000a2c <register_isr_abs>:
  if (num_timers == MAX_TIMERS) {
 a2c:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 a30:	04000793          	li	a5,64
 a34:	0cf88063          	beq	a7,a5,af4 <register_isr_abs+0xc8>
    if (timer_pool[i].active == false) {
 a38:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 a3c:	11484783          	lbu	a5,276(a6)
bool register_isr_abs(uint64_t offset, void *cb) {
 a40:	1101                	addi	sp,sp,-32
 a42:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 a44:	cbd5                	beqz	a5,af8 <register_isr_abs+0xcc>
 a46:	12c80793          	addi	a5,a6,300
  int i = 0;
 a4a:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 a4c:	0007c683          	lbu	a3,0(a5)
 a50:	07e1                	addi	a5,a5,24
      i++;
 a52:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 a54:	fee5                	bnez	a3,a4c <register_isr_abs+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 a56:	00171793          	slli	a5,a4,0x1
 a5a:	00e786b3          	add	a3,a5,a4
 a5e:	068e                	slli	a3,a3,0x3
 a60:	10080313          	addi	t1,a6,256
 a64:	9336                	add	t1,t1,a3
  uint32_t lo = *TIMER_COMP_PART1;
 a66:	20000e37          	lui	t3,0x20000
 a6a:	008e2683          	lw	a3,8(t3) # 20000008 <_stack_top+0xfff0008>
  uint32_t hi = *TIMER_COMP_PART2;
 a6e:	00ce2f83          	lw	t6,12(t3)
  timer_pool[i].expires_at = read_time() + offset;
 a72:	97ba                	add	a5,a5,a4
 a74:	00a68733          	add	a4,a3,a0
  timer_pool[i].active = true;
 a78:	4285                	li	t0,1
  timer_pool[i].expires_at = read_time() + offset;
 a7a:	00bf8533          	add	a0,t6,a1
 a7e:	00d736b3          	sltu	a3,a4,a3
  timer_heap[num_timers - 1] = &timer_pool[i];
 a82:	00289593          	slli	a1,a7,0x2
  timer_pool[i].expires_at = read_time() + offset;
 a86:	078e                	slli	a5,a5,0x3
 a88:	97c2                	add	a5,a5,a6
 a8a:	96aa                	add	a3,a3,a0
  timer_heap[num_timers - 1] = &timer_pool[i];
 a8c:	95c2                	add	a1,a1,a6
  num_timers++;
 a8e:	00588fb3          	add	t6,a7,t0
  sift_up(num_timers - 1);
 a92:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + offset;
 a94:	10d7a223          	sw	a3,260(a5)
 a98:	10e7a023          	sw	a4,256(a5)
  timer_pool[i].period = 0;
 a9c:	1007a423          	sw	zero,264(a5)
 aa0:	1007a623          	sw	zero,268(a5)
  timer_pool[i].callback_function = cb;
 aa4:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 aa8:	10578a23          	sb	t0,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 aac:	0065a023          	sw	t1,0(a1)
 ab0:	c61a                	sw	t1,12(sp)
  num_timers++;
 ab2:	81f1a623          	sw	t6,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 ab6:	31d5                	jal	79a <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 ab8:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 abc:	4332                	lw	t1,12(sp)
 abe:	20000eb7          	lui	t4,0x20000
 ac2:	20000e37          	lui	t3,0x20000
 ac6:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 ac8:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 aca:	00678663          	beq	a5,t1,ad6 <register_isr_abs+0xaa>
}
 ace:	40f2                	lw	ra,28(sp)
  return true;
 ad0:	4505                	li	a0,1
}
 ad2:	6105                	addi	sp,sp,32
 ad4:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 ad6:	00432703          	lw	a4,4(t1)
 ada:	00032783          	lw	a5,0(t1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 ade:	56fd                	li	a3,-1
 ae0:	00de2023          	sw	a3,0(t3)
}
 ae4:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 ae6:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 aea:	00fe2023          	sw	a5,0(t3)
  return true;
 aee:	4505                	li	a0,1
}
 af0:	6105                	addi	sp,sp,32
 af2:	8082                	ret
    return false;
 af4:	4501                	li	a0,0
}
 af6:	8082                	ret
    if (timer_pool[i].active == false) {
 af8:	10080313          	addi	t1,a6,256
  int i = 0;
 afc:	4701                	li	a4,0
 afe:	b7a5                	j	a66 <register_isr_abs+0x3a>

00000b00 <deactivate_timer>:
  if (timer == NULL || !timer->active) {
 b00:	c509                	beqz	a0,b0a <deactivate_timer+0xa>
 b02:	01454783          	lbu	a5,20(a0)
 b06:	c391                	beqz	a5,b0a <deactivate_timer+0xa>
  timer->active = false;
 b08:	b9cd                	j	7fa <_deactivate_timer.part.0>
}
 b0a:	4501                	li	a0,0
 b0c:	8082                	ret

00000b0e <_deactivate_timer>:
  if (timer == NULL || !timer->active) {
 b0e:	c509                	beqz	a0,b18 <_deactivate_timer+0xa>
 b10:	01454783          	lbu	a5,20(a0)
 b14:	c391                	beqz	a5,b18 <_deactivate_timer+0xa>
  timer->active = false;
 b16:	b1d5                	j	7fa <_deactivate_timer.part.0>
}
 b18:	4501                	li	a0,0
 b1a:	8082                	ret

00000b1c <uart_isr>:
ring_buffer_t rx_buffer;
ring_buffer_t tx_buffer;

// Define the Interrupt Service Routine
void uart_isr(void) {
  uint32_t irq_status = *UART_IRQ_STATUS;
 b1c:	200027b7          	lui	a5,0x20002
 b20:	07d1                	addi	a5,a5,20 # 20002014 <_stack_top+0xfff2014>
 b22:	439c                	lw	a5,0(a5)
void uart_isr(void) {
 b24:	7179                	addi	sp,sp,-48
 b26:	d606                	sw	ra,44(sp)

  // Handle Incoming Data
  if (irq_status & IRQ_RX_AVAIL) {
 b28:	0017f713          	andi	a4,a5,1
 b2c:	e705                	bnez	a4,b54 <uart_isr+0x38>
    char c = (char)(*UART_RX_FIFO);
    insert_rb(&rx_buffer, c); // Push to RX buffer
  }

  // Handle Outgoing Data
  if ((irq_status & IRQ_TX_EMPTY) && (*UART_IRQ_EN & IRQ_TX_EMPTY)) {
 b2e:	0027f713          	andi	a4,a5,2
 b32:	c711                	beqz	a4,b3e <uart_isr+0x22>
 b34:	20002737          	lui	a4,0x20002
 b38:	4b14                	lw	a3,16(a4)
 b3a:	8a89                	andi	a3,a3,2
 b3c:	e69d                	bnez	a3,b6a <uart_isr+0x4e>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
    }
  }

  // Handle Hardware Errors
  if (irq_status & (IRQ_RX_OVERRUN | IRQ_FRAME_ERROR)) {
 b3e:	8bb1                	andi	a5,a5,12
 b40:	c799                	beqz	a5,b4e <uart_isr+0x32>
    *UART_CTRL |= CTRL_CLR_ERRORS; // Clear the hardware error states
 b42:	200027b7          	lui	a5,0x20002
 b46:	47d8                	lw	a4,12(a5)
 b48:	00476713          	ori	a4,a4,4
 b4c:	c7d8                	sw	a4,12(a5)
  }
}
 b4e:	50b2                	lw	ra,44(sp)
 b50:	6145                	addi	sp,sp,48
 b52:	8082                	ret
    char c = (char)(*UART_RX_FIFO);
 b54:	200026b7          	lui	a3,0x20002
 b58:	428c                	lw	a1,0(a3)
    insert_rb(&rx_buffer, c); // Push to RX buffer
 b5a:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 b5e:	0ff5f593          	zext.b	a1,a1
 b62:	c63e                	sw	a5,12(sp)
 b64:	34c1                	jal	624 <insert_rb>
 b66:	47b2                	lw	a5,12(sp)
 b68:	b7d9                	j	b2e <uart_isr+0x12>
    if (pop_rb(&tx_buffer, &c)) {
 b6a:	03418513          	addi	a0,gp,52 # 10000874 <tx_buffer>
 b6e:	01f10593          	addi	a1,sp,31
 b72:	c63e                	sw	a5,12(sp)
 b74:	3cd9                	jal	64a <pop_rb>
 b76:	20002737          	lui	a4,0x20002
 b7a:	47b2                	lw	a5,12(sp)
 b7c:	0741                	addi	a4,a4,16 # 20002010 <_stack_top+0xfff2010>
 b7e:	c519                	beqz	a0,b8c <uart_isr+0x70>
      *UART_TX_FIFO = (uint32_t)c;
 b80:	01f14683          	lbu	a3,31(sp)
 b84:	20002737          	lui	a4,0x20002
 b88:	c354                	sw	a3,4(a4)
 b8a:	bf55                	j	b3e <uart_isr+0x22>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 b8c:	4314                	lw	a3,0(a4)
 b8e:	9af5                	andi	a3,a3,-3
 b90:	c314                	sw	a3,0(a4)
 b92:	b775                	j	b3e <uart_isr+0x22>

00000b94 <uart_init>:

// Initialization function (Call this in main!)
void uart_init(void) {
 b94:	1141                	addi	sp,sp,-16
  init_ring_buffer(&rx_buffer);
 b96:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
void uart_init(void) {
 b9a:	c606                	sw	ra,12(sp)
  init_ring_buffer(&rx_buffer);
 b9c:	3c95                	jal	610 <init_ring_buffer>
  init_ring_buffer(&tx_buffer);
 b9e:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 ba2:	10450513          	addi	a0,a0,260
 ba6:	34ad                	jal	610 <init_ring_buffer>

  // Register ISR with the MINA PLIC at priority 1
  reg_UART_irq(uart_isr, 1);
 ba8:	4605                	li	a2,1
 baa:	6505                	lui	a0,0x1
 bac:	85b2                	mv	a1,a2
 bae:	b1c50513          	addi	a0,a0,-1252 # b1c <uart_isr>
 bb2:	4681                	li	a3,0
 bb4:	342d                	jal	5de <reg_irq_handler>

  // Enable the RX interrupt permanently so we never miss incoming data
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 bb6:	200027b7          	lui	a5,0x20002
 bba:	4b98                	lw	a4,16(a5)
}
 bbc:	40b2                	lw	ra,12(sp)
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 bbe:	00176713          	ori	a4,a4,1
 bc2:	cb98                	sw	a4,16(a5)
}
 bc4:	0141                	addi	sp,sp,16
 bc6:	8082                	ret

00000bc8 <uart_putc>:

void uart_putc(char c) {
  // 1. Temporarily disable TX interrupts to avoid race conditions
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 bc8:	200027b7          	lui	a5,0x20002
 bcc:	4b94                	lw	a3,16(a5)

  // 2. If the software buffer is empty AND the hardware TX FIFO is empty,
  // bypass the software buffer to kickstart the hardware transmission.
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 bce:	f3018713          	addi	a4,gp,-208 # 10000770 <rx_buffer>
 bd2:	20474583          	lbu	a1,516(a4) # 20002204 <_stack_top+0xfff2204>
 bd6:	20574603          	lbu	a2,517(a4)
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 bda:	ffd6f713          	andi	a4,a3,-3
 bde:	cb98                	sw	a4,16(a5)
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 be0:	02c58863          	beq	a1,a2,c10 <uart_putc+0x48>
void uart_putc(char c) {
 be4:	1141                	addi	sp,sp,-16
 be6:	c226                	sw	s1,4(sp)
 be8:	c422                	sw	s0,8(sp)
 bea:	c606                	sw	ra,12(sp)
 bec:	842a                	mv	s0,a0
 bee:	03418493          	addi	s1,gp,52 # 10000874 <tx_buffer>
    *UART_TX_FIFO = (uint32_t)c;
  } else {
    // Otherwise, hardware is busy. Queue it in the software buffer.
    while (!insert_rb(&tx_buffer, c)) {
 bf2:	85a2                	mv	a1,s0
 bf4:	8526                	mv	a0,s1
 bf6:	343d                	jal	624 <insert_rb>
 bf8:	dd6d                	beqz	a0,bf2 <uart_putc+0x2a>
      // Busy wait only if the 256-byte buffer is completely full
    }
  }

  // 3. Re-enable TX interrupts so the ISR handles the rest
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 bfa:	200027b7          	lui	a5,0x20002
 bfe:	4b98                	lw	a4,16(a5)
}
 c00:	40b2                	lw	ra,12(sp)
 c02:	4422                	lw	s0,8(sp)
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c04:	00276713          	ori	a4,a4,2
 c08:	cb98                	sw	a4,16(a5)
}
 c0a:	4492                	lw	s1,4(sp)
 c0c:	0141                	addi	sp,sp,16
 c0e:	8082                	ret
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c10:	200027b7          	lui	a5,0x20002
 c14:	07a1                	addi	a5,a5,8 # 20002008 <_stack_top+0xfff2008>
 c16:	439c                	lw	a5,0(a5)
 c18:	8b91                	andi	a5,a5,4
 c1a:	d7e9                	beqz	a5,be4 <uart_putc+0x1c>
    *UART_TX_FIFO = (uint32_t)c;
 c1c:	200027b7          	lui	a5,0x20002
 c20:	c3c8                	sw	a0,4(a5)
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c22:	200027b7          	lui	a5,0x20002
 c26:	4b98                	lw	a4,16(a5)
 c28:	00276713          	ori	a4,a4,2
 c2c:	cb98                	sw	a4,16(a5)
 c2e:	8082                	ret

00000c30 <uart_getc>:

char uart_getc(void) {
 c30:	1101                	addi	sp,sp,-32
 c32:	cc22                	sw	s0,24(sp)
 c34:	ce06                	sw	ra,28(sp)
 c36:	f3018413          	addi	s0,gp,-208 # 10000770 <rx_buffer>
  char c;
  // Block only when the software buffer is completely empty
  while (!pop_rb(&rx_buffer, &c)) {
 c3a:	00f10593          	addi	a1,sp,15
 c3e:	8522                	mv	a0,s0
 c40:	3429                	jal	64a <pop_rb>
 c42:	dd65                	beqz	a0,c3a <uart_getc+0xa>
    // Busy wait until the ISR receives new data
  }
  return c;
}
 c44:	40f2                	lw	ra,28(sp)
 c46:	4462                	lw	s0,24(sp)
 c48:	00f14503          	lbu	a0,15(sp)
 c4c:	6105                	addi	sp,sp,32
 c4e:	8082                	ret

00000c50 <uart_puts>:

void uart_puts(const char *str) {
 c50:	1141                	addi	sp,sp,-16
 c52:	c422                	sw	s0,8(sp)
 c54:	c606                	sw	ra,12(sp)
 c56:	842a                	mv	s0,a0
  while (*str != '\0') {
 c58:	00054503          	lbu	a0,0(a0)
 c5c:	c511                	beqz	a0,c68 <uart_puts+0x18>
    uart_putc(*str);
 c5e:	37ad                	jal	bc8 <uart_putc>
  while (*str != '\0') {
 c60:	00144503          	lbu	a0,1(s0)
    str++;
 c64:	0405                	addi	s0,s0,1
  while (*str != '\0') {
 c66:	fd65                	bnez	a0,c5e <uart_puts+0xe>
  }
}
 c68:	40b2                	lw	ra,12(sp)
 c6a:	4422                	lw	s0,8(sp)
 c6c:	0141                	addi	sp,sp,16
 c6e:	8082                	ret
