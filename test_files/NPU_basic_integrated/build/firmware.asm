
/tmp/mina_build_LHLyQr/firmware.elf:     file format elf32-littleriscv


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
  18:	ea450513          	addi	a0,a0,-348 # eb8 <_data_load_start>
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
 16e:	2e5000ef          	jal	c52 <uart_putc>
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
 190:	2c3000ef          	jal	c52 <uart_putc>
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
 1b0:	2a3000ef          	jal	c52 <uart_putc>
        uart_putc(' ');
 1b4:	02000513          	li	a0,32
 1b8:	29b000ef          	jal	c52 <uart_putc>
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 1bc:	f92c9ce3          	bne	s9,s2,154 <npu_irq_handler+0x60>
    for (uint32_t word = 0; word < 2u; ++word) {
 1c0:	0a91                	addi	s5,s5,4
 1c2:	f95b14e3          	bne	s6,s5,14a <npu_irq_handler+0x56>
    uart_putc('\r');
 1c6:	4535                	li	a0,13
 1c8:	28b000ef          	jal	c52 <uart_putc>
    uart_putc('\n');
 1cc:	4529                	li	a0,10
 1ce:	285000ef          	jal	c52 <uart_putc>
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
 1d2:	403007b7          	lui	a5,0x40300
 1d6:	0b21                	addi	s6,s6,8
 1d8:	44878793          	addi	a5,a5,1096 # 40300448 <_stack_top+0x302f0448>
 1dc:	f6fb13e3          	bne	s6,a5,142 <npu_irq_handler+0x4e>
  uart_putc('\r');
 1e0:	4535                	li	a0,13
 1e2:	271000ef          	jal	c52 <uart_putc>
  uart_putc('\n');
 1e6:	4529                	li	a0,10
 1e8:	26b000ef          	jal	c52 <uart_putc>

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
 21e:	235000ef          	jal	c52 <uart_putc>
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
 23c:	1e3000ef          	jal	c1e <uart_init>
  reg_NPU_irq(npu_irq_handler, 1);
 240:	0f400513          	li	a0,244
 244:	4691                	li	a3,4
 246:	4641                	li	a2,16
 248:	4585                	li	a1,1
 24a:	2939                	jal	668 <reg_irq_handler>

  uart_puts("Starting program, loaded interrupts\n");
 24c:	6505                	lui	a0,0x1
 24e:	dcc50513          	addi	a0,a0,-564 # dcc <uart_print_hex+0x9a>
 252:	289000ef          	jal	cda <uart_puts>

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
 27c:	df498993          	addi	s3,s3,-524 # df4 <uart_print_hex+0xc2>
    buf[i++] = '0' + (val % 10);
 280:	ccd40413          	addi	s0,s0,-819 # cccccccd <_stack_top+0xbccbcccd>
      uart_puts("Program counter, NPU: ");
 284:	854e                	mv	a0,s3
 286:	255000ef          	jal	cda <uart_puts>
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
 2bc:	197000ef          	jal	c52 <uart_putc>
  while (i > 0) {
 2c0:	ff449be3          	bne	s1,s4,2b6 <main+0x8a>

      uart_print_u32((int)NPU_PC_IDX);

      uart_putc('\n');
 2c4:	4529                	li	a0,10
 2c6:	18d000ef          	jal	c52 <uart_putc>
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
 2fe:	80078793          	addi	a5,a5,-2048 # 800 <min_heapify+0xac>
 302:	3047a7f3          	csrrs	a5,mie,a5

  // C. Enable Global Machine Interrupts in the 'mstatus' register
  set_csr(mstatus, MSTATUS_MIE);
 306:	300467f3          	csrrsi	a5,mstatus,8
}
 30a:	8082                	ret

0000030c <plic_irq_handler>:
      // Hang indefinitely for debugger attachment
    }
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
 38c:	715d                	addi	sp,sp,-80
 38e:	c686                	sw	ra,76(sp)
 390:	c496                	sw	t0,72(sp)
 392:	c29a                	sw	t1,68(sp)
 394:	c09e                	sw	t2,64(sp)
 396:	de22                	sw	s0,60(sp)
 398:	dc26                	sw	s1,56(sp)
 39a:	da2a                	sw	a0,52(sp)
 39c:	d82e                	sw	a1,48(sp)
 39e:	d632                	sw	a2,44(sp)
 3a0:	d436                	sw	a3,40(sp)
 3a2:	d23a                	sw	a4,36(sp)
 3a4:	d03e                	sw	a5,32(sp)
 3a6:	ce42                	sw	a6,28(sp)
 3a8:	cc46                	sw	a7,24(sp)
 3aa:	ca4a                	sw	s2,20(sp)
 3ac:	c84e                	sw	s3,16(sp)
 3ae:	c672                	sw	t3,12(sp)
 3b0:	c476                	sw	t4,8(sp)
 3b2:	c27a                	sw	t5,4(sp)
 3b4:	c07e                	sw	t6,0(sp)
  unsigned long cause = read_csr(mcause);
 3b6:	34202473          	csrr	s0,mcause
  if ((long)cause < 0) {
 3ba:	04045263          	bgez	s0,3fe <trap_handler+0x72>
    unsigned long exception_code = cause & ~(1UL << (sizeof(long) * 8 - 1));
 3be:	00141793          	slli	a5,s0,0x1
 3c2:	8385                	srli	a5,a5,0x1
    if (exception_code == IRQ_M_EXT) {
 3c4:	472d                	li	a4,11
 3c6:	0ae78863          	beq	a5,a4,476 <trap_handler+0xea>
    } else if (exception_code == IRQ_M_TIMER) {
 3ca:	471d                	li	a4,7
 3cc:	0ae78763          	beq	a5,a4,47a <trap_handler+0xee>
}
 3d0:	5472                	lw	s0,60(sp)
 3d2:	40b6                	lw	ra,76(sp)
 3d4:	42a6                	lw	t0,72(sp)
 3d6:	4316                	lw	t1,68(sp)
 3d8:	4386                	lw	t2,64(sp)
 3da:	54e2                	lw	s1,56(sp)
 3dc:	5552                	lw	a0,52(sp)
 3de:	55c2                	lw	a1,48(sp)
 3e0:	5632                	lw	a2,44(sp)
 3e2:	56a2                	lw	a3,40(sp)
 3e4:	5712                	lw	a4,36(sp)
 3e6:	5782                	lw	a5,32(sp)
 3e8:	4872                	lw	a6,28(sp)
 3ea:	48e2                	lw	a7,24(sp)
 3ec:	4952                	lw	s2,20(sp)
 3ee:	49c2                	lw	s3,16(sp)
 3f0:	4e32                	lw	t3,12(sp)
 3f2:	4ea2                	lw	t4,8(sp)
 3f4:	4f12                	lw	t5,4(sp)
 3f6:	4f82                	lw	t6,0(sp)
 3f8:	6161                	addi	sp,sp,80
 3fa:	30200073          	mret
    uart_polled_puts("\r\n\r\n=== CPU EXCEPTION / CRASH DETECTED ===\r\n");
 3fe:	6505                	lui	a0,0x1
 400:	e0c50513          	addi	a0,a0,-500 # e0c <uart_print_hex+0xda>
 404:	10b000ef          	jal	d0e <uart_polled_puts>
    uart_print_hex("mcause: 0x", (uint32_t)cause);
 408:	6505                	lui	a0,0x1
 40a:	85a2                	mv	a1,s0
 40c:	e3c50513          	addi	a0,a0,-452 # e3c <uart_print_hex+0x10a>
 410:	123000ef          	jal	d32 <uart_print_hex>
    uart_print_hex("mepc  : 0x", (uint32_t)read_csr(mepc));
 414:	341025f3          	csrr	a1,mepc
 418:	6505                	lui	a0,0x1
 41a:	e4850513          	addi	a0,a0,-440 # e48 <uart_print_hex+0x116>
 41e:	115000ef          	jal	d32 <uart_print_hex>
    uart_print_hex("mtval : 0x", (uint32_t)read_csr(mtval));
 422:	343025f3          	csrr	a1,mtval
 426:	6505                	lui	a0,0x1
 428:	e5450513          	addi	a0,a0,-428 # e54 <uart_print_hex+0x122>
 42c:	107000ef          	jal	d32 <uart_print_hex>
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 430:	6505                	lui	a0,0x1
    while (stack_ptr < stack_top_ptr) {
 432:	100104b7          	lui	s1,0x10010
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 436:	e6050513          	addi	a0,a0,-416 # e60 <uart_print_hex+0x12e>
    while (stack_ptr < stack_top_ptr) {
 43a:	00048493          	mv	s1,s1
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 43e:	0d1000ef          	jal	d0e <uart_polled_puts>
    while (stack_ptr < stack_top_ptr) {
 442:	02917463          	bgeu	sp,s1,46a <trap_handler+0xde>
 446:	6785                	lui	a5,0x1
        uart_print_hex("  from instruction addr: 0x", val);
 448:	e8478993          	addi	s3,a5,-380 # e84 <uart_print_hex+0x152>
 44c:	840a                	mv	s0,sp
      if (val >= 0x00000000 && val < 0x00004000) {
 44e:	6911                	lui	s2,0x4
 450:	a021                	j	458 <trap_handler+0xcc>
    while (stack_ptr < stack_top_ptr) {
 452:	0411                	addi	s0,s0,4
 454:	00947b63          	bgeu	s0,s1,46a <trap_handler+0xde>
      uint32_t val = *stack_ptr;
 458:	400c                	lw	a1,0(s0)
      if (val >= 0x00000000 && val < 0x00004000) {
 45a:	ff25fce3          	bgeu	a1,s2,452 <trap_handler+0xc6>
        uart_print_hex("  from instruction addr: 0x", val);
 45e:	854e                	mv	a0,s3
    while (stack_ptr < stack_top_ptr) {
 460:	0411                	addi	s0,s0,4
        uart_print_hex("  from instruction addr: 0x", val);
 462:	0d1000ef          	jal	d32 <uart_print_hex>
    while (stack_ptr < stack_top_ptr) {
 466:	fe9469e3          	bltu	s0,s1,458 <trap_handler+0xcc>
    uart_polled_puts("System halted.\r\n");
 46a:	6505                	lui	a0,0x1
 46c:	ea050513          	addi	a0,a0,-352 # ea0 <uart_print_hex+0x16e>
 470:	09f000ef          	jal	d0e <uart_polled_puts>
    while (1) {
 474:	a001                	j	474 <trap_handler+0xe8>
      plic_irq_handler();
 476:	3d59                	jal	30c <plic_irq_handler>
 478:	bfa1                	j	3d0 <trap_handler+0x44>
      if (timer_irq_handler) {
 47a:	100007b7          	lui	a5,0x10000
 47e:	0487a783          	lw	a5,72(a5) # 10000048 <timer_irq_handler>
 482:	d7b9                	beqz	a5,3d0 <trap_handler+0x44>
        timer_irq_handler();
 484:	9782                	jalr	a5
 486:	b7a9                	j	3d0 <trap_handler+0x44>

00000488 <resort_by_prior>:
  *PLIC_IRQ_ACTV |= actv_mask;

  resort_by_prior();
}

void resort_by_prior() {
 488:	1141                	addi	sp,sp,-16

  for (int i = 0; i < 8; i++) {
    plic_idx_sort[i] = i;
 48a:	100007b7          	lui	a5,0x10000
 48e:	00078793          	mv	a5,a5
void resort_by_prior() {
 492:	c622                	sw	s0,12(sp)
 494:	c426                	sw	s1,8(sp)
 496:	c24a                	sw	s2,4(sp)
 498:	c04e                	sw	s3,0(sp)
    plic_idx_sort[i] = i;
 49a:	4709                	li	a4,2
 49c:	c798                	sw	a4,8(a5)
 49e:	470d                	li	a4,3
 4a0:	c7d8                	sw	a4,12(a5)
 4a2:	4711                	li	a4,4
 4a4:	cb98                	sw	a4,16(a5)
 4a6:	4715                	li	a4,5
 4a8:	cbd8                	sw	a4,20(a5)
 4aa:	4719                	li	a4,6
 4ac:	cf98                	sw	a4,24(a5)
  }

  // 19-Comparator Sorting Network for N=8
  // Layer 1
  CS(0, 1);
 4ae:	0207a283          	lw	t0,32(a5) # 10000020 <plic_irq_priorities>
    plic_idx_sort[i] = i;
 4b2:	471d                	li	a4,7
  CS(0, 1);
 4b4:	53c4                	lw	s1,36(a5)
    plic_idx_sort[i] = i;
 4b6:	cfd8                	sw	a4,28(a5)
 4b8:	4705                	li	a4,1
 4ba:	0007a023          	sw	zero,0(a5)
 4be:	c3d8                	sw	a4,4(a5)
  CS(0, 1);
 4c0:	8eba                	mv	t4,a4
 4c2:	4401                	li	s0,0
 4c4:	0092da63          	bge	t0,s1,4d8 <resort_by_prior+0x50>
 4c8:	8696                	mv	a3,t0
 4ca:	c398                	sw	a4,0(a5)
 4cc:	82a6                	mv	t0,s1
 4ce:	0007a223          	sw	zero,4(a5)
 4d2:	84b6                	mv	s1,a3
 4d4:	843a                	mv	s0,a4
 4d6:	4e81                	li	t4,0
  CS(2, 3);
 4d8:	578c                	lw	a1,40(a5)
 4da:	57d8                	lw	a4,44(a5)
 4dc:	4f0d                	li	t5,3
 4de:	4809                	li	a6,2
 4e0:	00e5db63          	bge	a1,a4,4f6 <resort_by_prior+0x6e>
 4e4:	86ae                	mv	a3,a1
 4e6:	01e7a423          	sw	t5,8(a5)
 4ea:	0107a623          	sw	a6,12(a5)
 4ee:	85ba                	mv	a1,a4
 4f0:	8f42                	mv	t5,a6
 4f2:	8736                	mv	a4,a3
 4f4:	480d                	li	a6,3
  CS(4, 5);
 4f6:	5b94                	lw	a3,48(a5)
 4f8:	5bd0                	lw	a2,52(a5)
 4fa:	4e15                	li	t3,5
 4fc:	4311                	li	t1,4
 4fe:	00c6db63          	bge	a3,a2,514 <resort_by_prior+0x8c>
 502:	8536                	mv	a0,a3
 504:	01c7a823          	sw	t3,16(a5)
 508:	0067aa23          	sw	t1,20(a5)
 50c:	86b2                	mv	a3,a2
 50e:	8e1a                	mv	t3,t1
 510:	862a                	mv	a2,a0
 512:	4315                	li	t1,5
  CS(6, 7);
 514:	5f88                	lw	a0,56(a5)
 516:	03c7af83          	lw	t6,60(a5)
 51a:	439d                	li	t2,7
 51c:	4899                	li	a7,6
 51e:	01f55b63          	bge	a0,t6,534 <resort_by_prior+0xac>
 522:	892a                	mv	s2,a0
 524:	0077ac23          	sw	t2,24(a5)
 528:	0117ae23          	sw	a7,28(a5)
 52c:	857e                	mv	a0,t6
 52e:	83c6                	mv	t2,a7
 530:	8fca                	mv	t6,s2
 532:	489d                	li	a7,7
  // Layer 2
  CS(0, 2);
 534:	00b2db63          	bge	t0,a1,54a <resort_by_prior+0xc2>
 538:	89ae                	mv	s3,a1
 53a:	8942                	mv	s2,a6
 53c:	0107a023          	sw	a6,0(a5)
 540:	c780                	sw	s0,8(a5)
 542:	8596                	mv	a1,t0
 544:	8822                	mv	a6,s0
 546:	82ce                	mv	t0,s3
 548:	844a                	mv	s0,s2
  CS(1, 3);
 54a:	00e4dc63          	bge	s1,a4,562 <resort_by_prior+0xda>
 54e:	89a6                	mv	s3,s1
 550:	8976                	mv	s2,t4
 552:	01d7a623          	sw	t4,12(a5)
 556:	01e7a223          	sw	t5,4(a5)
 55a:	84ba                	mv	s1,a4
 55c:	8efa                	mv	t4,t5
 55e:	874e                	mv	a4,s3
 560:	8f4a                	mv	t5,s2
  CS(4, 6);
 562:	00a6dc63          	bge	a3,a0,57a <resort_by_prior+0xf2>
 566:	89aa                	mv	s3,a0
 568:	8946                	mv	s2,a7
 56a:	0117a823          	sw	a7,16(a5)
 56e:	0067ac23          	sw	t1,24(a5)
 572:	8536                	mv	a0,a3
 574:	889a                	mv	a7,t1
 576:	86ce                	mv	a3,s3
 578:	834a                	mv	t1,s2
  CS(5, 7);
 57a:	01f65c63          	bge	a2,t6,592 <resort_by_prior+0x10a>
 57e:	89b2                	mv	s3,a2
 580:	8972                	mv	s2,t3
 582:	01c7ae23          	sw	t3,28(a5)
 586:	0077aa23          	sw	t2,20(a5)
 58a:	867e                	mv	a2,t6
 58c:	8e1e                	mv	t3,t2
 58e:	8fce                	mv	t6,s3
 590:	83ca                	mv	t2,s2
  // Layer 3
  CS(1, 2);
 592:	00b4dc63          	bge	s1,a1,5aa <resort_by_prior+0x122>
 596:	89a6                	mv	s3,s1
 598:	8976                	mv	s2,t4
 59a:	01d7a423          	sw	t4,8(a5)
 59e:	0107a223          	sw	a6,4(a5)
 5a2:	84ae                	mv	s1,a1
 5a4:	8ec2                	mv	t4,a6
 5a6:	85ce                	mv	a1,s3
 5a8:	884a                	mv	a6,s2
  CS(5, 6);
 5aa:	00a65c63          	bge	a2,a0,5c2 <resort_by_prior+0x13a>
 5ae:	89b2                	mv	s3,a2
 5b0:	8972                	mv	s2,t3
 5b2:	01c7ac23          	sw	t3,24(a5)
 5b6:	0117aa23          	sw	a7,20(a5)
 5ba:	862a                	mv	a2,a0
 5bc:	8e46                	mv	t3,a7
 5be:	854e                	mv	a0,s3
 5c0:	88ca                	mv	a7,s2
  CS(0, 4);
 5c2:	00d2d763          	bge	t0,a3,5d0 <resort_by_prior+0x148>
 5c6:	0067a023          	sw	t1,0(a5)
 5ca:	cb80                	sw	s0,16(a5)
 5cc:	8696                	mv	a3,t0
 5ce:	8322                	mv	t1,s0
  CS(3, 7);
 5d0:	01f75863          	bge	a4,t6,5e0 <resort_by_prior+0x158>
 5d4:	01e7ae23          	sw	t5,28(a5)
 5d8:	0077a623          	sw	t2,12(a5)
 5dc:	877e                	mv	a4,t6
 5de:	8f1e                	mv	t5,t2
  // Layer 4
  CS(1, 5);
 5e0:	00c4dc63          	bge	s1,a2,5f8 <resort_by_prior+0x170>
 5e4:	82a6                	mv	t0,s1
 5e6:	8ff6                	mv	t6,t4
 5e8:	01d7aa23          	sw	t4,20(a5)
 5ec:	01c7a223          	sw	t3,4(a5)
 5f0:	84b2                	mv	s1,a2
 5f2:	8ef2                	mv	t4,t3
 5f4:	8616                	mv	a2,t0
 5f6:	8e7e                	mv	t3,t6
  CS(2, 6);
 5f8:	00a5dc63          	bge	a1,a0,610 <resort_by_prior+0x188>
 5fc:	82aa                	mv	t0,a0
 5fe:	8fc6                	mv	t6,a7
 600:	0117a423          	sw	a7,8(a5)
 604:	0107ac23          	sw	a6,24(a5)
 608:	852e                	mv	a0,a1
 60a:	88c2                	mv	a7,a6
 60c:	8596                	mv	a1,t0
 60e:	887e                	mv	a6,t6
  // Layer 5
  CS(1, 4);
 610:	00d4d863          	bge	s1,a3,620 <resort_by_prior+0x198>
 614:	0067a223          	sw	t1,4(a5)
 618:	01d7a823          	sw	t4,16(a5)
 61c:	86a6                	mv	a3,s1
 61e:	8376                	mv	t1,t4
  CS(3, 6);
 620:	00a75863          	bge	a4,a0,630 <resort_by_prior+0x1a8>
 624:	01e7ac23          	sw	t5,24(a5)
 628:	0117a623          	sw	a7,12(a5)
 62c:	872a                	mv	a4,a0
 62e:	8f46                	mv	t5,a7
  // Layer 6
  CS(2, 4);
 630:	00d5d863          	bge	a1,a3,640 <resort_by_prior+0x1b8>
 634:	0067a423          	sw	t1,8(a5)
 638:	0107a823          	sw	a6,16(a5)
 63c:	86ae                	mv	a3,a1
 63e:	8342                	mv	t1,a6
  CS(3, 5);
 640:	00c75863          	bge	a4,a2,650 <resort_by_prior+0x1c8>
 644:	01e7aa23          	sw	t5,20(a5)
 648:	01c7a623          	sw	t3,12(a5)
 64c:	8732                	mv	a4,a2
 64e:	8f72                	mv	t5,t3
  // Layer 7
  CS(3, 4);
 650:	00d75663          	bge	a4,a3,65c <resort_by_prior+0x1d4>
 654:	0067a623          	sw	t1,12(a5)
 658:	01e7a823          	sw	t5,16(a5)
}
 65c:	4432                	lw	s0,12(sp)
 65e:	44a2                	lw	s1,8(sp)
 660:	4912                	lw	s2,4(sp)
 662:	4982                	lw	s3,0(sp)
 664:	0141                	addi	sp,sp,16
 666:	8082                	ret

00000668 <reg_irq_handler>:
  *PLIC_IRQ_ACTV |= actv_mask;
 668:	200008b7          	lui	a7,0x20000
 66c:	0008a803          	lw	a6,0(a7) # 20000000 <_stack_top+0xfff0000>
  plic_irq_priorities[arr_idx] = priority;
 670:	100007b7          	lui	a5,0x10000
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 674:	068a                	slli	a3,a3,0x2
 676:	81018713          	addi	a4,gp,-2032 # 10000050 <plic_irq_handlers>
  plic_irq_priorities[arr_idx] = priority;
 67a:	00078793          	mv	a5,a5
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 67e:	9736                	add	a4,a4,a3
  plic_irq_priorities[arr_idx] = priority;
 680:	97b6                	add	a5,a5,a3
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 682:	c308                	sw	a0,0(a4)
  plic_irq_priorities[arr_idx] = priority;
 684:	d38c                	sw	a1,32(a5)
  *PLIC_IRQ_ACTV |= actv_mask;
 686:	00c86833          	or	a6,a6,a2
 68a:	0108a023          	sw	a6,0(a7)
  resort_by_prior();
 68e:	bbed                	j	488 <resort_by_prior>

00000690 <reg_timer_irq>:

void reg_timer_irq(void (*_timer_irq_handler)(void)) {
  timer_irq_handler = _timer_irq_handler;
 690:	100007b7          	lui	a5,0x10000
 694:	04a7a423          	sw	a0,72(a5) # 10000048 <timer_irq_handler>
}
 698:	8082                	ret

0000069a <init_ring_buffer>:
#include "../include/ring_buff.h"

void init_ring_buffer(ring_buffer_t *rb) {
  // No malloc needed! The memory is already allocated as part of the struct.
  rb->head = 0;
 69a:	10050023          	sb	zero,256(a0)
  rb->tail = 0;
 69e:	100500a3          	sb	zero,257(a0)
}
 6a2:	8082                	ret

000006a4 <reset_ring_buffer>:

void reset_ring_buffer(ring_buffer_t *rb) {
 6a4:	10050023          	sb	zero,256(a0)
 6a8:	100500a3          	sb	zero,257(a0)
 6ac:	8082                	ret

000006ae <insert_rb>:
}

bool insert_rb(ring_buffer_t *rb, char c) {
  // Calculate what the next head position will be.
  // uint8_t naturally wraps from 255 back to 0.
  uint8_t next_head = (uint8_t)(rb->head + 1);
 6ae:	10054703          	lbu	a4,256(a0)

  // If the next head hits the tail, the buffer is full.
  // Note: This design sacrifices 1 byte of capacity, holding a max of 255
  // items.
  if (next_head == rb->tail) {
 6b2:	10154683          	lbu	a3,257(a0)
  uint8_t next_head = (uint8_t)(rb->head + 1);
 6b6:	00170793          	addi	a5,a4,1 # 20003001 <_stack_top+0xfff3001>
 6ba:	0ff7f793          	zext.b	a5,a5
  if (next_head == rb->tail) {
 6be:	00f68963          	beq	a3,a5,6d0 <insert_rb+0x22>
    return false;
  }

  rb->buffer[rb->head] = c;
 6c2:	972a                	add	a4,a4,a0
 6c4:	00b70023          	sb	a1,0(a4)
  rb->head = next_head;
 6c8:	10f50023          	sb	a5,256(a0)

  return true;
 6cc:	4505                	li	a0,1
 6ce:	8082                	ret
    return false;
 6d0:	4501                	li	a0,0
}
 6d2:	8082                	ret

000006d4 <pop_rb>:

bool pop_rb(ring_buffer_t *rb, char *c) {
  // If head and tail are at the same position, the buffer is empty.
  if (rb->head == rb->tail) {
 6d4:	10154703          	lbu	a4,257(a0)
 6d8:	10054683          	lbu	a3,256(a0)
bool pop_rb(ring_buffer_t *rb, char *c) {
 6dc:	87aa                	mv	a5,a0
  if (rb->head == rb->tail) {
 6de:	00e68e63          	beq	a3,a4,6fa <pop_rb+0x26>
    return false;
  }

  *c = rb->buffer[rb->tail];
 6e2:	972a                	add	a4,a4,a0
 6e4:	00074703          	lbu	a4,0(a4)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0

  return true;
 6e8:	4505                	li	a0,1
  *c = rb->buffer[rb->tail];
 6ea:	00e58023          	sb	a4,0(a1)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0
 6ee:	1017c703          	lbu	a4,257(a5)
 6f2:	972a                	add	a4,a4,a0
 6f4:	10e780a3          	sb	a4,257(a5)
  return true;
 6f8:	8082                	ret
    return false;
 6fa:	4501                	li	a0,0
}
 6fc:	8082                	ret

000006fe <init_timers>:
#include "../include/timer.h"
#include <stdint.h>

void init_timers() {
 6fe:	1141                	addi	sp,sp,-16
 700:	c606                	sw	ra,12(sp)

  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 702:	20000737          	lui	a4,0x20000
 706:	56fd                	li	a3,-1
 708:	c714                	sw	a3,8(a4)
  *TIMER_COMP_PART2 = 0xFFFFFFFF;

  reg_timer_irq(master_timer_isr);
 70a:	6505                	lui	a0,0x1
  *TIMER_COMP_PART2 = 0xFFFFFFFF;
 70c:	c754                	sw	a3,12(a4)
  reg_timer_irq(master_timer_isr);
 70e:	93a50513          	addi	a0,a0,-1734 # 93a <master_timer_isr>
 712:	3fbd                	jal	690 <reg_timer_irq>

  set_csr(mie, MIE_MTIE);
 714:	08000793          	li	a5,128
 718:	3047a7f3          	csrrs	a5,mie,a5
}
 71c:	40b2                	lw	ra,12(sp)
 71e:	0141                	addi	sp,sp,16
 720:	8082                	ret

00000722 <read_time>:

uint64_t read_time() {
  uint32_t lo = *TIMER_COMP_PART1;
 722:	200007b7          	lui	a5,0x20000
 726:	4788                	lw	a0,8(a5)

  uint32_t hi = *TIMER_COMP_PART2;
 728:	200007b7          	lui	a5,0x20000

  return (((uint64_t)hi) << 32) | lo;
}
 72c:	47cc                	lw	a1,12(a5)
 72e:	8082                	ret

00000730 <set_compare>:

void set_compare(uint64_t comp) {
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 730:	200007b7          	lui	a5,0x20000
 734:	56fd                	li	a3,-1
 736:	c794                	sw	a3,8(a5)

  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 738:	c7cc                	sw	a1,12(a5)

  *TIMER_COMP_PART1 = (uint32_t)comp;
 73a:	c788                	sw	a0,8(a5)
}
 73c:	8082                	ret

0000073e <swap_in_heap>:

void swap_in_heap(int a_i, int b_i) {
  irq_timer_t *temp = timer_heap[a_i];
 73e:	83018793          	addi	a5,gp,-2000 # 10000070 <timer_heap>
  timer_heap[a_i] = timer_heap[b_i];
 742:	058a                	slli	a1,a1,0x2
 744:	95be                	add	a1,a1,a5
  irq_timer_t *temp = timer_heap[a_i];
 746:	050a                	slli	a0,a0,0x2
  timer_heap[a_i] = timer_heap[b_i];
 748:	4194                	lw	a3,0(a1)
  irq_timer_t *temp = timer_heap[a_i];
 74a:	97aa                	add	a5,a5,a0
 74c:	4398                	lw	a4,0(a5)
  timer_heap[a_i] = timer_heap[b_i];
 74e:	c394                	sw	a3,0(a5)
  timer_heap[b_i] = temp;
 750:	c198                	sw	a4,0(a1)
}
 752:	8082                	ret

00000754 <min_heapify>:

// first call should be, num_timers, 0
void min_heapify(int sz, int i) {
  int smallest = i;
  int left = 2 * i + 1;
 754:	00159793          	slli	a5,a1,0x1
 758:	00178693          	addi	a3,a5,1 # 20000001 <_stack_top+0xfff0001>
  int right = 2 * i + 2;

  if (left < sz &&
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 75c:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
  int right = 2 * i + 2;
 760:	0789                	addi	a5,a5,2
  if (left < sz &&
 762:	06a6de63          	bge	a3,a0,7de <min_heapify+0x8a>
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 766:	00269713          	slli	a4,a3,0x2
 76a:	00259613          	slli	a2,a1,0x2
 76e:	9742                	add	a4,a4,a6
 770:	00c80333          	add	t1,a6,a2
 774:	00072883          	lw	a7,0(a4) # 20000000 <_stack_top+0xfff0000>
 778:	00032e03          	lw	t3,0(t1)
 77c:	0048a703          	lw	a4,4(a7)
  if (left < sz &&
 780:	004e2303          	lw	t1,4(t3)
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 784:	0008a883          	lw	a7,0(a7)
  if (left < sz &&
 788:	00676863          	bltu	a4,t1,798 <min_heapify+0x44>
 78c:	04e31963          	bne	t1,a4,7de <min_heapify+0x8a>
 790:	000e2303          	lw	t1,0(t3)
 794:	0468f563          	bgeu	a7,t1,7de <min_heapify+0x8a>
    smallest = left;
  }

  if (right < sz &&
 798:	00a7dd63          	bge	a5,a0,7b2 <min_heapify+0x5e>
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 79c:	00279313          	slli	t1,a5,0x2
 7a0:	9342                	add	t1,t1,a6
 7a2:	00032e03          	lw	t3,0(t1)
  if (right < sz &&
 7a6:	004e2303          	lw	t1,4(t3)
 7aa:	00e36563          	bltu	t1,a4,7b4 <min_heapify+0x60>
 7ae:	06e30563          	beq	t1,a4,818 <min_heapify+0xc4>
 7b2:	87b6                	mv	a5,a3
    smallest = right;
  }

  if (smallest != i) {
 7b4:	06b78163          	beq	a5,a1,816 <min_heapify+0xc2>
  timer_heap[a_i] = timer_heap[b_i];
 7b8:	00279713          	slli	a4,a5,0x2
 7bc:	9742                	add	a4,a4,a6
  irq_timer_t *temp = timer_heap[a_i];
 7be:	00c806b3          	add	a3,a6,a2
  timer_heap[a_i] = timer_heap[b_i];
 7c2:	00072883          	lw	a7,0(a4)
  irq_timer_t *temp = timer_heap[a_i];
 7c6:	4290                	lw	a2,0(a3)
    swap_in_heap(i, smallest);
    min_heapify(sz, smallest);
 7c8:	85be                	mv	a1,a5
  timer_heap[a_i] = timer_heap[b_i];
 7ca:	0116a023          	sw	a7,0(a3)
  int left = 2 * i + 1;
 7ce:	00159793          	slli	a5,a1,0x1
 7d2:	00178693          	addi	a3,a5,1
  timer_heap[b_i] = temp;
 7d6:	c310                	sw	a2,0(a4)
  int right = 2 * i + 2;
 7d8:	0789                	addi	a5,a5,2
  if (left < sz &&
 7da:	f8a6c6e3          	blt	a3,a0,766 <min_heapify+0x12>
  if (right < sz &&
 7de:	00a7c363          	blt	a5,a0,7e4 <min_heapify+0x90>
 7e2:	8082                	ret
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 7e4:	00259613          	slli	a2,a1,0x2
 7e8:	00279713          	slli	a4,a5,0x2
 7ec:	00c806b3          	add	a3,a6,a2
 7f0:	9742                	add	a4,a4,a6
 7f2:	0006a303          	lw	t1,0(a3)
 7f6:	00072883          	lw	a7,0(a4)
  if (right < sz &&
 7fa:	00432683          	lw	a3,4(t1)
 7fe:	0048a703          	lw	a4,4(a7)
 802:	fad769e3          	bltu	a4,a3,7b4 <min_heapify+0x60>
 806:	00e69863          	bne	a3,a4,816 <min_heapify+0xc2>
 80a:	00032683          	lw	a3,0(t1)
 80e:	0008a703          	lw	a4,0(a7)
 812:	fad761e3          	bltu	a4,a3,7b4 <min_heapify+0x60>
  }
}
 816:	8082                	ret
  if (right < sz &&
 818:	000e2703          	lw	a4,0(t3)
 81c:	f9176ce3          	bltu	a4,a7,7b4 <min_heapify+0x60>
 820:	87b6                	mv	a5,a3
 822:	bf49                	j	7b4 <min_heapify+0x60>

00000824 <sift_up>:

void sift_up(int i) {
  int parent = (i - 1) / 2;
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 824:	04a05f63          	blez	a0,882 <sift_up+0x5e>
 828:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 82c:	00251793          	slli	a5,a0,0x2
 830:	97b2                	add	a5,a5,a2
 832:	0007a303          	lw	t1,0(a5)
  int parent = (i - 1) / 2;
 836:	fff50713          	addi	a4,a0,-1
 83a:	8705                	srai	a4,a4,0x1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 83c:	00032e83          	lw	t4,0(t1)
 840:	00432e03          	lw	t3,4(t1)
 844:	a809                	j	856 <sift_up+0x32>
  timer_heap[a_i] = timer_heap[b_i];
 846:	c10c                	sw	a1,0(a0)
  timer_heap[b_i] = temp;
 848:	0067a023          	sw	t1,0(a5)
    swap_in_heap(i, parent);

    // Move up the tree
    i = parent;
    parent = (i - 1) / 2;
 84c:	96c2                	add	a3,a3,a6
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 84e:	853a                	mv	a0,a4
 850:	cb0d                	beqz	a4,882 <sift_up+0x5e>
 852:	4016d713          	srai	a4,a3,0x1
 856:	00271793          	slli	a5,a4,0x2
 85a:	00f606b3          	add	a3,a2,a5
 85e:	428c                	lw	a1,0(a3)
  timer_heap[a_i] = timer_heap[b_i];
 860:	050a                	slli	a0,a0,0x2
    parent = (i - 1) / 2;
 862:	fff70813          	addi	a6,a4,-1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 866:	0045a883          	lw	a7,4(a1)
  timer_heap[b_i] = temp;
 86a:	87b6                	mv	a5,a3
  timer_heap[a_i] = timer_heap[b_i];
 86c:	9532                	add	a0,a0,a2
    parent = (i - 1) / 2;
 86e:	01f85693          	srli	a3,a6,0x1f
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 872:	fd1e6ae3          	bltu	t3,a7,846 <sift_up+0x22>
 876:	01c89663          	bne	a7,t3,882 <sift_up+0x5e>
 87a:	0005a883          	lw	a7,0(a1)
 87e:	fd1ee4e3          	bltu	t4,a7,846 <sift_up+0x22>
  }
}
 882:	8082                	ret

00000884 <_deactivate_timer.part.0>:
  // 1. Mark as inactive so the pool slot can be reused
  timer->active = false;

  // 2. Find the timer in the heap (O(N) search, but MAX_TIMERS is small)
  int heap_idx = -1;
  for (int i = 0; i < num_timers; i++) {
 884:	80c1a683          	lw	a3,-2036(gp) # 1000004c <num_timers>
  timer->active = false;
 888:	00050a23          	sb	zero,20(a0)
  for (int i = 0; i < num_timers; i++) {
 88c:	06d05063          	blez	a3,8ec <_deactivate_timer.part.0+0x68>
 890:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 894:	87b2                	mv	a5,a2
 896:	4581                	li	a1,0
 898:	a021                	j	8a0 <_deactivate_timer.part.0+0x1c>
 89a:	0585                	addi	a1,a1,1
 89c:	04d58863          	beq	a1,a3,8ec <_deactivate_timer.part.0+0x68>
    if (timer_heap[i] == timer) {
 8a0:	4398                	lw	a4,0(a5)
  for (int i = 0; i < num_timers; i++) {
 8a2:	0791                	addi	a5,a5,4
    if (timer_heap[i] == timer) {
 8a4:	fee51be3          	bne	a0,a4,89a <_deactivate_timer.part.0+0x16>
  if (heap_idx == -1) {
    return false; // Timer was active but not in heap (state error)
  }

  // 3. Replace the removed timer with the last timer in the heap
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8a8:	fff68513          	addi	a0,a3,-1
 8ac:	00251793          	slli	a5,a0,0x2
 8b0:	97b2                	add	a5,a5,a2
 8b2:	4398                	lw	a4,0(a5)
bool _deactivate_timer(irq_timer_t *timer) {
 8b4:	1141                	addi	sp,sp,-16
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8b6:	00259793          	slli	a5,a1,0x2
bool _deactivate_timer(irq_timer_t *timer) {
 8ba:	c606                	sw	ra,12(sp)
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8bc:	97b2                	add	a5,a5,a2
  num_timers--;
 8be:	80a1a623          	sw	a0,-2036(gp) # 1000004c <num_timers>
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8c2:	c398                	sw	a4,0(a5)

  // 4. Restore the heap property
  if (heap_idx < num_timers) {
 8c4:	02a5d663          	bge	a1,a0,8f0 <_deactivate_timer.part.0+0x6c>
    int parent = (heap_idx - 1) / 2;

    // If the new node is smaller than its parent, it needs to bubble up
    if (heap_idx > 0 &&
 8c8:	c5ad                	beqz	a1,932 <_deactivate_timer.part.0+0xae>
    int parent = (heap_idx - 1) / 2;
 8ca:	fff58793          	addi	a5,a1,-1
 8ce:	8785                	srai	a5,a5,0x1
        timer_heap[heap_idx]->expires_at < timer_heap[parent]->expires_at) {
 8d0:	078a                	slli	a5,a5,0x2
 8d2:	963e                	add	a2,a2,a5
 8d4:	4210                	lw	a2,0(a2)
    if (heap_idx > 0 &&
 8d6:	435c                	lw	a5,4(a4)
 8d8:	4254                	lw	a3,4(a2)
 8da:	04d7e963          	bltu	a5,a3,92c <_deactivate_timer.part.0+0xa8>
 8de:	04f68363          	beq	a3,a5,924 <_deactivate_timer.part.0+0xa0>
      sift_up(heap_idx);
    }
    // Otherwise, it might need to bubble down
    else {
      min_heapify(num_timers, heap_idx);
 8e2:	3d8d                	jal	754 <min_heapify>
      set_compare(0xFFFFFFFFFFFFFFFFULL);
    }
  }

  return true;
}
 8e4:	40b2                	lw	ra,12(sp)
  return true;
 8e6:	4505                	li	a0,1
}
 8e8:	0141                	addi	sp,sp,16
 8ea:	8082                	ret
    return false;
 8ec:	4501                	li	a0,0
}
 8ee:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 8f0:	ed99                	bnez	a1,90e <_deactivate_timer.part.0+0x8a>
    if (num_timers > 0) {
 8f2:	cd19                	beqz	a0,910 <_deactivate_timer.part.0+0x8c>
      set_compare(timer_heap[0]->expires_at);
 8f4:	4218                	lw	a4,0(a2)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 8f6:	200007b7          	lui	a5,0x20000
 8fa:	55fd                	li	a1,-1
      set_compare(timer_heap[0]->expires_at);
 8fc:	4350                	lw	a2,4(a4)
 8fe:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 900:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 902:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 904:	c794                	sw	a3,8(a5)
}
 906:	40b2                	lw	ra,12(sp)
  return true;
 908:	4505                	li	a0,1
}
 90a:	0141                	addi	sp,sp,16
 90c:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 90e:	fd65                	bnez	a0,906 <_deactivate_timer.part.0+0x82>
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 910:	200007b7          	lui	a5,0x20000
 914:	577d                	li	a4,-1
 916:	c798                	sw	a4,8(a5)
}
 918:	40b2                	lw	ra,12(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 91a:	c7d8                	sw	a4,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 91c:	c798                	sw	a4,8(a5)
  return true;
 91e:	4505                	li	a0,1
}
 920:	0141                	addi	sp,sp,16
 922:	8082                	ret
    if (heap_idx > 0 &&
 924:	4214                	lw	a3,0(a2)
 926:	431c                	lw	a5,0(a4)
 928:	fad7fde3          	bgeu	a5,a3,8e2 <_deactivate_timer.part.0+0x5e>
      sift_up(heap_idx);
 92c:	852e                	mv	a0,a1
 92e:	3ddd                	jal	824 <sift_up>
  if (heap_idx == 0 || num_timers == 0) {
 930:	bfd9                	j	906 <_deactivate_timer.part.0+0x82>
      min_heapify(num_timers, heap_idx);
 932:	350d                	jal	754 <min_heapify>
  if (heap_idx == 0 || num_timers == 0) {
 934:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 938:	bf75                	j	8f4 <_deactivate_timer.part.0+0x70>

0000093a <master_timer_isr>:

void master_timer_isr() {
 93a:	1101                	addi	sp,sp,-32
 93c:	c452                	sw	s4,8(sp)
  // Loop to handle cases where multiple timers expire at the same time,
  // or if a callback execution delays us past the next timer's expiration.
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 93e:	80c1a783          	lw	a5,-2036(gp) # 1000004c <num_timers>
void master_timer_isr() {
 942:	ce06                	sw	ra,28(sp)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 944:	04f05f63          	blez	a5,9a2 <master_timer_isr+0x68>
 948:	ca26                	sw	s1,20(sp)
 94a:	c84a                	sw	s2,16(sp)
 94c:	c64e                	sw	s3,12(sp)
 94e:	200009b7          	lui	s3,0x20000
 952:	20000937          	lui	s2,0x20000
 956:	cc22                	sw	s0,24(sp)
 958:	c256                	sw	s5,4(sp)
 95a:	83018493          	addi	s1,gp,-2000 # 10000070 <timer_heap>
 95e:	09a1                	addi	s3,s3,8 # 20000008 <_stack_top+0xfff0008>
 960:	0931                	addi	s2,s2,12 # 2000000c <_stack_top+0xfff000c>
 962:	4080                	lw	s0,0(s1)
  uint32_t lo = *TIMER_COMP_PART1;
 964:	0009a683          	lw	a3,0(s3)
  uint32_t hi = *TIMER_COMP_PART2;
 968:	00092783          	lw	a5,0(s2)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 96c:	4058                	lw	a4,4(s0)
 96e:	06e7e263          	bltu	a5,a4,9d2 <master_timer_isr+0x98>
 972:	04f70d63          	beq	a4,a5,9cc <master_timer_isr+0x92>

    // 1. Get the timer at the top of the heap
    irq_timer_t *top_timer = timer_heap[0];

    // 2. Run the callback function
    if (top_timer->callback_function != NULL) {
 976:	481c                	lw	a5,16(s0)
 978:	c391                	beqz	a5,97c <master_timer_isr+0x42>
      // Cast the void* to a function pointer and execute it
      void (*callback)(void) = (void (*)(void))top_timer->callback_function;
      callback();
 97a:	9782                	jalr	a5
    }

    // 3. Handle periodic vs absolute
    if (top_timer->period > 0) {
 97c:	441c                	lw	a5,8(s0)
 97e:	4454                	lw	a3,12(s0)
 980:	00d7e733          	or	a4,a5,a3
 984:	e31d                	bnez	a4,9aa <master_timer_isr+0x70>
  if (timer == NULL || !timer->active) {
 986:	01444783          	lbu	a5,20(s0)
 98a:	c399                	beqz	a5,990 <master_timer_isr+0x56>
  timer->active = false;
 98c:	8522                	mv	a0,s0
 98e:	3ddd                	jal	884 <_deactivate_timer.part.0>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 990:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
 994:	fd5047e3          	bgtz	s5,962 <master_timer_isr+0x28>
 998:	4462                	lw	s0,24(sp)
 99a:	44d2                	lw	s1,20(sp)
 99c:	4942                	lw	s2,16(sp)
 99e:	49b2                	lw	s3,12(sp)
 9a0:	4a92                	lw	s5,4(sp)
  }

  if (num_timers > 0) {
    set_compare(timer_heap[0]->expires_at);
  }
}
 9a2:	40f2                	lw	ra,28(sp)
 9a4:	4a22                	lw	s4,8(sp)
 9a6:	6105                	addi	sp,sp,32
 9a8:	8082                	ret
      top_timer->expires_at += top_timer->period;
 9aa:	4018                	lw	a4,0(s0)
 9ac:	4050                	lw	a2,4(s0)
      min_heapify(num_timers, 0);
 9ae:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
      top_timer->expires_at += top_timer->period;
 9b2:	97ba                	add	a5,a5,a4
 9b4:	00e7b733          	sltu	a4,a5,a4
 9b8:	96b2                	add	a3,a3,a2
 9ba:	9736                	add	a4,a4,a3
 9bc:	c01c                	sw	a5,0(s0)
 9be:	c058                	sw	a4,4(s0)
      min_heapify(num_timers, 0);
 9c0:	8556                	mv	a0,s5
 9c2:	4581                	li	a1,0
 9c4:	3b41                	jal	754 <min_heapify>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 9c6:	f9504ee3          	bgtz	s5,962 <master_timer_isr+0x28>
 9ca:	b7f9                	j	998 <master_timer_isr+0x5e>
 9cc:	401c                	lw	a5,0(s0)
 9ce:	faf6f4e3          	bgeu	a3,a5,976 <master_timer_isr+0x3c>
    set_compare(timer_heap[0]->expires_at);
 9d2:	4098                	lw	a4,0(s1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 9d4:	200007b7          	lui	a5,0x20000
 9d8:	55fd                	li	a1,-1
    set_compare(timer_heap[0]->expires_at);
 9da:	4350                	lw	a2,4(a4)
 9dc:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 9de:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 9e0:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 9e2:	c794                	sw	a3,8(a5)
 9e4:	bf55                	j	998 <master_timer_isr+0x5e>

000009e6 <register_isr_periodic>:
  if (num_timers == MAX_TIMERS) {
 9e6:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 9ea:	04000793          	li	a5,64
 9ee:	0af88e63          	beq	a7,a5,aaa <register_isr_periodic+0xc4>
    if (timer_pool[i].active == false) {
 9f2:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 9f6:	11484783          	lbu	a5,276(a6)
irq_timer_handler register_isr_periodic(uint64_t period, void *cb) {
 9fa:	1101                	addi	sp,sp,-32
 9fc:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 9fe:	cbc5                	beqz	a5,aae <register_isr_periodic+0xc8>
 a00:	12c80793          	addi	a5,a6,300
  int i = 0;
 a04:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 a06:	0007c683          	lbu	a3,0(a5) # 20000000 <_stack_top+0xfff0000>
 a0a:	07e1                	addi	a5,a5,24
      i++;
 a0c:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 a0e:	fee5                	bnez	a3,a06 <register_isr_periodic+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 a10:	00171793          	slli	a5,a4,0x1
 a14:	00e78333          	add	t1,a5,a4
 a18:	030e                	slli	t1,t1,0x3
 a1a:	10080693          	addi	a3,a6,256
 a1e:	969a                	add	a3,a3,t1
  uint32_t lo = *TIMER_COMP_PART1;
 a20:	20000e37          	lui	t3,0x20000
  timer_pool[i].expires_at = read_time() + period;
 a24:	97ba                	add	a5,a5,a4
  uint32_t lo = *TIMER_COMP_PART1;
 a26:	008e2703          	lw	a4,8(t3) # 20000008 <_stack_top+0xfff0008>
 a2a:	832a                	mv	t1,a0
  uint32_t hi = *TIMER_COMP_PART2;
 a2c:	00ce2503          	lw	a0,12(t3)
  timer_pool[i].expires_at = read_time() + period;
 a30:	006702b3          	add	t0,a4,t1
 a34:	00e2b733          	sltu	a4,t0,a4
 a38:	952e                	add	a0,a0,a1
 a3a:	078e                	slli	a5,a5,0x3
 a3c:	97c2                	add	a5,a5,a6
 a3e:	972a                	add	a4,a4,a0
  timer_pool[i].active = true;
 a40:	4385                	li	t2,1
  timer_heap[num_timers - 1] = &timer_pool[i];
 a42:	00289f13          	slli	t5,a7,0x2
  timer_pool[i].expires_at = read_time() + period;
 a46:	10e7a223          	sw	a4,260(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 a4a:	9f42                	add	t5,t5,a6
  num_timers++;
 a4c:	00788733          	add	a4,a7,t2
  sift_up(num_timers - 1);
 a50:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + period;
 a52:	1057a023          	sw	t0,256(a5)
  timer_pool[i].period = period;
 a56:	1067a423          	sw	t1,264(a5)
 a5a:	10b7a623          	sw	a1,268(a5)
  timer_pool[i].callback_function = cb;
 a5e:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 a62:	10778a23          	sb	t2,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 a66:	00df2023          	sw	a3,0(t5)
 a6a:	c636                	sw	a3,12(sp)
  num_timers++;
 a6c:	80e1a623          	sw	a4,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 a70:	3b55                	jal	824 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 a72:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 a76:	46b2                	lw	a3,12(sp)
 a78:	20000eb7          	lui	t4,0x20000
 a7c:	20000e37          	lui	t3,0x20000
 a80:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 a82:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 a84:	00d78663          	beq	a5,a3,a90 <register_isr_periodic+0xaa>
}
 a88:	40f2                	lw	ra,28(sp)
  return new_handler;
 a8a:	8536                	mv	a0,a3
}
 a8c:	6105                	addi	sp,sp,32
 a8e:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 a90:	42d8                	lw	a4,4(a3)
 a92:	429c                	lw	a5,0(a3)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a94:	567d                	li	a2,-1
 a96:	00ce2023          	sw	a2,0(t3)
}
 a9a:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 a9c:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 aa0:	00fe2023          	sw	a5,0(t3)
  return new_handler;
 aa4:	8536                	mv	a0,a3
}
 aa6:	6105                	addi	sp,sp,32
 aa8:	8082                	ret
    return (irq_timer_handler){};
 aaa:	4501                	li	a0,0
}
 aac:	8082                	ret
    if (timer_pool[i].active == false) {
 aae:	10080693          	addi	a3,a6,256
  int i = 0;
 ab2:	4701                	li	a4,0
 ab4:	b7b5                	j	a20 <register_isr_periodic+0x3a>

00000ab6 <register_isr_abs>:
  if (num_timers == MAX_TIMERS) {
 ab6:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 aba:	04000793          	li	a5,64
 abe:	0cf88063          	beq	a7,a5,b7e <register_isr_abs+0xc8>
    if (timer_pool[i].active == false) {
 ac2:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 ac6:	11484783          	lbu	a5,276(a6)
bool register_isr_abs(uint64_t offset, void *cb) {
 aca:	1101                	addi	sp,sp,-32
 acc:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 ace:	cbd5                	beqz	a5,b82 <register_isr_abs+0xcc>
 ad0:	12c80793          	addi	a5,a6,300
  int i = 0;
 ad4:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 ad6:	0007c683          	lbu	a3,0(a5)
 ada:	07e1                	addi	a5,a5,24
      i++;
 adc:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 ade:	fee5                	bnez	a3,ad6 <register_isr_abs+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 ae0:	00171793          	slli	a5,a4,0x1
 ae4:	00e786b3          	add	a3,a5,a4
 ae8:	068e                	slli	a3,a3,0x3
 aea:	10080313          	addi	t1,a6,256
 aee:	9336                	add	t1,t1,a3
  uint32_t lo = *TIMER_COMP_PART1;
 af0:	20000e37          	lui	t3,0x20000
 af4:	008e2683          	lw	a3,8(t3) # 20000008 <_stack_top+0xfff0008>
  uint32_t hi = *TIMER_COMP_PART2;
 af8:	00ce2f83          	lw	t6,12(t3)
  timer_pool[i].expires_at = read_time() + offset;
 afc:	97ba                	add	a5,a5,a4
 afe:	00a68733          	add	a4,a3,a0
  timer_pool[i].active = true;
 b02:	4285                	li	t0,1
  timer_pool[i].expires_at = read_time() + offset;
 b04:	00bf8533          	add	a0,t6,a1
 b08:	00d736b3          	sltu	a3,a4,a3
  timer_heap[num_timers - 1] = &timer_pool[i];
 b0c:	00289593          	slli	a1,a7,0x2
  timer_pool[i].expires_at = read_time() + offset;
 b10:	078e                	slli	a5,a5,0x3
 b12:	97c2                	add	a5,a5,a6
 b14:	96aa                	add	a3,a3,a0
  timer_heap[num_timers - 1] = &timer_pool[i];
 b16:	95c2                	add	a1,a1,a6
  num_timers++;
 b18:	00588fb3          	add	t6,a7,t0
  sift_up(num_timers - 1);
 b1c:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + offset;
 b1e:	10d7a223          	sw	a3,260(a5)
 b22:	10e7a023          	sw	a4,256(a5)
  timer_pool[i].period = 0;
 b26:	1007a423          	sw	zero,264(a5)
 b2a:	1007a623          	sw	zero,268(a5)
  timer_pool[i].callback_function = cb;
 b2e:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 b32:	10578a23          	sb	t0,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 b36:	0065a023          	sw	t1,0(a1)
 b3a:	c61a                	sw	t1,12(sp)
  num_timers++;
 b3c:	81f1a623          	sw	t6,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 b40:	31d5                	jal	824 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 b42:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 b46:	4332                	lw	t1,12(sp)
 b48:	20000eb7          	lui	t4,0x20000
 b4c:	20000e37          	lui	t3,0x20000
 b50:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 b52:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 b54:	00678663          	beq	a5,t1,b60 <register_isr_abs+0xaa>
}
 b58:	40f2                	lw	ra,28(sp)
  return true;
 b5a:	4505                	li	a0,1
}
 b5c:	6105                	addi	sp,sp,32
 b5e:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 b60:	00432703          	lw	a4,4(t1)
 b64:	00032783          	lw	a5,0(t1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 b68:	56fd                	li	a3,-1
 b6a:	00de2023          	sw	a3,0(t3)
}
 b6e:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 b70:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 b74:	00fe2023          	sw	a5,0(t3)
  return true;
 b78:	4505                	li	a0,1
}
 b7a:	6105                	addi	sp,sp,32
 b7c:	8082                	ret
    return false;
 b7e:	4501                	li	a0,0
}
 b80:	8082                	ret
    if (timer_pool[i].active == false) {
 b82:	10080313          	addi	t1,a6,256
  int i = 0;
 b86:	4701                	li	a4,0
 b88:	b7a5                	j	af0 <register_isr_abs+0x3a>

00000b8a <deactivate_timer>:
  if (timer == NULL || !timer->active) {
 b8a:	c509                	beqz	a0,b94 <deactivate_timer+0xa>
 b8c:	01454783          	lbu	a5,20(a0)
 b90:	c391                	beqz	a5,b94 <deactivate_timer+0xa>
  timer->active = false;
 b92:	b9cd                	j	884 <_deactivate_timer.part.0>
}
 b94:	4501                	li	a0,0
 b96:	8082                	ret

00000b98 <_deactivate_timer>:
  if (timer == NULL || !timer->active) {
 b98:	c509                	beqz	a0,ba2 <_deactivate_timer+0xa>
 b9a:	01454783          	lbu	a5,20(a0)
 b9e:	c391                	beqz	a5,ba2 <_deactivate_timer+0xa>
  timer->active = false;
 ba0:	b1d5                	j	884 <_deactivate_timer.part.0>
}
 ba2:	4501                	li	a0,0
 ba4:	8082                	ret

00000ba6 <uart_isr>:
ring_buffer_t rx_buffer;
ring_buffer_t tx_buffer;

// Define the Interrupt Service Routine
void uart_isr(void) {
  uint32_t irq_status = *UART_IRQ_STATUS;
 ba6:	200027b7          	lui	a5,0x20002
 baa:	07d1                	addi	a5,a5,20 # 20002014 <_stack_top+0xfff2014>
 bac:	439c                	lw	a5,0(a5)
void uart_isr(void) {
 bae:	7179                	addi	sp,sp,-48
 bb0:	d606                	sw	ra,44(sp)

  // Handle Incoming Data
  if (irq_status & IRQ_RX_AVAIL) {
 bb2:	0017f713          	andi	a4,a5,1
 bb6:	e705                	bnez	a4,bde <uart_isr+0x38>
    char c = (char)(*UART_RX_FIFO);
    insert_rb(&rx_buffer, c); // Push to RX buffer
  }

  // Handle Outgoing Data
  if ((irq_status & IRQ_TX_EMPTY) && (*UART_IRQ_EN & IRQ_TX_EMPTY)) {
 bb8:	0027f713          	andi	a4,a5,2
 bbc:	c711                	beqz	a4,bc8 <uart_isr+0x22>
 bbe:	20002737          	lui	a4,0x20002
 bc2:	4b14                	lw	a3,16(a4)
 bc4:	8a89                	andi	a3,a3,2
 bc6:	e69d                	bnez	a3,bf4 <uart_isr+0x4e>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
    }
  }

  // Handle Hardware Errors
  if (irq_status & (IRQ_RX_OVERRUN | IRQ_FRAME_ERROR)) {
 bc8:	8bb1                	andi	a5,a5,12
 bca:	c799                	beqz	a5,bd8 <uart_isr+0x32>
    *UART_CTRL |= CTRL_CLR_ERRORS; // Clear the hardware error states
 bcc:	200027b7          	lui	a5,0x20002
 bd0:	47d8                	lw	a4,12(a5)
 bd2:	00476713          	ori	a4,a4,4
 bd6:	c7d8                	sw	a4,12(a5)
  }
}
 bd8:	50b2                	lw	ra,44(sp)
 bda:	6145                	addi	sp,sp,48
 bdc:	8082                	ret
    char c = (char)(*UART_RX_FIFO);
 bde:	200026b7          	lui	a3,0x20002
 be2:	428c                	lw	a1,0(a3)
    insert_rb(&rx_buffer, c); // Push to RX buffer
 be4:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 be8:	0ff5f593          	zext.b	a1,a1
 bec:	c63e                	sw	a5,12(sp)
 bee:	34c1                	jal	6ae <insert_rb>
 bf0:	47b2                	lw	a5,12(sp)
 bf2:	b7d9                	j	bb8 <uart_isr+0x12>
    if (pop_rb(&tx_buffer, &c)) {
 bf4:	03418513          	addi	a0,gp,52 # 10000874 <tx_buffer>
 bf8:	01f10593          	addi	a1,sp,31
 bfc:	c63e                	sw	a5,12(sp)
 bfe:	3cd9                	jal	6d4 <pop_rb>
 c00:	20002737          	lui	a4,0x20002
 c04:	47b2                	lw	a5,12(sp)
 c06:	0741                	addi	a4,a4,16 # 20002010 <_stack_top+0xfff2010>
 c08:	c519                	beqz	a0,c16 <uart_isr+0x70>
      *UART_TX_FIFO = (uint32_t)c;
 c0a:	01f14683          	lbu	a3,31(sp)
 c0e:	20002737          	lui	a4,0x20002
 c12:	c354                	sw	a3,4(a4)
 c14:	bf55                	j	bc8 <uart_isr+0x22>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c16:	4314                	lw	a3,0(a4)
 c18:	9af5                	andi	a3,a3,-3
 c1a:	c314                	sw	a3,0(a4)
 c1c:	b775                	j	bc8 <uart_isr+0x22>

00000c1e <uart_init>:

// Initialization function (Call this in main!)
void uart_init(void) {
 c1e:	1141                	addi	sp,sp,-16
  init_ring_buffer(&rx_buffer);
 c20:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
void uart_init(void) {
 c24:	c606                	sw	ra,12(sp)
  init_ring_buffer(&rx_buffer);
 c26:	3c95                	jal	69a <init_ring_buffer>
  init_ring_buffer(&tx_buffer);
 c28:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 c2c:	10450513          	addi	a0,a0,260
 c30:	34ad                	jal	69a <init_ring_buffer>

  // Register ISR with the MINA PLIC at priority 1
  reg_UART_irq(uart_isr, 1);
 c32:	4605                	li	a2,1
 c34:	6505                	lui	a0,0x1
 c36:	85b2                	mv	a1,a2
 c38:	ba650513          	addi	a0,a0,-1114 # ba6 <uart_isr>
 c3c:	4681                	li	a3,0
 c3e:	342d                	jal	668 <reg_irq_handler>

  // Enable the RX interrupt permanently so we never miss incoming data
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 c40:	200027b7          	lui	a5,0x20002
 c44:	4b98                	lw	a4,16(a5)
}
 c46:	40b2                	lw	ra,12(sp)
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 c48:	00176713          	ori	a4,a4,1
 c4c:	cb98                	sw	a4,16(a5)
}
 c4e:	0141                	addi	sp,sp,16
 c50:	8082                	ret

00000c52 <uart_putc>:

void uart_putc(char c) {
  // 1. Temporarily disable TX interrupts to avoid race conditions
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c52:	200027b7          	lui	a5,0x20002
 c56:	4b94                	lw	a3,16(a5)

  // 2. If the software buffer is empty AND the hardware TX FIFO is empty,
  // bypass the software buffer to kickstart the hardware transmission.
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c58:	f3018713          	addi	a4,gp,-208 # 10000770 <rx_buffer>
 c5c:	20474583          	lbu	a1,516(a4) # 20002204 <_stack_top+0xfff2204>
 c60:	20574603          	lbu	a2,517(a4)
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c64:	ffd6f713          	andi	a4,a3,-3
 c68:	cb98                	sw	a4,16(a5)
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c6a:	02c58863          	beq	a1,a2,c9a <uart_putc+0x48>
void uart_putc(char c) {
 c6e:	1141                	addi	sp,sp,-16
 c70:	c226                	sw	s1,4(sp)
 c72:	c422                	sw	s0,8(sp)
 c74:	c606                	sw	ra,12(sp)
 c76:	842a                	mv	s0,a0
 c78:	03418493          	addi	s1,gp,52 # 10000874 <tx_buffer>
    *UART_TX_FIFO = (uint32_t)c;
  } else {
    // Otherwise, hardware is busy. Queue it in the software buffer.
    while (!insert_rb(&tx_buffer, c)) {
 c7c:	85a2                	mv	a1,s0
 c7e:	8526                	mv	a0,s1
 c80:	343d                	jal	6ae <insert_rb>
 c82:	dd6d                	beqz	a0,c7c <uart_putc+0x2a>
      // Busy wait only if the 256-byte buffer is completely full
    }
  }

  // 3. Re-enable TX interrupts so the ISR handles the rest
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c84:	200027b7          	lui	a5,0x20002
 c88:	4b98                	lw	a4,16(a5)
}
 c8a:	40b2                	lw	ra,12(sp)
 c8c:	4422                	lw	s0,8(sp)
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c8e:	00276713          	ori	a4,a4,2
 c92:	cb98                	sw	a4,16(a5)
}
 c94:	4492                	lw	s1,4(sp)
 c96:	0141                	addi	sp,sp,16
 c98:	8082                	ret
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c9a:	200027b7          	lui	a5,0x20002
 c9e:	07a1                	addi	a5,a5,8 # 20002008 <_stack_top+0xfff2008>
 ca0:	439c                	lw	a5,0(a5)
 ca2:	8b91                	andi	a5,a5,4
 ca4:	d7e9                	beqz	a5,c6e <uart_putc+0x1c>
    *UART_TX_FIFO = (uint32_t)c;
 ca6:	200027b7          	lui	a5,0x20002
 caa:	c3c8                	sw	a0,4(a5)
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 cac:	200027b7          	lui	a5,0x20002
 cb0:	4b98                	lw	a4,16(a5)
 cb2:	00276713          	ori	a4,a4,2
 cb6:	cb98                	sw	a4,16(a5)
 cb8:	8082                	ret

00000cba <uart_getc>:

char uart_getc(void) {
 cba:	1101                	addi	sp,sp,-32
 cbc:	cc22                	sw	s0,24(sp)
 cbe:	ce06                	sw	ra,28(sp)
 cc0:	f3018413          	addi	s0,gp,-208 # 10000770 <rx_buffer>
  char c;
  // Block only when the software buffer is completely empty
  while (!pop_rb(&rx_buffer, &c)) {
 cc4:	00f10593          	addi	a1,sp,15
 cc8:	8522                	mv	a0,s0
 cca:	3429                	jal	6d4 <pop_rb>
 ccc:	dd65                	beqz	a0,cc4 <uart_getc+0xa>
    // Busy wait until the ISR receives new data
  }
  return c;
}
 cce:	40f2                	lw	ra,28(sp)
 cd0:	4462                	lw	s0,24(sp)
 cd2:	00f14503          	lbu	a0,15(sp)
 cd6:	6105                	addi	sp,sp,32
 cd8:	8082                	ret

00000cda <uart_puts>:

void uart_puts(const char *str) {
 cda:	1141                	addi	sp,sp,-16
 cdc:	c422                	sw	s0,8(sp)
 cde:	c606                	sw	ra,12(sp)
 ce0:	842a                	mv	s0,a0
  while (*str != '\0') {
 ce2:	00054503          	lbu	a0,0(a0)
 ce6:	c511                	beqz	a0,cf2 <uart_puts+0x18>
    uart_putc(*str);
 ce8:	37ad                	jal	c52 <uart_putc>
  while (*str != '\0') {
 cea:	00144503          	lbu	a0,1(s0)
    str++;
 cee:	0405                	addi	s0,s0,1
  while (*str != '\0') {
 cf0:	fd65                	bnez	a0,ce8 <uart_puts+0xe>
  }
}
 cf2:	40b2                	lw	ra,12(sp)
 cf4:	4422                	lw	s0,8(sp)
 cf6:	0141                	addi	sp,sp,16
 cf8:	8082                	ret

00000cfa <uart_polled_putc>:

void uart_polled_putc(char c) {
  // Wait directly on the hardware status register until TX FIFO is not
  // full/empty
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 cfa:	20002737          	lui	a4,0x20002
 cfe:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 d00:	431c                	lw	a5,0(a4)
 d02:	8b91                	andi	a5,a5,4
 d04:	dff5                	beqz	a5,d00 <uart_polled_putc+0x6>
    ;
  *UART_TX_FIFO = (uint32_t)c;
 d06:	200027b7          	lui	a5,0x20002
 d0a:	c3c8                	sw	a0,4(a5)
}
 d0c:	8082                	ret

00000d0e <uart_polled_puts>:

void uart_polled_puts(const char *str) {
  while (*str != '\0') {
 d0e:	00054683          	lbu	a3,0(a0)
 d12:	ce99                	beqz	a3,d30 <uart_polled_puts+0x22>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d14:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 d18:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d1c:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 d1e:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d20:	431c                	lw	a5,0(a4)
 d22:	8b91                	andi	a5,a5,4
 d24:	dff5                	beqz	a5,d20 <uart_polled_puts+0x12>
  *UART_TX_FIFO = (uint32_t)c;
 d26:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 d28:	00154683          	lbu	a3,1(a0)
    uart_polled_putc(*str);
    str++;
 d2c:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 d2e:	faed                	bnez	a3,d20 <uart_polled_puts+0x12>
  }
}
 d30:	8082                	ret

00000d32 <uart_print_hex>:
  while (*str != '\0') {
 d32:	00054683          	lbu	a3,0(a0)

void uart_print_hex(const char *prefix, uint32_t val) {
 d36:	1141                	addi	sp,sp,-16
  while (*str != '\0') {
 d38:	ce99                	beqz	a3,d56 <uart_print_hex+0x24>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d3a:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 d3e:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d42:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 d44:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d46:	431c                	lw	a5,0(a4)
 d48:	8b91                	andi	a5,a5,4
 d4a:	dff5                	beqz	a5,d46 <uart_print_hex+0x14>
  *UART_TX_FIFO = (uint32_t)c;
 d4c:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 d4e:	00154683          	lbu	a3,1(a0)
    str++;
 d52:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 d54:	faed                	bnez	a3,d46 <uart_print_hex+0x14>
  uart_polled_puts(prefix);
  char buf[9];
  buf[8] = '\0';
 d56:	00010623          	sb	zero,12(sp)
  for (int i = 7; i >= 0; i--) {
 d5a:	005c                	addi	a5,sp,4
 d5c:	ffc10513          	addi	a0,sp,-4
    uint32_t nibble = val & 0xF;
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 d60:	4625                	li	a2,9
    uint32_t nibble = val & 0xF;
 d62:	00f5f713          	andi	a4,a1,15
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 d66:	05770693          	addi	a3,a4,87
 d6a:	00e66463          	bltu	a2,a4,d72 <uart_print_hex+0x40>
 d6e:	03070693          	addi	a3,a4,48
 d72:	00d783a3          	sb	a3,7(a5) # 20002007 <_stack_top+0xfff2007>
  for (int i = 7; i >= 0; i--) {
 d76:	17fd                	addi	a5,a5,-1
    val >>= 4;
 d78:	8191                	srli	a1,a1,0x4
  for (int i = 7; i >= 0; i--) {
 d7a:	fef514e3          	bne	a0,a5,d62 <uart_print_hex+0x30>
  while (*str != '\0') {
 d7e:	00414683          	lbu	a3,4(sp)
 d82:	c285                	beqz	a3,da2 <uart_print_hex+0x70>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d84:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 d88:	200025b7          	lui	a1,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d8c:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 d8e:	0591                	addi	a1,a1,4 # 20002004 <_stack_top+0xfff2004>
  while (*str != '\0') {
 d90:	0050                	addi	a2,sp,4
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d92:	431c                	lw	a5,0(a4)
 d94:	8b91                	andi	a5,a5,4
 d96:	dff5                	beqz	a5,d92 <uart_print_hex+0x60>
  *UART_TX_FIFO = (uint32_t)c;
 d98:	c194                	sw	a3,0(a1)
  while (*str != '\0') {
 d9a:	00164683          	lbu	a3,1(a2)
    str++;
 d9e:	0605                	addi	a2,a2,1
  while (*str != '\0') {
 da0:	faed                	bnez	a3,d92 <uart_print_hex+0x60>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 da2:	20002737          	lui	a4,0x20002
 da6:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 da8:	431c                	lw	a5,0(a4)
 daa:	8b91                	andi	a5,a5,4
 dac:	dff5                	beqz	a5,da8 <uart_print_hex+0x76>
  *UART_TX_FIFO = (uint32_t)c;
 dae:	200027b7          	lui	a5,0x20002
 db2:	46b5                	li	a3,13
 db4:	c3d4                	sw	a3,4(a5)
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 db6:	00878713          	addi	a4,a5,8 # 20002008 <_stack_top+0xfff2008>
 dba:	431c                	lw	a5,0(a4)
 dbc:	8b91                	andi	a5,a5,4
 dbe:	dff5                	beqz	a5,dba <uart_print_hex+0x88>
  *UART_TX_FIFO = (uint32_t)c;
 dc0:	200027b7          	lui	a5,0x20002
 dc4:	4729                	li	a4,10
 dc6:	c3d8                	sw	a4,4(a5)
  }
  uart_polled_puts(buf);
  uart_polled_puts("\r\n");
}
 dc8:	0141                	addi	sp,sp,16
 dca:	8082                	ret
