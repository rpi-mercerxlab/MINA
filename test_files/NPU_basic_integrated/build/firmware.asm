
/tmp/mina_build_YEbGss/firmware.elf:     file format elf32-littleriscv


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
  18:	ecc50513          	addi	a0,a0,-308 # ee0 <_data_load_start>
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
 16e:	311000ef          	jal	c7e <uart_putc>
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
 190:	2ef000ef          	jal	c7e <uart_putc>
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
 1b0:	2cf000ef          	jal	c7e <uart_putc>
        uart_putc(' ');
 1b4:	02000513          	li	a0,32
 1b8:	2c7000ef          	jal	c7e <uart_putc>
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 1bc:	f92c9ce3          	bne	s9,s2,154 <npu_irq_handler+0x60>
    for (uint32_t word = 0; word < 2u; ++word) {
 1c0:	0a91                	addi	s5,s5,4
 1c2:	f95b14e3          	bne	s6,s5,14a <npu_irq_handler+0x56>
    uart_putc('\r');
 1c6:	4535                	li	a0,13
 1c8:	2b7000ef          	jal	c7e <uart_putc>
    uart_putc('\n');
 1cc:	4529                	li	a0,10
 1ce:	2b1000ef          	jal	c7e <uart_putc>
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
 1d2:	403007b7          	lui	a5,0x40300
 1d6:	0b21                	addi	s6,s6,8
 1d8:	44878793          	addi	a5,a5,1096 # 40300448 <_stack_top+0x302f0448>
 1dc:	f6fb13e3          	bne	s6,a5,142 <npu_irq_handler+0x4e>
  uart_putc('\r');
 1e0:	4535                	li	a0,13
 1e2:	29d000ef          	jal	c7e <uart_putc>
  uart_putc('\n');
 1e6:	4529                	li	a0,10
 1e8:	297000ef          	jal	c7e <uart_putc>

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
 21e:	261000ef          	jal	c7e <uart_putc>
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
 23a:	ca56                	sw	s5,20(sp)
  init_interrupts();
 23c:	20d5                	jal	320 <init_interrupts>
  uart_init();
 23e:	20d000ef          	jal	c4a <uart_init>
  reg_NPU_irq(npu_irq_handler, 1);
 242:	0f400513          	li	a0,244
 246:	4691                	li	a3,4
 248:	4641                	li	a2,16
 24a:	4585                	li	a1,1
 24c:	21a1                	jal	694 <reg_irq_handler>

  uart_puts("Starting program, loaded interrupts\n");
 24e:	6505                	lui	a0,0x1
 250:	df850513          	addi	a0,a0,-520 # df8 <uart_print_hex+0x9a>
 254:	2b3000ef          	jal	d06 <uart_puts>

  // Ensure NPU is halted and reset before touching Scratchpad RAM
  NPU_RESET();
 258:	40000437          	lui	s0,0x40000
 25c:	4709                	li	a4,2
 25e:	c018                	sw	a4,0(s0)
  while (!NPU_IS_HALTED()) {
 260:	00440793          	addi	a5,s0,4 # 40000004 <_stack_top+0x2fff0004>
 264:	4398                	lw	a4,0(a5)
 266:	8b05                	andi	a4,a4,1
 268:	df75                	beqz	a4,264 <main+0x38>
  }

  // Load initial Matrix A into Scratchpad at offset 0x200
  fill_matrix();
 26a:	3be5                	jal	62 <fill_matrix>

  // Start NPU execution from PC = 0
  NPU_START();
 26c:	6a85                	lui	s5,0x1
 26e:	4785                	li	a5,1
  uint32_t counter = 0;

  while (1) {
    counter++;
    if (counter == 100000000) {
      uart_puts("Program counter, NPU: ");
 270:	e20a8a93          	addi	s5,s5,-480 # e20 <uart_print_hex+0xc2>
  NPU_START();
 274:	c01c                	sw	a5,0(s0)

      uart_print_u32(NPU_READ_PC());
 276:	40000a37          	lui	s4,0x40000
      uart_puts("Program counter, NPU: ");
 27a:	8556                	mv	a0,s5
 27c:	28b000ef          	jal	d06 <uart_puts>
      uart_print_u32(NPU_READ_PC());
 280:	008a2783          	lw	a5,8(s4) # 40000008 <_stack_top+0x2fff0008>
    buf[i++] = '0' + (val % 10);
 284:	ccccd937          	lui	s2,0xccccd
      uart_print_u32(NPU_READ_PC());
 288:	0a21                	addi	s4,s4,8
 28a:	3ff7f793          	andi	a5,a5,1023
 28e:	0044                	addi	s1,sp,4
    buf[i++] = '0' + (val % 10);
 290:	ccd90913          	addi	s2,s2,-819 # cccccccd <_stack_top+0xbccbcccd>
  while (val > 0) {
 294:	49a5                	li	s3,9
  int i = 0;
 296:	4601                	li	a2,0
  if (val == 0) {
 298:	c7b9                	beqz	a5,2e6 <main+0xba>
    buf[i++] = '0' + (val % 10);
 29a:	0327b733          	mulhu	a4,a5,s2
 29e:	0605                	addi	a2,a2,1
 2a0:	85be                	mv	a1,a5
 2a2:	00c48433          	add	s0,s1,a2
 2a6:	830d                	srli	a4,a4,0x3
 2a8:	00271693          	slli	a3,a4,0x2
 2ac:	96ba                	add	a3,a3,a4
 2ae:	0686                	slli	a3,a3,0x1
 2b0:	8f95                	sub	a5,a5,a3
 2b2:	03078793          	addi	a5,a5,48
 2b6:	fef40fa3          	sb	a5,-1(s0)
    val /= 10;
 2ba:	87ba                	mv	a5,a4
  while (val > 0) {
 2bc:	fcb9efe3          	bltu	s3,a1,29a <main+0x6e>
    uart_putc(buf[--i]);
 2c0:	fff44503          	lbu	a0,-1(s0)
  while (i > 0) {
 2c4:	147d                	addi	s0,s0,-1
    uart_putc(buf[--i]);
 2c6:	1b9000ef          	jal	c7e <uart_putc>
  while (i > 0) {
 2ca:	fe849be3          	bne	s1,s0,2c0 <main+0x94>

      uart_putc('\n');
 2ce:	4529                	li	a0,10
 2d0:	1af000ef          	jal	c7e <uart_putc>
      uart_puts("Program counter, NPU: ");
 2d4:	8556                	mv	a0,s5
 2d6:	231000ef          	jal	d06 <uart_puts>
      uart_print_u32(NPU_READ_PC());
 2da:	000a2783          	lw	a5,0(s4)
  int i = 0;
 2de:	4601                	li	a2,0
      uart_print_u32(NPU_READ_PC());
 2e0:	3ff7f793          	andi	a5,a5,1023
  if (val == 0) {
 2e4:	fbdd                	bnez	a5,29a <main+0x6e>
    uart_putc('0');
 2e6:	03000513          	li	a0,48
 2ea:	195000ef          	jal	c7e <uart_putc>
      uart_putc('\n');
 2ee:	4529                	li	a0,10
 2f0:	18f000ef          	jal	c7e <uart_putc>
      counter = 0;
 2f4:	b7c5                	j	2d4 <main+0xa8>

000002f6 <set_input>:
#include "../include/gpio.h"

void set_input(int gpio_num) { *GPIO_T |= (1 << gpio_num); }
 2f6:	20003737          	lui	a4,0x20003
 2fa:	4354                	lw	a3,4(a4)
 2fc:	4785                	li	a5,1
 2fe:	00a797b3          	sll	a5,a5,a0
 302:	8fd5                	or	a5,a5,a3
 304:	c35c                	sw	a5,4(a4)
 306:	8082                	ret

00000308 <set_output>:
void set_output(int gpio_num) { *GPIO_T &= ~(1 << gpio_num); }
 308:	20003737          	lui	a4,0x20003
 30c:	4354                	lw	a3,4(a4)
 30e:	4785                	li	a5,1
 310:	00a797b3          	sll	a5,a5,a0
 314:	fff7c793          	not	a5,a5
 318:	8ff5                	and	a5,a5,a3
 31a:	c35c                	sw	a5,4(a4)
 31c:	8082                	ret
	...

00000320 <init_interrupts>:
int plic_idx_sort[8] = {0, 1, 2, 3, 4, 5, 6, 7};
void (*timer_irq_handler)(void) = NULL;

void init_interrupts(void) {
  // A. Point mtvec to our handler (Direct mode: lowest 2 bits are 00)
  write_csr(mtvec, (unsigned long)trap_handler);
 320:	3b800793          	li	a5,952
 324:	30579073          	csrw	mtvec,a5

  // B. Enable Machine External Interrupts in the 'mie' register
  set_csr(mie, MIE_MEIE);
 328:	6785                	lui	a5,0x1
 32a:	80078793          	addi	a5,a5,-2048 # 800 <min_heapify+0x80>
 32e:	3047a7f3          	csrrs	a5,mie,a5

  // C. Enable Global Machine Interrupts in the 'mstatus' register
  set_csr(mstatus, MSTATUS_MIE);
 332:	300467f3          	csrrsi	a5,mstatus,8
}
 336:	8082                	ret

00000338 <plic_irq_handler>:
      // Hang indefinitely for debugger attachment
    }
  }
}

void plic_irq_handler(void) {
 338:	7179                	addi	sp,sp,-48

  uint32_t pending = *PLIC_IRQ_PEND;
 33a:	200007b7          	lui	a5,0x20000
void plic_irq_handler(void) {
 33e:	c85a                	sw	s6,16(sp)
 340:	c65e                	sw	s7,12(sp)
 342:	10000b37          	lui	s6,0x10000
  uint32_t pending = *PLIC_IRQ_PEND;
 346:	0047ab83          	lw	s7,4(a5) # 20000004 <_stack_top+0xfff0004>

  for (int i = 0; i < 8; i++) {
 34a:	000b0b13          	mv	s6,s6
void plic_irq_handler(void) {
 34e:	d04a                	sw	s2,32(sp)
 350:	ca56                	sw	s5,20(sp)
          plic_irq_priorities[current_idx] != -1) {
        plic_irq_handlers[current_idx]();

        // THIS ASSUMES THE HANDLER CLEARS THE STATE CAUSING THE INTERRUPT,
        // OTHERWISE THE IRQ WILL TRIGGER AGAIN
        *PLIC_CLAIM_REG = 1 << current_idx;
 352:	20000ab7          	lui	s5,0x20000
void plic_irq_handler(void) {
 356:	d226                	sw	s1,36(sp)
 358:	ce4e                	sw	s3,28(sp)
 35a:	cc52                	sw	s4,24(sp)
 35c:	c462                	sw	s8,8(sp)
 35e:	d606                	sw	ra,44(sp)
 360:	d422                	sw	s0,40(sp)
 362:	84da                	mv	s1,s6
 364:	020b0a13          	addi	s4,s6,32 # 10000020 <plic_irq_priorities>
      if (plic_irq_handlers[current_idx] &&
 368:	81018913          	addi	s2,gp,-2032 # 10000050 <plic_irq_handlers>
        *PLIC_CLAIM_REG = 1 << current_idx;
 36c:	0aa1                	addi	s5,s5,8 # 20000008 <_stack_top+0xfff0008>
    if ((pending & (1 << current_idx)) != 0) {
 36e:	4985                	li	s3,1
      if (plic_irq_handlers[current_idx] &&
 370:	5c7d                	li	s8,-1
    int current_idx = plic_idx_sort[i];
 372:	409c                	lw	a5,0(s1)
    if ((pending & (1 << current_idx)) != 0) {
 374:	00f99433          	sll	s0,s3,a5
      if (plic_irq_handlers[current_idx] &&
 378:	00279713          	slli	a4,a5,0x2
    if ((pending & (1 << current_idx)) != 0) {
 37c:	017477b3          	and	a5,s0,s7
      if (plic_irq_handlers[current_idx] &&
 380:	00e906b3          	add	a3,s2,a4
    if ((pending & (1 << current_idx)) != 0) {
 384:	cb91                	beqz	a5,398 <plic_irq_handler+0x60>
      if (plic_irq_handlers[current_idx] &&
 386:	429c                	lw	a5,0(a3)
          plic_irq_priorities[current_idx] != -1) {
 388:	975a                	add	a4,a4,s6
      if (plic_irq_handlers[current_idx] &&
 38a:	c799                	beqz	a5,398 <plic_irq_handler+0x60>
 38c:	5318                	lw	a4,32(a4)
 38e:	01870563          	beq	a4,s8,398 <plic_irq_handler+0x60>
        plic_irq_handlers[current_idx]();
 392:	9782                	jalr	a5
        *PLIC_CLAIM_REG = 1 << current_idx;
 394:	008aa023          	sw	s0,0(s5)
  for (int i = 0; i < 8; i++) {
 398:	0491                	addi	s1,s1,4
 39a:	fd449ce3          	bne	s1,s4,372 <plic_irq_handler+0x3a>
      }
    }
  }
}
 39e:	50b2                	lw	ra,44(sp)
 3a0:	5422                	lw	s0,40(sp)
 3a2:	5492                	lw	s1,36(sp)
 3a4:	5902                	lw	s2,32(sp)
 3a6:	49f2                	lw	s3,28(sp)
 3a8:	4a62                	lw	s4,24(sp)
 3aa:	4ad2                	lw	s5,20(sp)
 3ac:	4b42                	lw	s6,16(sp)
 3ae:	4bb2                	lw	s7,12(sp)
 3b0:	4c22                	lw	s8,8(sp)
 3b2:	6145                	addi	sp,sp,48
 3b4:	8082                	ret
 3b6:	0001                	nop

000003b8 <trap_handler>:
void __attribute__((interrupt("machine"), aligned(4))) trap_handler(void) {
 3b8:	715d                	addi	sp,sp,-80
 3ba:	c686                	sw	ra,76(sp)
 3bc:	c496                	sw	t0,72(sp)
 3be:	c29a                	sw	t1,68(sp)
 3c0:	c09e                	sw	t2,64(sp)
 3c2:	de22                	sw	s0,60(sp)
 3c4:	dc26                	sw	s1,56(sp)
 3c6:	da2a                	sw	a0,52(sp)
 3c8:	d82e                	sw	a1,48(sp)
 3ca:	d632                	sw	a2,44(sp)
 3cc:	d436                	sw	a3,40(sp)
 3ce:	d23a                	sw	a4,36(sp)
 3d0:	d03e                	sw	a5,32(sp)
 3d2:	ce42                	sw	a6,28(sp)
 3d4:	cc46                	sw	a7,24(sp)
 3d6:	ca4a                	sw	s2,20(sp)
 3d8:	c84e                	sw	s3,16(sp)
 3da:	c672                	sw	t3,12(sp)
 3dc:	c476                	sw	t4,8(sp)
 3de:	c27a                	sw	t5,4(sp)
 3e0:	c07e                	sw	t6,0(sp)
  unsigned long cause = read_csr(mcause);
 3e2:	34202473          	csrr	s0,mcause
  if ((long)cause < 0) {
 3e6:	04045263          	bgez	s0,42a <trap_handler+0x72>
    unsigned long exception_code = cause & ~(1UL << (sizeof(long) * 8 - 1));
 3ea:	00141793          	slli	a5,s0,0x1
 3ee:	8385                	srli	a5,a5,0x1
    if (exception_code == IRQ_M_EXT) {
 3f0:	472d                	li	a4,11
 3f2:	0ae78863          	beq	a5,a4,4a2 <trap_handler+0xea>
    } else if (exception_code == IRQ_M_TIMER) {
 3f6:	471d                	li	a4,7
 3f8:	0ae78763          	beq	a5,a4,4a6 <trap_handler+0xee>
}
 3fc:	5472                	lw	s0,60(sp)
 3fe:	40b6                	lw	ra,76(sp)
 400:	42a6                	lw	t0,72(sp)
 402:	4316                	lw	t1,68(sp)
 404:	4386                	lw	t2,64(sp)
 406:	54e2                	lw	s1,56(sp)
 408:	5552                	lw	a0,52(sp)
 40a:	55c2                	lw	a1,48(sp)
 40c:	5632                	lw	a2,44(sp)
 40e:	56a2                	lw	a3,40(sp)
 410:	5712                	lw	a4,36(sp)
 412:	5782                	lw	a5,32(sp)
 414:	4872                	lw	a6,28(sp)
 416:	48e2                	lw	a7,24(sp)
 418:	4952                	lw	s2,20(sp)
 41a:	49c2                	lw	s3,16(sp)
 41c:	4e32                	lw	t3,12(sp)
 41e:	4ea2                	lw	t4,8(sp)
 420:	4f12                	lw	t5,4(sp)
 422:	4f82                	lw	t6,0(sp)
 424:	6161                	addi	sp,sp,80
 426:	30200073          	mret
    uart_polled_puts("\r\n\r\n=== CPU EXCEPTION / CRASH DETECTED ===\r\n");
 42a:	6505                	lui	a0,0x1
 42c:	e3850513          	addi	a0,a0,-456 # e38 <uart_print_hex+0xda>
 430:	10b000ef          	jal	d3a <uart_polled_puts>
    uart_print_hex("mcause: 0x", (uint32_t)cause);
 434:	6505                	lui	a0,0x1
 436:	85a2                	mv	a1,s0
 438:	e6850513          	addi	a0,a0,-408 # e68 <uart_print_hex+0x10a>
 43c:	123000ef          	jal	d5e <uart_print_hex>
    uart_print_hex("mepc  : 0x", (uint32_t)read_csr(mepc));
 440:	341025f3          	csrr	a1,mepc
 444:	6505                	lui	a0,0x1
 446:	e7450513          	addi	a0,a0,-396 # e74 <uart_print_hex+0x116>
 44a:	115000ef          	jal	d5e <uart_print_hex>
    uart_print_hex("mtval : 0x", (uint32_t)read_csr(mtval));
 44e:	343025f3          	csrr	a1,mtval
 452:	6505                	lui	a0,0x1
 454:	e8050513          	addi	a0,a0,-384 # e80 <uart_print_hex+0x122>
 458:	107000ef          	jal	d5e <uart_print_hex>
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 45c:	6505                	lui	a0,0x1
    while (stack_ptr < stack_top_ptr) {
 45e:	100104b7          	lui	s1,0x10010
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 462:	e8c50513          	addi	a0,a0,-372 # e8c <uart_print_hex+0x12e>
    while (stack_ptr < stack_top_ptr) {
 466:	00048493          	mv	s1,s1
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 46a:	0d1000ef          	jal	d3a <uart_polled_puts>
    while (stack_ptr < stack_top_ptr) {
 46e:	02917463          	bgeu	sp,s1,496 <trap_handler+0xde>
 472:	6785                	lui	a5,0x1
        uart_print_hex("  from instruction addr: 0x", val);
 474:	eb078993          	addi	s3,a5,-336 # eb0 <uart_print_hex+0x152>
 478:	840a                	mv	s0,sp
      if (val >= 0x00000000 && val < 0x00004000) {
 47a:	6911                	lui	s2,0x4
 47c:	a021                	j	484 <trap_handler+0xcc>
    while (stack_ptr < stack_top_ptr) {
 47e:	0411                	addi	s0,s0,4
 480:	00947b63          	bgeu	s0,s1,496 <trap_handler+0xde>
      uint32_t val = *stack_ptr;
 484:	400c                	lw	a1,0(s0)
      if (val >= 0x00000000 && val < 0x00004000) {
 486:	ff25fce3          	bgeu	a1,s2,47e <trap_handler+0xc6>
        uart_print_hex("  from instruction addr: 0x", val);
 48a:	854e                	mv	a0,s3
    while (stack_ptr < stack_top_ptr) {
 48c:	0411                	addi	s0,s0,4
        uart_print_hex("  from instruction addr: 0x", val);
 48e:	0d1000ef          	jal	d5e <uart_print_hex>
    while (stack_ptr < stack_top_ptr) {
 492:	fe9469e3          	bltu	s0,s1,484 <trap_handler+0xcc>
    uart_polled_puts("System halted.\r\n");
 496:	6505                	lui	a0,0x1
 498:	ecc50513          	addi	a0,a0,-308 # ecc <uart_print_hex+0x16e>
 49c:	09f000ef          	jal	d3a <uart_polled_puts>
    while (1) {
 4a0:	a001                	j	4a0 <trap_handler+0xe8>
      plic_irq_handler();
 4a2:	3d59                	jal	338 <plic_irq_handler>
 4a4:	bfa1                	j	3fc <trap_handler+0x44>
      if (timer_irq_handler) {
 4a6:	100007b7          	lui	a5,0x10000
 4aa:	0487a783          	lw	a5,72(a5) # 10000048 <timer_irq_handler>
 4ae:	d7b9                	beqz	a5,3fc <trap_handler+0x44>
        timer_irq_handler();
 4b0:	9782                	jalr	a5
 4b2:	b7a9                	j	3fc <trap_handler+0x44>

000004b4 <resort_by_prior>:
  *PLIC_IRQ_ACTV |= actv_mask;

  resort_by_prior();
}

void resort_by_prior() {
 4b4:	1141                	addi	sp,sp,-16

  for (int i = 0; i < 8; i++) {
    plic_idx_sort[i] = i;
 4b6:	100007b7          	lui	a5,0x10000
 4ba:	00078793          	mv	a5,a5
void resort_by_prior() {
 4be:	c622                	sw	s0,12(sp)
 4c0:	c426                	sw	s1,8(sp)
 4c2:	c24a                	sw	s2,4(sp)
 4c4:	c04e                	sw	s3,0(sp)
    plic_idx_sort[i] = i;
 4c6:	4709                	li	a4,2
 4c8:	c798                	sw	a4,8(a5)
 4ca:	470d                	li	a4,3
 4cc:	c7d8                	sw	a4,12(a5)
 4ce:	4711                	li	a4,4
 4d0:	cb98                	sw	a4,16(a5)
 4d2:	4715                	li	a4,5
 4d4:	cbd8                	sw	a4,20(a5)
 4d6:	4719                	li	a4,6
 4d8:	cf98                	sw	a4,24(a5)
  }

  // 19-Comparator Sorting Network for N=8
  // Layer 1
  CS(0, 1);
 4da:	0207a283          	lw	t0,32(a5) # 10000020 <plic_irq_priorities>
    plic_idx_sort[i] = i;
 4de:	471d                	li	a4,7
  CS(0, 1);
 4e0:	53c4                	lw	s1,36(a5)
    plic_idx_sort[i] = i;
 4e2:	cfd8                	sw	a4,28(a5)
 4e4:	4705                	li	a4,1
 4e6:	0007a023          	sw	zero,0(a5)
 4ea:	c3d8                	sw	a4,4(a5)
  CS(0, 1);
 4ec:	8eba                	mv	t4,a4
 4ee:	4401                	li	s0,0
 4f0:	0092da63          	bge	t0,s1,504 <resort_by_prior+0x50>
 4f4:	8696                	mv	a3,t0
 4f6:	c398                	sw	a4,0(a5)
 4f8:	82a6                	mv	t0,s1
 4fa:	0007a223          	sw	zero,4(a5)
 4fe:	84b6                	mv	s1,a3
 500:	843a                	mv	s0,a4
 502:	4e81                	li	t4,0
  CS(2, 3);
 504:	578c                	lw	a1,40(a5)
 506:	57d8                	lw	a4,44(a5)
 508:	4f0d                	li	t5,3
 50a:	4809                	li	a6,2
 50c:	00e5db63          	bge	a1,a4,522 <resort_by_prior+0x6e>
 510:	86ae                	mv	a3,a1
 512:	01e7a423          	sw	t5,8(a5)
 516:	0107a623          	sw	a6,12(a5)
 51a:	85ba                	mv	a1,a4
 51c:	8f42                	mv	t5,a6
 51e:	8736                	mv	a4,a3
 520:	480d                	li	a6,3
  CS(4, 5);
 522:	5b94                	lw	a3,48(a5)
 524:	5bd0                	lw	a2,52(a5)
 526:	4e15                	li	t3,5
 528:	4311                	li	t1,4
 52a:	00c6db63          	bge	a3,a2,540 <resort_by_prior+0x8c>
 52e:	8536                	mv	a0,a3
 530:	01c7a823          	sw	t3,16(a5)
 534:	0067aa23          	sw	t1,20(a5)
 538:	86b2                	mv	a3,a2
 53a:	8e1a                	mv	t3,t1
 53c:	862a                	mv	a2,a0
 53e:	4315                	li	t1,5
  CS(6, 7);
 540:	5f88                	lw	a0,56(a5)
 542:	03c7af83          	lw	t6,60(a5)
 546:	439d                	li	t2,7
 548:	4899                	li	a7,6
 54a:	01f55b63          	bge	a0,t6,560 <resort_by_prior+0xac>
 54e:	892a                	mv	s2,a0
 550:	0077ac23          	sw	t2,24(a5)
 554:	0117ae23          	sw	a7,28(a5)
 558:	857e                	mv	a0,t6
 55a:	83c6                	mv	t2,a7
 55c:	8fca                	mv	t6,s2
 55e:	489d                	li	a7,7
  // Layer 2
  CS(0, 2);
 560:	00b2db63          	bge	t0,a1,576 <resort_by_prior+0xc2>
 564:	89ae                	mv	s3,a1
 566:	8942                	mv	s2,a6
 568:	0107a023          	sw	a6,0(a5)
 56c:	c780                	sw	s0,8(a5)
 56e:	8596                	mv	a1,t0
 570:	8822                	mv	a6,s0
 572:	82ce                	mv	t0,s3
 574:	844a                	mv	s0,s2
  CS(1, 3);
 576:	00e4dc63          	bge	s1,a4,58e <resort_by_prior+0xda>
 57a:	89a6                	mv	s3,s1
 57c:	8976                	mv	s2,t4
 57e:	01d7a623          	sw	t4,12(a5)
 582:	01e7a223          	sw	t5,4(a5)
 586:	84ba                	mv	s1,a4
 588:	8efa                	mv	t4,t5
 58a:	874e                	mv	a4,s3
 58c:	8f4a                	mv	t5,s2
  CS(4, 6);
 58e:	00a6dc63          	bge	a3,a0,5a6 <resort_by_prior+0xf2>
 592:	89aa                	mv	s3,a0
 594:	8946                	mv	s2,a7
 596:	0117a823          	sw	a7,16(a5)
 59a:	0067ac23          	sw	t1,24(a5)
 59e:	8536                	mv	a0,a3
 5a0:	889a                	mv	a7,t1
 5a2:	86ce                	mv	a3,s3
 5a4:	834a                	mv	t1,s2
  CS(5, 7);
 5a6:	01f65c63          	bge	a2,t6,5be <resort_by_prior+0x10a>
 5aa:	89b2                	mv	s3,a2
 5ac:	8972                	mv	s2,t3
 5ae:	01c7ae23          	sw	t3,28(a5)
 5b2:	0077aa23          	sw	t2,20(a5)
 5b6:	867e                	mv	a2,t6
 5b8:	8e1e                	mv	t3,t2
 5ba:	8fce                	mv	t6,s3
 5bc:	83ca                	mv	t2,s2
  // Layer 3
  CS(1, 2);
 5be:	00b4dc63          	bge	s1,a1,5d6 <resort_by_prior+0x122>
 5c2:	89a6                	mv	s3,s1
 5c4:	8976                	mv	s2,t4
 5c6:	01d7a423          	sw	t4,8(a5)
 5ca:	0107a223          	sw	a6,4(a5)
 5ce:	84ae                	mv	s1,a1
 5d0:	8ec2                	mv	t4,a6
 5d2:	85ce                	mv	a1,s3
 5d4:	884a                	mv	a6,s2
  CS(5, 6);
 5d6:	00a65c63          	bge	a2,a0,5ee <resort_by_prior+0x13a>
 5da:	89b2                	mv	s3,a2
 5dc:	8972                	mv	s2,t3
 5de:	01c7ac23          	sw	t3,24(a5)
 5e2:	0117aa23          	sw	a7,20(a5)
 5e6:	862a                	mv	a2,a0
 5e8:	8e46                	mv	t3,a7
 5ea:	854e                	mv	a0,s3
 5ec:	88ca                	mv	a7,s2
  CS(0, 4);
 5ee:	00d2d763          	bge	t0,a3,5fc <resort_by_prior+0x148>
 5f2:	0067a023          	sw	t1,0(a5)
 5f6:	cb80                	sw	s0,16(a5)
 5f8:	8696                	mv	a3,t0
 5fa:	8322                	mv	t1,s0
  CS(3, 7);
 5fc:	01f75863          	bge	a4,t6,60c <resort_by_prior+0x158>
 600:	01e7ae23          	sw	t5,28(a5)
 604:	0077a623          	sw	t2,12(a5)
 608:	877e                	mv	a4,t6
 60a:	8f1e                	mv	t5,t2
  // Layer 4
  CS(1, 5);
 60c:	00c4dc63          	bge	s1,a2,624 <resort_by_prior+0x170>
 610:	82a6                	mv	t0,s1
 612:	8ff6                	mv	t6,t4
 614:	01d7aa23          	sw	t4,20(a5)
 618:	01c7a223          	sw	t3,4(a5)
 61c:	84b2                	mv	s1,a2
 61e:	8ef2                	mv	t4,t3
 620:	8616                	mv	a2,t0
 622:	8e7e                	mv	t3,t6
  CS(2, 6);
 624:	00a5dc63          	bge	a1,a0,63c <resort_by_prior+0x188>
 628:	82aa                	mv	t0,a0
 62a:	8fc6                	mv	t6,a7
 62c:	0117a423          	sw	a7,8(a5)
 630:	0107ac23          	sw	a6,24(a5)
 634:	852e                	mv	a0,a1
 636:	88c2                	mv	a7,a6
 638:	8596                	mv	a1,t0
 63a:	887e                	mv	a6,t6
  // Layer 5
  CS(1, 4);
 63c:	00d4d863          	bge	s1,a3,64c <resort_by_prior+0x198>
 640:	0067a223          	sw	t1,4(a5)
 644:	01d7a823          	sw	t4,16(a5)
 648:	86a6                	mv	a3,s1
 64a:	8376                	mv	t1,t4
  CS(3, 6);
 64c:	00a75863          	bge	a4,a0,65c <resort_by_prior+0x1a8>
 650:	01e7ac23          	sw	t5,24(a5)
 654:	0117a623          	sw	a7,12(a5)
 658:	872a                	mv	a4,a0
 65a:	8f46                	mv	t5,a7
  // Layer 6
  CS(2, 4);
 65c:	00d5d863          	bge	a1,a3,66c <resort_by_prior+0x1b8>
 660:	0067a423          	sw	t1,8(a5)
 664:	0107a823          	sw	a6,16(a5)
 668:	86ae                	mv	a3,a1
 66a:	8342                	mv	t1,a6
  CS(3, 5);
 66c:	00c75863          	bge	a4,a2,67c <resort_by_prior+0x1c8>
 670:	01e7aa23          	sw	t5,20(a5)
 674:	01c7a623          	sw	t3,12(a5)
 678:	8732                	mv	a4,a2
 67a:	8f72                	mv	t5,t3
  // Layer 7
  CS(3, 4);
 67c:	00d75663          	bge	a4,a3,688 <resort_by_prior+0x1d4>
 680:	0067a623          	sw	t1,12(a5)
 684:	01e7a823          	sw	t5,16(a5)
}
 688:	4432                	lw	s0,12(sp)
 68a:	44a2                	lw	s1,8(sp)
 68c:	4912                	lw	s2,4(sp)
 68e:	4982                	lw	s3,0(sp)
 690:	0141                	addi	sp,sp,16
 692:	8082                	ret

00000694 <reg_irq_handler>:
  *PLIC_IRQ_ACTV |= actv_mask;
 694:	200008b7          	lui	a7,0x20000
 698:	0008a803          	lw	a6,0(a7) # 20000000 <_stack_top+0xfff0000>
  plic_irq_priorities[arr_idx] = priority;
 69c:	100007b7          	lui	a5,0x10000
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 6a0:	068a                	slli	a3,a3,0x2
 6a2:	81018713          	addi	a4,gp,-2032 # 10000050 <plic_irq_handlers>
  plic_irq_priorities[arr_idx] = priority;
 6a6:	00078793          	mv	a5,a5
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 6aa:	9736                	add	a4,a4,a3
  plic_irq_priorities[arr_idx] = priority;
 6ac:	97b6                	add	a5,a5,a3
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 6ae:	c308                	sw	a0,0(a4)
  plic_irq_priorities[arr_idx] = priority;
 6b0:	d38c                	sw	a1,32(a5)
  *PLIC_IRQ_ACTV |= actv_mask;
 6b2:	00c86833          	or	a6,a6,a2
 6b6:	0108a023          	sw	a6,0(a7)
  resort_by_prior();
 6ba:	bbed                	j	4b4 <resort_by_prior>

000006bc <reg_timer_irq>:

void reg_timer_irq(void (*_timer_irq_handler)(void)) {
  timer_irq_handler = _timer_irq_handler;
 6bc:	100007b7          	lui	a5,0x10000
 6c0:	04a7a423          	sw	a0,72(a5) # 10000048 <timer_irq_handler>
}
 6c4:	8082                	ret

000006c6 <init_ring_buffer>:
#include "../include/ring_buff.h"

void init_ring_buffer(ring_buffer_t *rb) {
  // No malloc needed! The memory is already allocated as part of the struct.
  rb->head = 0;
 6c6:	10050023          	sb	zero,256(a0)
  rb->tail = 0;
 6ca:	100500a3          	sb	zero,257(a0)
}
 6ce:	8082                	ret

000006d0 <reset_ring_buffer>:

void reset_ring_buffer(ring_buffer_t *rb) {
 6d0:	10050023          	sb	zero,256(a0)
 6d4:	100500a3          	sb	zero,257(a0)
 6d8:	8082                	ret

000006da <insert_rb>:
}

bool insert_rb(ring_buffer_t *rb, char c) {
  // Calculate what the next head position will be.
  // uint8_t naturally wraps from 255 back to 0.
  uint8_t next_head = (uint8_t)(rb->head + 1);
 6da:	10054703          	lbu	a4,256(a0)

  // If the next head hits the tail, the buffer is full.
  // Note: This design sacrifices 1 byte of capacity, holding a max of 255
  // items.
  if (next_head == rb->tail) {
 6de:	10154683          	lbu	a3,257(a0)
  uint8_t next_head = (uint8_t)(rb->head + 1);
 6e2:	00170793          	addi	a5,a4,1 # 20003001 <_stack_top+0xfff3001>
 6e6:	0ff7f793          	zext.b	a5,a5
  if (next_head == rb->tail) {
 6ea:	00f68963          	beq	a3,a5,6fc <insert_rb+0x22>
    return false;
  }

  rb->buffer[rb->head] = c;
 6ee:	972a                	add	a4,a4,a0
 6f0:	00b70023          	sb	a1,0(a4)
  rb->head = next_head;
 6f4:	10f50023          	sb	a5,256(a0)

  return true;
 6f8:	4505                	li	a0,1
 6fa:	8082                	ret
    return false;
 6fc:	4501                	li	a0,0
}
 6fe:	8082                	ret

00000700 <pop_rb>:

bool pop_rb(ring_buffer_t *rb, char *c) {
  // If head and tail are at the same position, the buffer is empty.
  if (rb->head == rb->tail) {
 700:	10154703          	lbu	a4,257(a0)
 704:	10054683          	lbu	a3,256(a0)
bool pop_rb(ring_buffer_t *rb, char *c) {
 708:	87aa                	mv	a5,a0
  if (rb->head == rb->tail) {
 70a:	00e68e63          	beq	a3,a4,726 <pop_rb+0x26>
    return false;
  }

  *c = rb->buffer[rb->tail];
 70e:	972a                	add	a4,a4,a0
 710:	00074703          	lbu	a4,0(a4)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0

  return true;
 714:	4505                	li	a0,1
  *c = rb->buffer[rb->tail];
 716:	00e58023          	sb	a4,0(a1)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0
 71a:	1017c703          	lbu	a4,257(a5)
 71e:	972a                	add	a4,a4,a0
 720:	10e780a3          	sb	a4,257(a5)
  return true;
 724:	8082                	ret
    return false;
 726:	4501                	li	a0,0
}
 728:	8082                	ret

0000072a <init_timers>:
#include "../include/timer.h"
#include <stdint.h>

void init_timers() {
 72a:	1141                	addi	sp,sp,-16
 72c:	c606                	sw	ra,12(sp)

  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 72e:	20000737          	lui	a4,0x20000
 732:	56fd                	li	a3,-1
 734:	c714                	sw	a3,8(a4)
  *TIMER_COMP_PART2 = 0xFFFFFFFF;

  reg_timer_irq(master_timer_isr);
 736:	6505                	lui	a0,0x1
  *TIMER_COMP_PART2 = 0xFFFFFFFF;
 738:	c754                	sw	a3,12(a4)
  reg_timer_irq(master_timer_isr);
 73a:	96650513          	addi	a0,a0,-1690 # 966 <master_timer_isr>
 73e:	3fbd                	jal	6bc <reg_timer_irq>

  set_csr(mie, MIE_MTIE);
 740:	08000793          	li	a5,128
 744:	3047a7f3          	csrrs	a5,mie,a5
}
 748:	40b2                	lw	ra,12(sp)
 74a:	0141                	addi	sp,sp,16
 74c:	8082                	ret

0000074e <read_time>:

uint64_t read_time() {
  uint32_t lo = *TIMER_COMP_PART1;
 74e:	200007b7          	lui	a5,0x20000
 752:	4788                	lw	a0,8(a5)

  uint32_t hi = *TIMER_COMP_PART2;
 754:	200007b7          	lui	a5,0x20000

  return (((uint64_t)hi) << 32) | lo;
}
 758:	47cc                	lw	a1,12(a5)
 75a:	8082                	ret

0000075c <set_compare>:

void set_compare(uint64_t comp) {
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 75c:	200007b7          	lui	a5,0x20000
 760:	56fd                	li	a3,-1
 762:	c794                	sw	a3,8(a5)

  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 764:	c7cc                	sw	a1,12(a5)

  *TIMER_COMP_PART1 = (uint32_t)comp;
 766:	c788                	sw	a0,8(a5)
}
 768:	8082                	ret

0000076a <swap_in_heap>:

void swap_in_heap(int a_i, int b_i) {
  irq_timer_t *temp = timer_heap[a_i];
 76a:	83018793          	addi	a5,gp,-2000 # 10000070 <timer_heap>
  timer_heap[a_i] = timer_heap[b_i];
 76e:	058a                	slli	a1,a1,0x2
 770:	95be                	add	a1,a1,a5
  irq_timer_t *temp = timer_heap[a_i];
 772:	050a                	slli	a0,a0,0x2
  timer_heap[a_i] = timer_heap[b_i];
 774:	4194                	lw	a3,0(a1)
  irq_timer_t *temp = timer_heap[a_i];
 776:	97aa                	add	a5,a5,a0
 778:	4398                	lw	a4,0(a5)
  timer_heap[a_i] = timer_heap[b_i];
 77a:	c394                	sw	a3,0(a5)
  timer_heap[b_i] = temp;
 77c:	c198                	sw	a4,0(a1)
}
 77e:	8082                	ret

00000780 <min_heapify>:

// first call should be, num_timers, 0
void min_heapify(int sz, int i) {
  int smallest = i;
  int left = 2 * i + 1;
 780:	00159793          	slli	a5,a1,0x1
 784:	00178693          	addi	a3,a5,1 # 20000001 <_stack_top+0xfff0001>
  int right = 2 * i + 2;

  if (left < sz &&
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 788:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
  int right = 2 * i + 2;
 78c:	0789                	addi	a5,a5,2
  if (left < sz &&
 78e:	06a6de63          	bge	a3,a0,80a <min_heapify+0x8a>
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 792:	00269713          	slli	a4,a3,0x2
 796:	00259613          	slli	a2,a1,0x2
 79a:	9742                	add	a4,a4,a6
 79c:	00c80333          	add	t1,a6,a2
 7a0:	00072883          	lw	a7,0(a4) # 20000000 <_stack_top+0xfff0000>
 7a4:	00032e03          	lw	t3,0(t1)
 7a8:	0048a703          	lw	a4,4(a7)
  if (left < sz &&
 7ac:	004e2303          	lw	t1,4(t3)
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 7b0:	0008a883          	lw	a7,0(a7)
  if (left < sz &&
 7b4:	00676863          	bltu	a4,t1,7c4 <min_heapify+0x44>
 7b8:	04e31963          	bne	t1,a4,80a <min_heapify+0x8a>
 7bc:	000e2303          	lw	t1,0(t3)
 7c0:	0468f563          	bgeu	a7,t1,80a <min_heapify+0x8a>
    smallest = left;
  }

  if (right < sz &&
 7c4:	00a7dd63          	bge	a5,a0,7de <min_heapify+0x5e>
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 7c8:	00279313          	slli	t1,a5,0x2
 7cc:	9342                	add	t1,t1,a6
 7ce:	00032e03          	lw	t3,0(t1)
  if (right < sz &&
 7d2:	004e2303          	lw	t1,4(t3)
 7d6:	00e36563          	bltu	t1,a4,7e0 <min_heapify+0x60>
 7da:	06e30563          	beq	t1,a4,844 <min_heapify+0xc4>
 7de:	87b6                	mv	a5,a3
    smallest = right;
  }

  if (smallest != i) {
 7e0:	06b78163          	beq	a5,a1,842 <min_heapify+0xc2>
  timer_heap[a_i] = timer_heap[b_i];
 7e4:	00279713          	slli	a4,a5,0x2
 7e8:	9742                	add	a4,a4,a6
  irq_timer_t *temp = timer_heap[a_i];
 7ea:	00c806b3          	add	a3,a6,a2
  timer_heap[a_i] = timer_heap[b_i];
 7ee:	00072883          	lw	a7,0(a4)
  irq_timer_t *temp = timer_heap[a_i];
 7f2:	4290                	lw	a2,0(a3)
    swap_in_heap(i, smallest);
    min_heapify(sz, smallest);
 7f4:	85be                	mv	a1,a5
  timer_heap[a_i] = timer_heap[b_i];
 7f6:	0116a023          	sw	a7,0(a3)
  int left = 2 * i + 1;
 7fa:	00159793          	slli	a5,a1,0x1
 7fe:	00178693          	addi	a3,a5,1
  timer_heap[b_i] = temp;
 802:	c310                	sw	a2,0(a4)
  int right = 2 * i + 2;
 804:	0789                	addi	a5,a5,2
  if (left < sz &&
 806:	f8a6c6e3          	blt	a3,a0,792 <min_heapify+0x12>
  if (right < sz &&
 80a:	00a7c363          	blt	a5,a0,810 <min_heapify+0x90>
 80e:	8082                	ret
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 810:	00259613          	slli	a2,a1,0x2
 814:	00279713          	slli	a4,a5,0x2
 818:	00c806b3          	add	a3,a6,a2
 81c:	9742                	add	a4,a4,a6
 81e:	0006a303          	lw	t1,0(a3)
 822:	00072883          	lw	a7,0(a4)
  if (right < sz &&
 826:	00432683          	lw	a3,4(t1)
 82a:	0048a703          	lw	a4,4(a7)
 82e:	fad769e3          	bltu	a4,a3,7e0 <min_heapify+0x60>
 832:	00e69863          	bne	a3,a4,842 <min_heapify+0xc2>
 836:	00032683          	lw	a3,0(t1)
 83a:	0008a703          	lw	a4,0(a7)
 83e:	fad761e3          	bltu	a4,a3,7e0 <min_heapify+0x60>
  }
}
 842:	8082                	ret
  if (right < sz &&
 844:	000e2703          	lw	a4,0(t3)
 848:	f9176ce3          	bltu	a4,a7,7e0 <min_heapify+0x60>
 84c:	87b6                	mv	a5,a3
 84e:	bf49                	j	7e0 <min_heapify+0x60>

00000850 <sift_up>:

void sift_up(int i) {
  int parent = (i - 1) / 2;
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 850:	04a05f63          	blez	a0,8ae <sift_up+0x5e>
 854:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 858:	00251793          	slli	a5,a0,0x2
 85c:	97b2                	add	a5,a5,a2
 85e:	0007a303          	lw	t1,0(a5)
  int parent = (i - 1) / 2;
 862:	fff50713          	addi	a4,a0,-1
 866:	8705                	srai	a4,a4,0x1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 868:	00032e83          	lw	t4,0(t1)
 86c:	00432e03          	lw	t3,4(t1)
 870:	a809                	j	882 <sift_up+0x32>
  timer_heap[a_i] = timer_heap[b_i];
 872:	c10c                	sw	a1,0(a0)
  timer_heap[b_i] = temp;
 874:	0067a023          	sw	t1,0(a5)
    swap_in_heap(i, parent);

    // Move up the tree
    i = parent;
    parent = (i - 1) / 2;
 878:	96c2                	add	a3,a3,a6
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 87a:	853a                	mv	a0,a4
 87c:	cb0d                	beqz	a4,8ae <sift_up+0x5e>
 87e:	4016d713          	srai	a4,a3,0x1
 882:	00271793          	slli	a5,a4,0x2
 886:	00f606b3          	add	a3,a2,a5
 88a:	428c                	lw	a1,0(a3)
  timer_heap[a_i] = timer_heap[b_i];
 88c:	050a                	slli	a0,a0,0x2
    parent = (i - 1) / 2;
 88e:	fff70813          	addi	a6,a4,-1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 892:	0045a883          	lw	a7,4(a1)
  timer_heap[b_i] = temp;
 896:	87b6                	mv	a5,a3
  timer_heap[a_i] = timer_heap[b_i];
 898:	9532                	add	a0,a0,a2
    parent = (i - 1) / 2;
 89a:	01f85693          	srli	a3,a6,0x1f
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 89e:	fd1e6ae3          	bltu	t3,a7,872 <sift_up+0x22>
 8a2:	01c89663          	bne	a7,t3,8ae <sift_up+0x5e>
 8a6:	0005a883          	lw	a7,0(a1)
 8aa:	fd1ee4e3          	bltu	t4,a7,872 <sift_up+0x22>
  }
}
 8ae:	8082                	ret

000008b0 <_deactivate_timer.part.0>:
  // 1. Mark as inactive so the pool slot can be reused
  timer->active = false;

  // 2. Find the timer in the heap (O(N) search, but MAX_TIMERS is small)
  int heap_idx = -1;
  for (int i = 0; i < num_timers; i++) {
 8b0:	80c1a683          	lw	a3,-2036(gp) # 1000004c <num_timers>
  timer->active = false;
 8b4:	00050a23          	sb	zero,20(a0)
  for (int i = 0; i < num_timers; i++) {
 8b8:	06d05063          	blez	a3,918 <_deactivate_timer.part.0+0x68>
 8bc:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 8c0:	87b2                	mv	a5,a2
 8c2:	4581                	li	a1,0
 8c4:	a021                	j	8cc <_deactivate_timer.part.0+0x1c>
 8c6:	0585                	addi	a1,a1,1
 8c8:	04d58863          	beq	a1,a3,918 <_deactivate_timer.part.0+0x68>
    if (timer_heap[i] == timer) {
 8cc:	4398                	lw	a4,0(a5)
  for (int i = 0; i < num_timers; i++) {
 8ce:	0791                	addi	a5,a5,4
    if (timer_heap[i] == timer) {
 8d0:	fee51be3          	bne	a0,a4,8c6 <_deactivate_timer.part.0+0x16>
  if (heap_idx == -1) {
    return false; // Timer was active but not in heap (state error)
  }

  // 3. Replace the removed timer with the last timer in the heap
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8d4:	fff68513          	addi	a0,a3,-1
 8d8:	00251793          	slli	a5,a0,0x2
 8dc:	97b2                	add	a5,a5,a2
 8de:	4398                	lw	a4,0(a5)
bool _deactivate_timer(irq_timer_t *timer) {
 8e0:	1141                	addi	sp,sp,-16
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8e2:	00259793          	slli	a5,a1,0x2
bool _deactivate_timer(irq_timer_t *timer) {
 8e6:	c606                	sw	ra,12(sp)
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8e8:	97b2                	add	a5,a5,a2
  num_timers--;
 8ea:	80a1a623          	sw	a0,-2036(gp) # 1000004c <num_timers>
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 8ee:	c398                	sw	a4,0(a5)

  // 4. Restore the heap property
  if (heap_idx < num_timers) {
 8f0:	02a5d663          	bge	a1,a0,91c <_deactivate_timer.part.0+0x6c>
    int parent = (heap_idx - 1) / 2;

    // If the new node is smaller than its parent, it needs to bubble up
    if (heap_idx > 0 &&
 8f4:	c5ad                	beqz	a1,95e <_deactivate_timer.part.0+0xae>
    int parent = (heap_idx - 1) / 2;
 8f6:	fff58793          	addi	a5,a1,-1
 8fa:	8785                	srai	a5,a5,0x1
        timer_heap[heap_idx]->expires_at < timer_heap[parent]->expires_at) {
 8fc:	078a                	slli	a5,a5,0x2
 8fe:	963e                	add	a2,a2,a5
 900:	4210                	lw	a2,0(a2)
    if (heap_idx > 0 &&
 902:	435c                	lw	a5,4(a4)
 904:	4254                	lw	a3,4(a2)
 906:	04d7e963          	bltu	a5,a3,958 <_deactivate_timer.part.0+0xa8>
 90a:	04f68363          	beq	a3,a5,950 <_deactivate_timer.part.0+0xa0>
      sift_up(heap_idx);
    }
    // Otherwise, it might need to bubble down
    else {
      min_heapify(num_timers, heap_idx);
 90e:	3d8d                	jal	780 <min_heapify>
      set_compare(0xFFFFFFFFFFFFFFFFULL);
    }
  }

  return true;
}
 910:	40b2                	lw	ra,12(sp)
  return true;
 912:	4505                	li	a0,1
}
 914:	0141                	addi	sp,sp,16
 916:	8082                	ret
    return false;
 918:	4501                	li	a0,0
}
 91a:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 91c:	ed99                	bnez	a1,93a <_deactivate_timer.part.0+0x8a>
    if (num_timers > 0) {
 91e:	cd19                	beqz	a0,93c <_deactivate_timer.part.0+0x8c>
      set_compare(timer_heap[0]->expires_at);
 920:	4218                	lw	a4,0(a2)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 922:	200007b7          	lui	a5,0x20000
 926:	55fd                	li	a1,-1
      set_compare(timer_heap[0]->expires_at);
 928:	4350                	lw	a2,4(a4)
 92a:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 92c:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 92e:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 930:	c794                	sw	a3,8(a5)
}
 932:	40b2                	lw	ra,12(sp)
  return true;
 934:	4505                	li	a0,1
}
 936:	0141                	addi	sp,sp,16
 938:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 93a:	fd65                	bnez	a0,932 <_deactivate_timer.part.0+0x82>
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 93c:	200007b7          	lui	a5,0x20000
 940:	577d                	li	a4,-1
 942:	c798                	sw	a4,8(a5)
}
 944:	40b2                	lw	ra,12(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 946:	c7d8                	sw	a4,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 948:	c798                	sw	a4,8(a5)
  return true;
 94a:	4505                	li	a0,1
}
 94c:	0141                	addi	sp,sp,16
 94e:	8082                	ret
    if (heap_idx > 0 &&
 950:	4214                	lw	a3,0(a2)
 952:	431c                	lw	a5,0(a4)
 954:	fad7fde3          	bgeu	a5,a3,90e <_deactivate_timer.part.0+0x5e>
      sift_up(heap_idx);
 958:	852e                	mv	a0,a1
 95a:	3ddd                	jal	850 <sift_up>
  if (heap_idx == 0 || num_timers == 0) {
 95c:	bfd9                	j	932 <_deactivate_timer.part.0+0x82>
      min_heapify(num_timers, heap_idx);
 95e:	350d                	jal	780 <min_heapify>
  if (heap_idx == 0 || num_timers == 0) {
 960:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 964:	bf75                	j	920 <_deactivate_timer.part.0+0x70>

00000966 <master_timer_isr>:

void master_timer_isr() {
 966:	1101                	addi	sp,sp,-32
 968:	c452                	sw	s4,8(sp)
  // Loop to handle cases where multiple timers expire at the same time,
  // or if a callback execution delays us past the next timer's expiration.
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 96a:	80c1a783          	lw	a5,-2036(gp) # 1000004c <num_timers>
void master_timer_isr() {
 96e:	ce06                	sw	ra,28(sp)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 970:	04f05f63          	blez	a5,9ce <master_timer_isr+0x68>
 974:	ca26                	sw	s1,20(sp)
 976:	c84a                	sw	s2,16(sp)
 978:	c64e                	sw	s3,12(sp)
 97a:	200009b7          	lui	s3,0x20000
 97e:	20000937          	lui	s2,0x20000
 982:	cc22                	sw	s0,24(sp)
 984:	c256                	sw	s5,4(sp)
 986:	83018493          	addi	s1,gp,-2000 # 10000070 <timer_heap>
 98a:	09a1                	addi	s3,s3,8 # 20000008 <_stack_top+0xfff0008>
 98c:	0931                	addi	s2,s2,12 # 2000000c <_stack_top+0xfff000c>
 98e:	4080                	lw	s0,0(s1)
  uint32_t lo = *TIMER_COMP_PART1;
 990:	0009a683          	lw	a3,0(s3)
  uint32_t hi = *TIMER_COMP_PART2;
 994:	00092783          	lw	a5,0(s2)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 998:	4058                	lw	a4,4(s0)
 99a:	06e7e263          	bltu	a5,a4,9fe <master_timer_isr+0x98>
 99e:	04f70d63          	beq	a4,a5,9f8 <master_timer_isr+0x92>

    // 1. Get the timer at the top of the heap
    irq_timer_t *top_timer = timer_heap[0];

    // 2. Run the callback function
    if (top_timer->callback_function != NULL) {
 9a2:	481c                	lw	a5,16(s0)
 9a4:	c391                	beqz	a5,9a8 <master_timer_isr+0x42>
      // Cast the void* to a function pointer and execute it
      void (*callback)(void) = (void (*)(void))top_timer->callback_function;
      callback();
 9a6:	9782                	jalr	a5
    }

    // 3. Handle periodic vs absolute
    if (top_timer->period > 0) {
 9a8:	441c                	lw	a5,8(s0)
 9aa:	4454                	lw	a3,12(s0)
 9ac:	00d7e733          	or	a4,a5,a3
 9b0:	e31d                	bnez	a4,9d6 <master_timer_isr+0x70>
  if (timer == NULL || !timer->active) {
 9b2:	01444783          	lbu	a5,20(s0)
 9b6:	c399                	beqz	a5,9bc <master_timer_isr+0x56>
  timer->active = false;
 9b8:	8522                	mv	a0,s0
 9ba:	3ddd                	jal	8b0 <_deactivate_timer.part.0>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 9bc:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
 9c0:	fd5047e3          	bgtz	s5,98e <master_timer_isr+0x28>
 9c4:	4462                	lw	s0,24(sp)
 9c6:	44d2                	lw	s1,20(sp)
 9c8:	4942                	lw	s2,16(sp)
 9ca:	49b2                	lw	s3,12(sp)
 9cc:	4a92                	lw	s5,4(sp)
  }

  if (num_timers > 0) {
    set_compare(timer_heap[0]->expires_at);
  }
}
 9ce:	40f2                	lw	ra,28(sp)
 9d0:	4a22                	lw	s4,8(sp)
 9d2:	6105                	addi	sp,sp,32
 9d4:	8082                	ret
      top_timer->expires_at += top_timer->period;
 9d6:	4018                	lw	a4,0(s0)
 9d8:	4050                	lw	a2,4(s0)
      min_heapify(num_timers, 0);
 9da:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
      top_timer->expires_at += top_timer->period;
 9de:	97ba                	add	a5,a5,a4
 9e0:	00e7b733          	sltu	a4,a5,a4
 9e4:	96b2                	add	a3,a3,a2
 9e6:	9736                	add	a4,a4,a3
 9e8:	c01c                	sw	a5,0(s0)
 9ea:	c058                	sw	a4,4(s0)
      min_heapify(num_timers, 0);
 9ec:	8556                	mv	a0,s5
 9ee:	4581                	li	a1,0
 9f0:	3b41                	jal	780 <min_heapify>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 9f2:	f9504ee3          	bgtz	s5,98e <master_timer_isr+0x28>
 9f6:	b7f9                	j	9c4 <master_timer_isr+0x5e>
 9f8:	401c                	lw	a5,0(s0)
 9fa:	faf6f4e3          	bgeu	a3,a5,9a2 <master_timer_isr+0x3c>
    set_compare(timer_heap[0]->expires_at);
 9fe:	4098                	lw	a4,0(s1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a00:	200007b7          	lui	a5,0x20000
 a04:	55fd                	li	a1,-1
    set_compare(timer_heap[0]->expires_at);
 a06:	4350                	lw	a2,4(a4)
 a08:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a0a:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 a0c:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 a0e:	c794                	sw	a3,8(a5)
 a10:	bf55                	j	9c4 <master_timer_isr+0x5e>

00000a12 <register_isr_periodic>:
  if (num_timers == MAX_TIMERS) {
 a12:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 a16:	04000793          	li	a5,64
 a1a:	0af88e63          	beq	a7,a5,ad6 <register_isr_periodic+0xc4>
    if (timer_pool[i].active == false) {
 a1e:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 a22:	11484783          	lbu	a5,276(a6)
irq_timer_handler register_isr_periodic(uint64_t period, void *cb) {
 a26:	1101                	addi	sp,sp,-32
 a28:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 a2a:	cbc5                	beqz	a5,ada <register_isr_periodic+0xc8>
 a2c:	12c80793          	addi	a5,a6,300
  int i = 0;
 a30:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 a32:	0007c683          	lbu	a3,0(a5) # 20000000 <_stack_top+0xfff0000>
 a36:	07e1                	addi	a5,a5,24
      i++;
 a38:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 a3a:	fee5                	bnez	a3,a32 <register_isr_periodic+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 a3c:	00171793          	slli	a5,a4,0x1
 a40:	00e78333          	add	t1,a5,a4
 a44:	030e                	slli	t1,t1,0x3
 a46:	10080693          	addi	a3,a6,256
 a4a:	969a                	add	a3,a3,t1
  uint32_t lo = *TIMER_COMP_PART1;
 a4c:	20000e37          	lui	t3,0x20000
  timer_pool[i].expires_at = read_time() + period;
 a50:	97ba                	add	a5,a5,a4
  uint32_t lo = *TIMER_COMP_PART1;
 a52:	008e2703          	lw	a4,8(t3) # 20000008 <_stack_top+0xfff0008>
 a56:	832a                	mv	t1,a0
  uint32_t hi = *TIMER_COMP_PART2;
 a58:	00ce2503          	lw	a0,12(t3)
  timer_pool[i].expires_at = read_time() + period;
 a5c:	006702b3          	add	t0,a4,t1
 a60:	00e2b733          	sltu	a4,t0,a4
 a64:	952e                	add	a0,a0,a1
 a66:	078e                	slli	a5,a5,0x3
 a68:	97c2                	add	a5,a5,a6
 a6a:	972a                	add	a4,a4,a0
  timer_pool[i].active = true;
 a6c:	4385                	li	t2,1
  timer_heap[num_timers - 1] = &timer_pool[i];
 a6e:	00289f13          	slli	t5,a7,0x2
  timer_pool[i].expires_at = read_time() + period;
 a72:	10e7a223          	sw	a4,260(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 a76:	9f42                	add	t5,t5,a6
  num_timers++;
 a78:	00788733          	add	a4,a7,t2
  sift_up(num_timers - 1);
 a7c:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + period;
 a7e:	1057a023          	sw	t0,256(a5)
  timer_pool[i].period = period;
 a82:	1067a423          	sw	t1,264(a5)
 a86:	10b7a623          	sw	a1,268(a5)
  timer_pool[i].callback_function = cb;
 a8a:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 a8e:	10778a23          	sb	t2,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 a92:	00df2023          	sw	a3,0(t5)
 a96:	c636                	sw	a3,12(sp)
  num_timers++;
 a98:	80e1a623          	sw	a4,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 a9c:	3b55                	jal	850 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 a9e:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 aa2:	46b2                	lw	a3,12(sp)
 aa4:	20000eb7          	lui	t4,0x20000
 aa8:	20000e37          	lui	t3,0x20000
 aac:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 aae:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 ab0:	00d78663          	beq	a5,a3,abc <register_isr_periodic+0xaa>
}
 ab4:	40f2                	lw	ra,28(sp)
  return new_handler;
 ab6:	8536                	mv	a0,a3
}
 ab8:	6105                	addi	sp,sp,32
 aba:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 abc:	42d8                	lw	a4,4(a3)
 abe:	429c                	lw	a5,0(a3)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 ac0:	567d                	li	a2,-1
 ac2:	00ce2023          	sw	a2,0(t3)
}
 ac6:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 ac8:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 acc:	00fe2023          	sw	a5,0(t3)
  return new_handler;
 ad0:	8536                	mv	a0,a3
}
 ad2:	6105                	addi	sp,sp,32
 ad4:	8082                	ret
    return (irq_timer_handler){};
 ad6:	4501                	li	a0,0
}
 ad8:	8082                	ret
    if (timer_pool[i].active == false) {
 ada:	10080693          	addi	a3,a6,256
  int i = 0;
 ade:	4701                	li	a4,0
 ae0:	b7b5                	j	a4c <register_isr_periodic+0x3a>

00000ae2 <register_isr_abs>:
  if (num_timers == MAX_TIMERS) {
 ae2:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 ae6:	04000793          	li	a5,64
 aea:	0cf88063          	beq	a7,a5,baa <register_isr_abs+0xc8>
    if (timer_pool[i].active == false) {
 aee:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 af2:	11484783          	lbu	a5,276(a6)
bool register_isr_abs(uint64_t offset, void *cb) {
 af6:	1101                	addi	sp,sp,-32
 af8:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 afa:	cbd5                	beqz	a5,bae <register_isr_abs+0xcc>
 afc:	12c80793          	addi	a5,a6,300
  int i = 0;
 b00:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 b02:	0007c683          	lbu	a3,0(a5)
 b06:	07e1                	addi	a5,a5,24
      i++;
 b08:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 b0a:	fee5                	bnez	a3,b02 <register_isr_abs+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 b0c:	00171793          	slli	a5,a4,0x1
 b10:	00e786b3          	add	a3,a5,a4
 b14:	068e                	slli	a3,a3,0x3
 b16:	10080313          	addi	t1,a6,256
 b1a:	9336                	add	t1,t1,a3
  uint32_t lo = *TIMER_COMP_PART1;
 b1c:	20000e37          	lui	t3,0x20000
 b20:	008e2683          	lw	a3,8(t3) # 20000008 <_stack_top+0xfff0008>
  uint32_t hi = *TIMER_COMP_PART2;
 b24:	00ce2f83          	lw	t6,12(t3)
  timer_pool[i].expires_at = read_time() + offset;
 b28:	97ba                	add	a5,a5,a4
 b2a:	00a68733          	add	a4,a3,a0
  timer_pool[i].active = true;
 b2e:	4285                	li	t0,1
  timer_pool[i].expires_at = read_time() + offset;
 b30:	00bf8533          	add	a0,t6,a1
 b34:	00d736b3          	sltu	a3,a4,a3
  timer_heap[num_timers - 1] = &timer_pool[i];
 b38:	00289593          	slli	a1,a7,0x2
  timer_pool[i].expires_at = read_time() + offset;
 b3c:	078e                	slli	a5,a5,0x3
 b3e:	97c2                	add	a5,a5,a6
 b40:	96aa                	add	a3,a3,a0
  timer_heap[num_timers - 1] = &timer_pool[i];
 b42:	95c2                	add	a1,a1,a6
  num_timers++;
 b44:	00588fb3          	add	t6,a7,t0
  sift_up(num_timers - 1);
 b48:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + offset;
 b4a:	10d7a223          	sw	a3,260(a5)
 b4e:	10e7a023          	sw	a4,256(a5)
  timer_pool[i].period = 0;
 b52:	1007a423          	sw	zero,264(a5)
 b56:	1007a623          	sw	zero,268(a5)
  timer_pool[i].callback_function = cb;
 b5a:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 b5e:	10578a23          	sb	t0,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 b62:	0065a023          	sw	t1,0(a1)
 b66:	c61a                	sw	t1,12(sp)
  num_timers++;
 b68:	81f1a623          	sw	t6,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 b6c:	31d5                	jal	850 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 b6e:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 b72:	4332                	lw	t1,12(sp)
 b74:	20000eb7          	lui	t4,0x20000
 b78:	20000e37          	lui	t3,0x20000
 b7c:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 b7e:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 b80:	00678663          	beq	a5,t1,b8c <register_isr_abs+0xaa>
}
 b84:	40f2                	lw	ra,28(sp)
  return true;
 b86:	4505                	li	a0,1
}
 b88:	6105                	addi	sp,sp,32
 b8a:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 b8c:	00432703          	lw	a4,4(t1)
 b90:	00032783          	lw	a5,0(t1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 b94:	56fd                	li	a3,-1
 b96:	00de2023          	sw	a3,0(t3)
}
 b9a:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 b9c:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 ba0:	00fe2023          	sw	a5,0(t3)
  return true;
 ba4:	4505                	li	a0,1
}
 ba6:	6105                	addi	sp,sp,32
 ba8:	8082                	ret
    return false;
 baa:	4501                	li	a0,0
}
 bac:	8082                	ret
    if (timer_pool[i].active == false) {
 bae:	10080313          	addi	t1,a6,256
  int i = 0;
 bb2:	4701                	li	a4,0
 bb4:	b7a5                	j	b1c <register_isr_abs+0x3a>

00000bb6 <deactivate_timer>:
  if (timer == NULL || !timer->active) {
 bb6:	c509                	beqz	a0,bc0 <deactivate_timer+0xa>
 bb8:	01454783          	lbu	a5,20(a0)
 bbc:	c391                	beqz	a5,bc0 <deactivate_timer+0xa>
  timer->active = false;
 bbe:	b9cd                	j	8b0 <_deactivate_timer.part.0>
}
 bc0:	4501                	li	a0,0
 bc2:	8082                	ret

00000bc4 <_deactivate_timer>:
  if (timer == NULL || !timer->active) {
 bc4:	c509                	beqz	a0,bce <_deactivate_timer+0xa>
 bc6:	01454783          	lbu	a5,20(a0)
 bca:	c391                	beqz	a5,bce <_deactivate_timer+0xa>
  timer->active = false;
 bcc:	b1d5                	j	8b0 <_deactivate_timer.part.0>
}
 bce:	4501                	li	a0,0
 bd0:	8082                	ret

00000bd2 <uart_isr>:
ring_buffer_t rx_buffer;
ring_buffer_t tx_buffer;

// Define the Interrupt Service Routine
void uart_isr(void) {
  uint32_t irq_status = *UART_IRQ_STATUS;
 bd2:	200027b7          	lui	a5,0x20002
 bd6:	07d1                	addi	a5,a5,20 # 20002014 <_stack_top+0xfff2014>
 bd8:	439c                	lw	a5,0(a5)
void uart_isr(void) {
 bda:	7179                	addi	sp,sp,-48
 bdc:	d606                	sw	ra,44(sp)

  // Handle Incoming Data
  if (irq_status & IRQ_RX_AVAIL) {
 bde:	0017f713          	andi	a4,a5,1
 be2:	e705                	bnez	a4,c0a <uart_isr+0x38>
    char c = (char)(*UART_RX_FIFO);
    insert_rb(&rx_buffer, c); // Push to RX buffer
  }

  // Handle Outgoing Data
  if ((irq_status & IRQ_TX_EMPTY) && (*UART_IRQ_EN & IRQ_TX_EMPTY)) {
 be4:	0027f713          	andi	a4,a5,2
 be8:	c711                	beqz	a4,bf4 <uart_isr+0x22>
 bea:	20002737          	lui	a4,0x20002
 bee:	4b14                	lw	a3,16(a4)
 bf0:	8a89                	andi	a3,a3,2
 bf2:	e69d                	bnez	a3,c20 <uart_isr+0x4e>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
    }
  }

  // Handle Hardware Errors
  if (irq_status & (IRQ_RX_OVERRUN | IRQ_FRAME_ERROR)) {
 bf4:	8bb1                	andi	a5,a5,12
 bf6:	c799                	beqz	a5,c04 <uart_isr+0x32>
    *UART_CTRL |= CTRL_CLR_ERRORS; // Clear the hardware error states
 bf8:	200027b7          	lui	a5,0x20002
 bfc:	47d8                	lw	a4,12(a5)
 bfe:	00476713          	ori	a4,a4,4
 c02:	c7d8                	sw	a4,12(a5)
  }
}
 c04:	50b2                	lw	ra,44(sp)
 c06:	6145                	addi	sp,sp,48
 c08:	8082                	ret
    char c = (char)(*UART_RX_FIFO);
 c0a:	200026b7          	lui	a3,0x20002
 c0e:	428c                	lw	a1,0(a3)
    insert_rb(&rx_buffer, c); // Push to RX buffer
 c10:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 c14:	0ff5f593          	zext.b	a1,a1
 c18:	c63e                	sw	a5,12(sp)
 c1a:	34c1                	jal	6da <insert_rb>
 c1c:	47b2                	lw	a5,12(sp)
 c1e:	b7d9                	j	be4 <uart_isr+0x12>
    if (pop_rb(&tx_buffer, &c)) {
 c20:	03418513          	addi	a0,gp,52 # 10000874 <tx_buffer>
 c24:	01f10593          	addi	a1,sp,31
 c28:	c63e                	sw	a5,12(sp)
 c2a:	3cd9                	jal	700 <pop_rb>
 c2c:	20002737          	lui	a4,0x20002
 c30:	47b2                	lw	a5,12(sp)
 c32:	0741                	addi	a4,a4,16 # 20002010 <_stack_top+0xfff2010>
 c34:	c519                	beqz	a0,c42 <uart_isr+0x70>
      *UART_TX_FIFO = (uint32_t)c;
 c36:	01f14683          	lbu	a3,31(sp)
 c3a:	20002737          	lui	a4,0x20002
 c3e:	c354                	sw	a3,4(a4)
 c40:	bf55                	j	bf4 <uart_isr+0x22>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c42:	4314                	lw	a3,0(a4)
 c44:	9af5                	andi	a3,a3,-3
 c46:	c314                	sw	a3,0(a4)
 c48:	b775                	j	bf4 <uart_isr+0x22>

00000c4a <uart_init>:

// Initialization function (Call this in main!)
void uart_init(void) {
 c4a:	1141                	addi	sp,sp,-16
  init_ring_buffer(&rx_buffer);
 c4c:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
void uart_init(void) {
 c50:	c606                	sw	ra,12(sp)
  init_ring_buffer(&rx_buffer);
 c52:	3c95                	jal	6c6 <init_ring_buffer>
  init_ring_buffer(&tx_buffer);
 c54:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 c58:	10450513          	addi	a0,a0,260
 c5c:	34ad                	jal	6c6 <init_ring_buffer>

  // Register ISR with the MINA PLIC at priority 1
  reg_UART_irq(uart_isr, 1);
 c5e:	4605                	li	a2,1
 c60:	6505                	lui	a0,0x1
 c62:	85b2                	mv	a1,a2
 c64:	bd250513          	addi	a0,a0,-1070 # bd2 <uart_isr>
 c68:	4681                	li	a3,0
 c6a:	342d                	jal	694 <reg_irq_handler>

  // Enable the RX interrupt permanently so we never miss incoming data
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 c6c:	200027b7          	lui	a5,0x20002
 c70:	4b98                	lw	a4,16(a5)
}
 c72:	40b2                	lw	ra,12(sp)
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 c74:	00176713          	ori	a4,a4,1
 c78:	cb98                	sw	a4,16(a5)
}
 c7a:	0141                	addi	sp,sp,16
 c7c:	8082                	ret

00000c7e <uart_putc>:

void uart_putc(char c) {
  // 1. Temporarily disable TX interrupts to avoid race conditions
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c7e:	200027b7          	lui	a5,0x20002
 c82:	4b94                	lw	a3,16(a5)

  // 2. If the software buffer is empty AND the hardware TX FIFO is empty,
  // bypass the software buffer to kickstart the hardware transmission.
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c84:	f3018713          	addi	a4,gp,-208 # 10000770 <rx_buffer>
 c88:	20474583          	lbu	a1,516(a4) # 20002204 <_stack_top+0xfff2204>
 c8c:	20574603          	lbu	a2,517(a4)
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c90:	ffd6f713          	andi	a4,a3,-3
 c94:	cb98                	sw	a4,16(a5)
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c96:	02c58863          	beq	a1,a2,cc6 <uart_putc+0x48>
void uart_putc(char c) {
 c9a:	1141                	addi	sp,sp,-16
 c9c:	c226                	sw	s1,4(sp)
 c9e:	c422                	sw	s0,8(sp)
 ca0:	c606                	sw	ra,12(sp)
 ca2:	842a                	mv	s0,a0
 ca4:	03418493          	addi	s1,gp,52 # 10000874 <tx_buffer>
    *UART_TX_FIFO = (uint32_t)c;
  } else {
    // Otherwise, hardware is busy. Queue it in the software buffer.
    while (!insert_rb(&tx_buffer, c)) {
 ca8:	85a2                	mv	a1,s0
 caa:	8526                	mv	a0,s1
 cac:	343d                	jal	6da <insert_rb>
 cae:	dd6d                	beqz	a0,ca8 <uart_putc+0x2a>
      // Busy wait only if the 256-byte buffer is completely full
    }
  }

  // 3. Re-enable TX interrupts so the ISR handles the rest
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 cb0:	200027b7          	lui	a5,0x20002
 cb4:	4b98                	lw	a4,16(a5)
}
 cb6:	40b2                	lw	ra,12(sp)
 cb8:	4422                	lw	s0,8(sp)
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 cba:	00276713          	ori	a4,a4,2
 cbe:	cb98                	sw	a4,16(a5)
}
 cc0:	4492                	lw	s1,4(sp)
 cc2:	0141                	addi	sp,sp,16
 cc4:	8082                	ret
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 cc6:	200027b7          	lui	a5,0x20002
 cca:	07a1                	addi	a5,a5,8 # 20002008 <_stack_top+0xfff2008>
 ccc:	439c                	lw	a5,0(a5)
 cce:	8b91                	andi	a5,a5,4
 cd0:	d7e9                	beqz	a5,c9a <uart_putc+0x1c>
    *UART_TX_FIFO = (uint32_t)c;
 cd2:	200027b7          	lui	a5,0x20002
 cd6:	c3c8                	sw	a0,4(a5)
  *UART_IRQ_EN |= IRQ_TX_EMPTY;
 cd8:	200027b7          	lui	a5,0x20002
 cdc:	4b98                	lw	a4,16(a5)
 cde:	00276713          	ori	a4,a4,2
 ce2:	cb98                	sw	a4,16(a5)
 ce4:	8082                	ret

00000ce6 <uart_getc>:

char uart_getc(void) {
 ce6:	1101                	addi	sp,sp,-32
 ce8:	cc22                	sw	s0,24(sp)
 cea:	ce06                	sw	ra,28(sp)
 cec:	f3018413          	addi	s0,gp,-208 # 10000770 <rx_buffer>
  char c;
  // Block only when the software buffer is completely empty
  while (!pop_rb(&rx_buffer, &c)) {
 cf0:	00f10593          	addi	a1,sp,15
 cf4:	8522                	mv	a0,s0
 cf6:	3429                	jal	700 <pop_rb>
 cf8:	dd65                	beqz	a0,cf0 <uart_getc+0xa>
    // Busy wait until the ISR receives new data
  }
  return c;
}
 cfa:	40f2                	lw	ra,28(sp)
 cfc:	4462                	lw	s0,24(sp)
 cfe:	00f14503          	lbu	a0,15(sp)
 d02:	6105                	addi	sp,sp,32
 d04:	8082                	ret

00000d06 <uart_puts>:

void uart_puts(const char *str) {
 d06:	1141                	addi	sp,sp,-16
 d08:	c422                	sw	s0,8(sp)
 d0a:	c606                	sw	ra,12(sp)
 d0c:	842a                	mv	s0,a0
  while (*str != '\0') {
 d0e:	00054503          	lbu	a0,0(a0)
 d12:	c511                	beqz	a0,d1e <uart_puts+0x18>
    uart_putc(*str);
 d14:	37ad                	jal	c7e <uart_putc>
  while (*str != '\0') {
 d16:	00144503          	lbu	a0,1(s0)
    str++;
 d1a:	0405                	addi	s0,s0,1
  while (*str != '\0') {
 d1c:	fd65                	bnez	a0,d14 <uart_puts+0xe>
  }
}
 d1e:	40b2                	lw	ra,12(sp)
 d20:	4422                	lw	s0,8(sp)
 d22:	0141                	addi	sp,sp,16
 d24:	8082                	ret

00000d26 <uart_polled_putc>:

void uart_polled_putc(char c) {
  // Wait directly on the hardware status register until TX FIFO is not
  // full/empty
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d26:	20002737          	lui	a4,0x20002
 d2a:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 d2c:	431c                	lw	a5,0(a4)
 d2e:	8b91                	andi	a5,a5,4
 d30:	dff5                	beqz	a5,d2c <uart_polled_putc+0x6>
    ;
  *UART_TX_FIFO = (uint32_t)c;
 d32:	200027b7          	lui	a5,0x20002
 d36:	c3c8                	sw	a0,4(a5)
}
 d38:	8082                	ret

00000d3a <uart_polled_puts>:

void uart_polled_puts(const char *str) {
  while (*str != '\0') {
 d3a:	00054683          	lbu	a3,0(a0)
 d3e:	ce99                	beqz	a3,d5c <uart_polled_puts+0x22>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d40:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 d44:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d48:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 d4a:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d4c:	431c                	lw	a5,0(a4)
 d4e:	8b91                	andi	a5,a5,4
 d50:	dff5                	beqz	a5,d4c <uart_polled_puts+0x12>
  *UART_TX_FIFO = (uint32_t)c;
 d52:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 d54:	00154683          	lbu	a3,1(a0)
    uart_polled_putc(*str);
    str++;
 d58:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 d5a:	faed                	bnez	a3,d4c <uart_polled_puts+0x12>
  }
}
 d5c:	8082                	ret

00000d5e <uart_print_hex>:
  while (*str != '\0') {
 d5e:	00054683          	lbu	a3,0(a0)

void uart_print_hex(const char *prefix, uint32_t val) {
 d62:	1141                	addi	sp,sp,-16
  while (*str != '\0') {
 d64:	ce99                	beqz	a3,d82 <uart_print_hex+0x24>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d66:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 d6a:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d6e:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 d70:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d72:	431c                	lw	a5,0(a4)
 d74:	8b91                	andi	a5,a5,4
 d76:	dff5                	beqz	a5,d72 <uart_print_hex+0x14>
  *UART_TX_FIFO = (uint32_t)c;
 d78:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 d7a:	00154683          	lbu	a3,1(a0)
    str++;
 d7e:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 d80:	faed                	bnez	a3,d72 <uart_print_hex+0x14>
  uart_polled_puts(prefix);
  char buf[9];
  buf[8] = '\0';
 d82:	00010623          	sb	zero,12(sp)
  for (int i = 7; i >= 0; i--) {
 d86:	005c                	addi	a5,sp,4
 d88:	ffc10513          	addi	a0,sp,-4
    uint32_t nibble = val & 0xF;
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 d8c:	4625                	li	a2,9
    uint32_t nibble = val & 0xF;
 d8e:	00f5f713          	andi	a4,a1,15
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 d92:	05770693          	addi	a3,a4,87
 d96:	00e66463          	bltu	a2,a4,d9e <uart_print_hex+0x40>
 d9a:	03070693          	addi	a3,a4,48
 d9e:	00d783a3          	sb	a3,7(a5) # 20002007 <_stack_top+0xfff2007>
  for (int i = 7; i >= 0; i--) {
 da2:	17fd                	addi	a5,a5,-1
    val >>= 4;
 da4:	8191                	srli	a1,a1,0x4
  for (int i = 7; i >= 0; i--) {
 da6:	fef514e3          	bne	a0,a5,d8e <uart_print_hex+0x30>
  while (*str != '\0') {
 daa:	00414683          	lbu	a3,4(sp)
 dae:	c285                	beqz	a3,dce <uart_print_hex+0x70>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 db0:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 db4:	200025b7          	lui	a1,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 db8:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 dba:	0591                	addi	a1,a1,4 # 20002004 <_stack_top+0xfff2004>
  while (*str != '\0') {
 dbc:	0050                	addi	a2,sp,4
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dbe:	431c                	lw	a5,0(a4)
 dc0:	8b91                	andi	a5,a5,4
 dc2:	dff5                	beqz	a5,dbe <uart_print_hex+0x60>
  *UART_TX_FIFO = (uint32_t)c;
 dc4:	c194                	sw	a3,0(a1)
  while (*str != '\0') {
 dc6:	00164683          	lbu	a3,1(a2)
    str++;
 dca:	0605                	addi	a2,a2,1
  while (*str != '\0') {
 dcc:	faed                	bnez	a3,dbe <uart_print_hex+0x60>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dce:	20002737          	lui	a4,0x20002
 dd2:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 dd4:	431c                	lw	a5,0(a4)
 dd6:	8b91                	andi	a5,a5,4
 dd8:	dff5                	beqz	a5,dd4 <uart_print_hex+0x76>
  *UART_TX_FIFO = (uint32_t)c;
 dda:	200027b7          	lui	a5,0x20002
 dde:	46b5                	li	a3,13
 de0:	c3d4                	sw	a3,4(a5)
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 de2:	00878713          	addi	a4,a5,8 # 20002008 <_stack_top+0xfff2008>
 de6:	431c                	lw	a5,0(a4)
 de8:	8b91                	andi	a5,a5,4
 dea:	dff5                	beqz	a5,de6 <uart_print_hex+0x88>
  *UART_TX_FIFO = (uint32_t)c;
 dec:	200027b7          	lui	a5,0x20002
 df0:	4729                	li	a4,10
 df2:	c3d8                	sw	a4,4(a5)
  }
  uart_polled_puts(buf);
  uart_polled_puts("\r\n");
}
 df4:	0141                	addi	sp,sp,16
 df6:	8082                	ret
