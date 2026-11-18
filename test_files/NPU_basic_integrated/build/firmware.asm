
/tmp/mina_build_1r8iGH/firmware.elf:     file format elf32-littleriscv


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
  18:	f8c50513          	addi	a0,a0,-116 # fa0 <_data_load_start>
    la a1, _sdata           /* Destination address */
  1c:	10000597          	auipc	a1,0x10000
  20:	fe458593          	addi	a1,a1,-28 # 10000000 <plic_idx_sort>
    la a2, _edata           /* End of destination */
  24:	10000617          	auipc	a2,0x10000
  28:	01c60613          	addi	a2,a2,28 # 10000040 <npu_done_flag>
    bgeu a1, a2, end_copy_data /* Skip if no data */
  2c:	00c5ff63          	bgeu	a1,a2,4a <end_copy_data>

    /* Enable FPU by setting mstatus.FS (bits 14:13) to 01 (Initial) or 11 (Dirty) */
    li t0, (3 << 13)
  30:	6299                	lui	t0,0x6
    csrs mstatus, t0
  32:	3002a073          	csrs	mstatus,t0
    csrwi fcsr, 0       /* Clear floating-point rounding mode and exception flags */
  36:	00305073          	csrwi	fcsr,0

0000003a <copy_data_loop>:
copy_data_loop:
    lw t0, 0(a0)            /* Load word from SHARED_RAM */
  3a:	00052283          	lw	t0,0(a0)
    sw t0, 0(a1)            /* Store word to CPU_RAM */
  3e:	0055a023          	sw	t0,0(a1)
    addi a0, a0, 4          /* Increment source pointer */
  42:	0511                	addi	a0,a0,4
    addi a1, a1, 4          /* Increment destination pointer */
  44:	0591                	addi	a1,a1,4
    bltu a1, a2, copy_data_loop
  46:	fec5eae3          	bltu	a1,a2,3a <copy_data_loop>

0000004a <end_copy_data>:
end_copy_data:

    /* 5. Zero out the .bss section in CPU_RAM */
    la a0, _sbss
  4a:	10000517          	auipc	a0,0x10000
  4e:	ff650513          	addi	a0,a0,-10 # 10000040 <npu_done_flag>
    la a1, _ebss
  52:	10001597          	auipc	a1,0x10001
  56:	92658593          	addi	a1,a1,-1754 # 10000978 <_ebss>
    bgeu a0, a1, end_clear_bss /* Skip if no bss */
  5a:	00b57763          	bgeu	a0,a1,68 <end_clear_bss>

0000005e <clear_bss_loop>:
clear_bss_loop:
    sw zero, 0(a0)
  5e:	00052023          	sw	zero,0(a0)
    addi a0, a0, 4
  62:	0511                	addi	a0,a0,4
    bltu a0, a1, clear_bss_loop
  64:	feb56de3          	bltu	a0,a1,5e <clear_bss_loop>

00000068 <end_clear_bss>:
end_clear_bss:

    /* 6. Jump to main C function */
    call main
  68:	2855                	jal	11c <main>

0000006a <inf_loop>:

    /* 7. Catch return from main (should not happen in bare-metal) */
inf_loop:
    j inf_loop
  6a:	a001                	j	6a <inf_loop>

0000006c <fill_matrix>:
 */
static void fill_matrix(void) {
  volatile uint32_t *dst =
      NPU_SCRATCHPAD_BASE + (NPU_SOURCE_OFFSET / sizeof(uint32_t));

  uint8_t base = simple_counter;
  6c:	10000e37          	lui	t3,0x10000
  70:	044e4303          	lbu	t1,68(t3) # 10000044 <simple_counter>
  74:	40300837          	lui	a6,0x40300
  for (uint32_t col = 0; col < MATRIX_DIM; ++col) {
  78:	403008b7          	lui	a7,0x40300
  7c:	00830793          	addi	a5,t1,8
  uint8_t base = simple_counter;
  80:	20080813          	addi	a6,a6,512 # 40300200 <_stack_top+0x302f0200>
  for (uint32_t col = 0; col < MATRIX_DIM; ++col) {
  84:	24088893          	addi	a7,a7,576 # 40300240 <_stack_top+0x302f0240>
    for (uint32_t half = 0; half < 2u; ++half) {
      uint32_t packed = 0;
      for (uint32_t lane = 0; lane < 4u; ++lane) {
        uint32_t row = half * 4u + lane;
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  88:	00878693          	addi	a3,a5,8
        packed |= ((uint32_t)val << (8u * lane));
  8c:	07f7f613          	andi	a2,a5,127
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  90:	02078713          	addi	a4,a5,32
  94:	02878513          	addi	a0,a5,40
        packed |= ((uint32_t)val << (8u * lane));
  98:	07f6f693          	andi	a3,a3,127
  9c:	0622                	slli	a2,a2,0x8
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  9e:	ff878f13          	addi	t5,a5,-8
  a2:	01078593          	addi	a1,a5,16
        packed |= ((uint32_t)val << (8u * lane));
  a6:	06c2                	slli	a3,a3,0x10
  a8:	07f77713          	andi	a4,a4,127
  ac:	07f57513          	andi	a0,a0,127
  b0:	8ed1                	or	a3,a3,a2
  b2:	0542                	slli	a0,a0,0x10
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  b4:	01878e93          	addi	t4,a5,24
  b8:	03078613          	addi	a2,a5,48
        packed |= ((uint32_t)val << (8u * lane));
  bc:	07ff7f13          	andi	t5,t5,127
  c0:	07f5f593          	andi	a1,a1,127
  c4:	0722                	slli	a4,a4,0x8
  c6:	01e6e6b3          	or	a3,a3,t5
  ca:	8f49                	or	a4,a4,a0
  cc:	05e2                	slli	a1,a1,0x18
  ce:	07fef513          	andi	a0,t4,127
  d2:	07f67613          	andi	a2,a2,127
  d6:	8dd5                	or	a1,a1,a3
  d8:	8f49                	or	a4,a4,a0
  da:	01861693          	slli	a3,a2,0x18
      }
      dst[col * 2u + half] = packed;
  de:	00b82023          	sw	a1,0(a6)
        packed |= ((uint32_t)val << (8u * lane));
  e2:	8f55                	or	a4,a4,a3
      dst[col * 2u + half] = packed;
  e4:	00e82223          	sw	a4,4(a6)
  for (uint32_t col = 0; col < MATRIX_DIM; ++col) {
  e8:	0821                	addi	a6,a6,8
  ea:	0785                	addi	a5,a5,1
  ec:	f9181ee3          	bne	a6,a7,88 <fill_matrix+0x1c>
    }
  }
  simple_counter = (uint8_t)((simple_counter + 64u) & 0x7Fu);
  f0:	04030793          	addi	a5,t1,64
  f4:	07f7f793          	andi	a5,a5,127
  f8:	04fe0223          	sb	a5,68(t3)
}
  fc:	8082                	ret

000000fe <npu_irq_handler>:
  }
}

void npu_irq_handler(void) {
  // 1. Stop the NPU and clear the interrupt pulse immediately
  NPU_HALT();
  fe:	40000737          	lui	a4,0x40000
 102:	00072023          	sw	zero,0(a4) # 40000000 <_stack_top+0x2fff0000>
  NPU_CLEAR_IRQ();
 106:	431c                	lw	a5,0(a4)

  // 2. Signal main() to read the scratchpad and print over UART
  npu_done_flag = 1;
 108:	4605                	li	a2,1
 10a:	100006b7          	lui	a3,0x10000
  NPU_CLEAR_IRQ();
 10e:	8ff1                	and	a5,a5,a2
 110:	0087e793          	ori	a5,a5,8
 114:	c31c                	sw	a5,0(a4)
  npu_done_flag = 1;
 116:	04c6a023          	sw	a2,64(a3) # 10000040 <npu_done_flag>
}
 11a:	8082                	ret

0000011c <main>:

int main(void) {
 11c:	715d                	addi	sp,sp,-80
 11e:	c4a2                	sw	s0,72(sp)
 120:	c686                	sw	ra,76(sp)
  // 1. Put NPU in a known halted/reset state and clear any stale IRQ
  //    BEFORE enabling interrupts in the CPU or PLIC
  NPU_HALT();
 122:	40000437          	lui	s0,0x40000
int main(void) {
 126:	c2a6                	sw	s1,68(sp)
 128:	c0ca                	sw	s2,64(sp)
 12a:	de4e                	sw	s3,60(sp)
 12c:	dc52                	sw	s4,56(sp)
 12e:	da56                	sw	s5,52(sp)
 130:	d85a                	sw	s6,48(sp)
 132:	d65e                	sw	s7,44(sp)
 134:	d462                	sw	s8,40(sp)
 136:	d266                	sw	s9,36(sp)
 138:	d06a                	sw	s10,32(sp)
 13a:	ce6e                	sw	s11,28(sp)
  NPU_HALT();
 13c:	00042023          	sw	zero,0(s0) # 40000000 <_stack_top+0x2fff0000>
  NPU_RESET();
 140:	4789                	li	a5,2
 142:	c01c                	sw	a5,0(s0)
  NPU_CLEAR_IRQ();
 144:	401c                	lw	a5,0(s0)
  while (!NPU_IS_HALTED()) {
 146:	00440713          	addi	a4,s0,4
  NPU_CLEAR_IRQ();
 14a:	8b85                	andi	a5,a5,1
 14c:	0087e793          	ori	a5,a5,8
 150:	c01c                	sw	a5,0(s0)
  NPU_HALT();
 152:	00042023          	sw	zero,0(s0)
  while (!NPU_IS_HALTED()) {
 156:	431c                	lw	a5,0(a4)
 158:	8b85                	andi	a5,a5,1
 15a:	dff5                	beqz	a5,156 <main+0x3a>
  npu_wait_halted();

  // 2. Initialize CPU interrupts and UART driver
  init_interrupts();
 15c:	22f5                	jal	348 <init_interrupts>
  uart_init();
 15e:	375000ef          	jal	cd2 <uart_init>

  uart_puts("About to register NPU interrupt\r\n");
 162:	6505                	lui	a0,0x1
 164:	e9050513          	addi	a0,a0,-368 # e90 <uart_print_hex+0x9a>
 168:	437000ef          	jal	d9e <uart_puts>

  reg_NPU_irq(npu_irq_handler, 1);
 16c:	4691                	li	a3,4
 16e:	4641                	li	a2,16
 170:	4585                	li	a1,1
 172:	0fe00513          	li	a0,254
 176:	2355                	jal	71a <reg_irq_handler>

  uart_puts("Starting program, loaded interrupts\r\n");
 178:	6505                	lui	a0,0x1
 17a:	eb450513          	addi	a0,a0,-332 # eb4 <uart_print_hex+0xbe>
 17e:	421000ef          	jal	d9e <uart_puts>

  // 3. Load initial Matrix A into Scratchpad at offset 0x200
  fill_matrix();
 182:	35ed                	jal	6c <fill_matrix>

  // 4. Start NPU execution from PC = 0
  NPU_START();
 184:	4785                	li	a5,1
 186:	c01c                	sw	a5,0(s0)
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 188:	ccccd437          	lui	s0,0xccccd
 18c:	ccd40413          	addi	s0,s0,-819 # cccccccd <_stack_top+0xbccbcccd>
 190:	10000cb7          	lui	s9,0x10000
 194:	4ba5                	li	s7,9
int main(void) {
 196:	05f5ec37          	lui	s8,0x5f5e
 19a:	100c0c13          	addi	s8,s8,256 # 5f5e100 <_data_load_start+0x5f5d160>
 19e:	a021                	j	1a6 <main+0x8a>
      npu_wait_halted();
      NPU_START();
    }

    counter++;
    if (counter == 100000000) {
 1a0:	1c7d                	addi	s8,s8,-1
 1a2:	0e0c0f63          	beqz	s8,2a0 <main+0x184>
    if (npu_done_flag) {
 1a6:	040ca783          	lw	a5,64(s9) # 10000040 <npu_done_flag>
 1aa:	dbfd                	beqz	a5,1a0 <main+0x84>
  NPU_HALT();
 1ac:	400007b7          	lui	a5,0x40000
      npu_done_flag = 0;
 1b0:	040ca023          	sw	zero,64(s9)
  NPU_HALT();
 1b4:	0007a023          	sw	zero,0(a5) # 40000000 <_stack_top+0x2fff0000>
  while (!NPU_IS_HALTED()) {
 1b8:	00478713          	addi	a4,a5,4
 1bc:	431c                	lw	a5,0(a4)
 1be:	8b85                	andi	a5,a5,1
 1c0:	dff5                	beqz	a5,1bc <main+0xa0>
 1c2:	40300ab7          	lui	s5,0x40300
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1c6:	51eb8b37          	lui	s6,0x51eb8
  while (!NPU_IS_HALTED()) {
 1ca:	408a8a93          	addi	s5,s5,1032 # 40300408 <_stack_top+0x302f0408>
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1ce:	51fb0b13          	addi	s6,s6,1311 # 51eb851f <_stack_top+0x41ea851f>
    for (uint32_t word = 0; word < 2u; ++word) {
 1d2:	ff8a8493          	addi	s1,s5,-8
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1d6:	06300a13          	li	s4,99
      uint32_t packed = src[row * 2u + word];
 1da:	0004a983          	lw	s3,0(s1)
 1de:	4d81                	li	s11,0
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1e0:	02000913          	li	s2,32
        uint8_t value = (uint8_t)(packed >> (8u * lane));
 1e4:	01b9d7b3          	srl	a5,s3,s11
 1e8:	0ff7fd13          	zext.b	s10,a5
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1ec:	02000513          	li	a0,32
 1f0:	11aa7763          	bgeu	s4,s10,2fe <main+0x1e2>
 1f4:	036d3533          	mulhu	a0,s10,s6
 1f8:	8115                	srli	a0,a0,0x5
 1fa:	03050513          	addi	a0,a0,48
 1fe:	309000ef          	jal	d06 <uart_putc>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 202:	028d3533          	mulhu	a0,s10,s0
 206:	810d                	srli	a0,a0,0x3
 208:	028536b3          	mulhu	a3,a0,s0
 20c:	828d                	srli	a3,a3,0x3
 20e:	00269713          	slli	a4,a3,0x2
 212:	9736                	add	a4,a4,a3
 214:	0706                	slli	a4,a4,0x1
 216:	8d19                	sub	a0,a0,a4
 218:	03050513          	addi	a0,a0,48
 21c:	0ff57513          	zext.b	a0,a0
 220:	2e7000ef          	jal	d06 <uart_putc>
  uart_putc('0' + value % 10);
 224:	028d36b3          	mulhu	a3,s10,s0
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 228:	0da1                	addi	s11,s11,8
  uart_putc('0' + value % 10);
 22a:	828d                	srli	a3,a3,0x3
 22c:	00269713          	slli	a4,a3,0x2
 230:	9736                	add	a4,a4,a3
 232:	0706                	slli	a4,a4,0x1
 234:	40ed0533          	sub	a0,s10,a4
 238:	03050513          	addi	a0,a0,48
 23c:	0ff57513          	zext.b	a0,a0
 240:	2c7000ef          	jal	d06 <uart_putc>
        uart_putc(' ');
 244:	02000513          	li	a0,32
 248:	2bf000ef          	jal	d06 <uart_putc>
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 24c:	f92d9ce3          	bne	s11,s2,1e4 <main+0xc8>
    for (uint32_t word = 0; word < 2u; ++word) {
 250:	0491                	addi	s1,s1,4
 252:	f95494e3          	bne	s1,s5,1da <main+0xbe>
    uart_putc('\r');
 256:	4535                	li	a0,13
 258:	2af000ef          	jal	d06 <uart_putc>
    uart_putc('\n');
 25c:	4529                	li	a0,10
 25e:	2a9000ef          	jal	d06 <uart_putc>
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
 262:	403007b7          	lui	a5,0x40300
 266:	00848a93          	addi	s5,s1,8
 26a:	44878793          	addi	a5,a5,1096 # 40300448 <_stack_top+0x302f0448>
 26e:	f6fa92e3          	bne	s5,a5,1d2 <main+0xb6>
  uart_putc('\r');
 272:	4535                	li	a0,13
 274:	293000ef          	jal	d06 <uart_putc>
  uart_putc('\n');
 278:	4529                	li	a0,10
 27a:	28d000ef          	jal	d06 <uart_putc>
      fill_matrix();
 27e:	33fd                	jal	6c <fill_matrix>
      NPU_RESET();
 280:	400006b7          	lui	a3,0x40000
 284:	4789                	li	a5,2
 286:	c29c                	sw	a5,0(a3)
  NPU_HALT();
 288:	0006a023          	sw	zero,0(a3) # 40000000 <_stack_top+0x2fff0000>
  while (!NPU_IS_HALTED()) {
 28c:	00468713          	addi	a4,a3,4
 290:	431c                	lw	a5,0(a4)
 292:	8b85                	andi	a5,a5,1
 294:	dff5                	beqz	a5,290 <main+0x174>
      NPU_START();
 296:	4785                	li	a5,1
 298:	c29c                	sw	a5,0(a3)
    if (counter == 100000000) {
 29a:	1c7d                	addi	s8,s8,-1
 29c:	f00c15e3          	bnez	s8,1a6 <main+0x8a>
      uart_puts("Program counter, NPU: ");
 2a0:	6785                	lui	a5,0x1
 2a2:	edc78513          	addi	a0,a5,-292 # edc <uart_print_hex+0xe6>
 2a6:	2f9000ef          	jal	d9e <uart_puts>
      uart_print_u32(NPU_READ_PC());
 2aa:	400007b7          	lui	a5,0x40000
 2ae:	07a1                	addi	a5,a5,8 # 40000008 <_stack_top+0x2fff0008>
 2b0:	439c                	lw	a5,0(a5)
  int i = 0;
 2b2:	4601                	li	a2,0
      uart_print_u32(NPU_READ_PC());
 2b4:	3ff7f793          	andi	a5,a5,1023
  if (val == 0) {
 2b8:	cbb1                	beqz	a5,30c <main+0x1f0>
    buf[i++] = '0' + (val % 10);
 2ba:	0287b733          	mulhu	a4,a5,s0
 2be:	0054                	addi	a3,sp,4
 2c0:	0605                	addi	a2,a2,1
 2c2:	00c684b3          	add	s1,a3,a2
 2c6:	85be                	mv	a1,a5
 2c8:	830d                	srli	a4,a4,0x3
 2ca:	00271693          	slli	a3,a4,0x2
 2ce:	96ba                	add	a3,a3,a4
 2d0:	0686                	slli	a3,a3,0x1
 2d2:	8f95                	sub	a5,a5,a3
 2d4:	03078793          	addi	a5,a5,48
 2d8:	fef48fa3          	sb	a5,-1(s1)
    val /= 10;
 2dc:	87ba                	mv	a5,a4
  while (val > 0) {
 2de:	fcbbeee3          	bltu	s7,a1,2ba <main+0x19e>
    uart_putc(buf[--i]);
 2e2:	fff4c503          	lbu	a0,-1(s1)
  while (i > 0) {
 2e6:	14fd                	addi	s1,s1,-1
    uart_putc(buf[--i]);
 2e8:	21f000ef          	jal	d06 <uart_putc>
  while (i > 0) {
 2ec:	005c                	addi	a5,sp,4
 2ee:	fe979ae3          	bne	a5,s1,2e2 <main+0x1c6>
      uart_puts("\r\n");
 2f2:	6785                	lui	a5,0x1
 2f4:	ef478513          	addi	a0,a5,-268 # ef4 <uart_print_hex+0xfe>
 2f8:	2a7000ef          	jal	d9e <uart_puts>
      counter = 0;
 2fc:	bd69                	j	196 <main+0x7a>
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 2fe:	209000ef          	jal	d06 <uart_putc>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 302:	02000513          	li	a0,32
 306:	f1abfde3          	bgeu	s7,s10,220 <main+0x104>
 30a:	bde5                	j	202 <main+0xe6>
    uart_putc('0');
 30c:	03000513          	li	a0,48
 310:	1f7000ef          	jal	d06 <uart_putc>
      uart_puts("\r\n");
 314:	6785                	lui	a5,0x1
 316:	ef478513          	addi	a0,a5,-268 # ef4 <uart_print_hex+0xfe>
 31a:	285000ef          	jal	d9e <uart_puts>
      counter = 0;
 31e:	bda5                	j	196 <main+0x7a>

00000320 <set_input>:
#include "../include/gpio.h"

void set_input(int gpio_num) { *GPIO_T |= (1 << gpio_num); }
 320:	20003737          	lui	a4,0x20003
 324:	4354                	lw	a3,4(a4)
 326:	4785                	li	a5,1
 328:	00a797b3          	sll	a5,a5,a0
 32c:	8fd5                	or	a5,a5,a3
 32e:	c35c                	sw	a5,4(a4)
 330:	8082                	ret

00000332 <set_output>:
void set_output(int gpio_num) { *GPIO_T &= ~(1 << gpio_num); }
 332:	20003737          	lui	a4,0x20003
 336:	4354                	lw	a3,4(a4)
 338:	4785                	li	a5,1
 33a:	00a797b3          	sll	a5,a5,a0
 33e:	fff7c793          	not	a5,a5
 342:	8ff5                	and	a5,a5,a3
 344:	c35c                	sw	a5,4(a4)
 346:	8082                	ret

00000348 <init_interrupts>:
int plic_idx_sort[8] = {0, 1, 2, 3, 4, 5, 6, 7};
void (*timer_irq_handler)(void) = NULL;

void init_interrupts(void) {
  // A. Point mtvec to our handler (Direct mode: lowest 2 bits are 00)
  write_csr(mtvec, (unsigned long)trap_handler);
 348:	3e000793          	li	a5,992
 34c:	30579073          	csrw	mtvec,a5

  // B. Enable Machine External Interrupts in the 'mie' register
  set_csr(mie, MIE_MEIE);
 350:	6785                	lui	a5,0x1
 352:	80078793          	addi	a5,a5,-2048 # 800 <swap_in_heap+0xe>
 356:	3047a7f3          	csrrs	a5,mie,a5

  // C. Enable Global Machine Interrupts in the 'mstatus' register
  set_csr(mstatus, MSTATUS_MIE);
 35a:	300467f3          	csrrsi	a5,mstatus,8
}
 35e:	8082                	ret

00000360 <plic_irq_handler>:
      // Hang indefinitely for debugger attachment
    }
  }
}

void plic_irq_handler(void) {
 360:	7179                	addi	sp,sp,-48

  uint32_t pending = *PLIC_IRQ_PEND;
 362:	200007b7          	lui	a5,0x20000
void plic_irq_handler(void) {
 366:	c85a                	sw	s6,16(sp)
 368:	c65e                	sw	s7,12(sp)
 36a:	10000b37          	lui	s6,0x10000
  uint32_t pending = *PLIC_IRQ_PEND;
 36e:	0047ab83          	lw	s7,4(a5) # 20000004 <_stack_top+0xfff0004>

  for (int i = 0; i < 8; i++) {
 372:	000b0b13          	mv	s6,s6
void plic_irq_handler(void) {
 376:	d04a                	sw	s2,32(sp)
 378:	ca56                	sw	s5,20(sp)
          plic_irq_priorities[current_idx] != -1) {
        plic_irq_handlers[current_idx]();

        // THIS ASSUMES THE HANDLER CLEARS THE STATE CAUSING THE INTERRUPT,
        // OTHERWISE THE IRQ WILL TRIGGER AGAIN
        *PLIC_CLAIM_REG = 1 << current_idx;
 37a:	20000ab7          	lui	s5,0x20000
void plic_irq_handler(void) {
 37e:	d226                	sw	s1,36(sp)
 380:	ce4e                	sw	s3,28(sp)
 382:	cc52                	sw	s4,24(sp)
 384:	c462                	sw	s8,8(sp)
 386:	d606                	sw	ra,44(sp)
 388:	d422                	sw	s0,40(sp)
 38a:	84da                	mv	s1,s6
 38c:	020b0a13          	addi	s4,s6,32 # 10000020 <plic_irq_priorities>
      if (plic_irq_handlers[current_idx] &&
 390:	81018913          	addi	s2,gp,-2032 # 10000050 <plic_irq_handlers>
        *PLIC_CLAIM_REG = 1 << current_idx;
 394:	0aa1                	addi	s5,s5,8 # 20000008 <_stack_top+0xfff0008>
    if ((pending & (1 << current_idx)) != 0) {
 396:	4985                	li	s3,1
      if (plic_irq_handlers[current_idx] &&
 398:	5c7d                	li	s8,-1
    int current_idx = plic_idx_sort[i];
 39a:	409c                	lw	a5,0(s1)
    if ((pending & (1 << current_idx)) != 0) {
 39c:	00f99433          	sll	s0,s3,a5
      if (plic_irq_handlers[current_idx] &&
 3a0:	00279713          	slli	a4,a5,0x2
    if ((pending & (1 << current_idx)) != 0) {
 3a4:	017477b3          	and	a5,s0,s7
      if (plic_irq_handlers[current_idx] &&
 3a8:	00e906b3          	add	a3,s2,a4
    if ((pending & (1 << current_idx)) != 0) {
 3ac:	cb91                	beqz	a5,3c0 <plic_irq_handler+0x60>
      if (plic_irq_handlers[current_idx] &&
 3ae:	429c                	lw	a5,0(a3)
          plic_irq_priorities[current_idx] != -1) {
 3b0:	975a                	add	a4,a4,s6
      if (plic_irq_handlers[current_idx] &&
 3b2:	c799                	beqz	a5,3c0 <plic_irq_handler+0x60>
 3b4:	5318                	lw	a4,32(a4)
 3b6:	01870563          	beq	a4,s8,3c0 <plic_irq_handler+0x60>
        plic_irq_handlers[current_idx]();
 3ba:	9782                	jalr	a5
        *PLIC_CLAIM_REG = 1 << current_idx;
 3bc:	008aa023          	sw	s0,0(s5)
  for (int i = 0; i < 8; i++) {
 3c0:	0491                	addi	s1,s1,4
 3c2:	fd449ce3          	bne	s1,s4,39a <plic_irq_handler+0x3a>
      }
    }
  }
}
 3c6:	50b2                	lw	ra,44(sp)
 3c8:	5422                	lw	s0,40(sp)
 3ca:	5492                	lw	s1,36(sp)
 3cc:	5902                	lw	s2,32(sp)
 3ce:	49f2                	lw	s3,28(sp)
 3d0:	4a62                	lw	s4,24(sp)
 3d2:	4ad2                	lw	s5,20(sp)
 3d4:	4b42                	lw	s6,16(sp)
 3d6:	4bb2                	lw	s7,12(sp)
 3d8:	4c22                	lw	s8,8(sp)
 3da:	6145                	addi	sp,sp,48
 3dc:	8082                	ret
 3de:	0001                	nop

000003e0 <trap_handler>:
void __attribute__((interrupt("machine"), aligned(4))) trap_handler(void) {
 3e0:	7171                	addi	sp,sp,-176
 3e2:	d706                	sw	ra,172(sp)
 3e4:	d516                	sw	t0,168(sp)
 3e6:	003022f3          	frcsr	t0
 3ea:	d316                	sw	t0,164(sp)
 3ec:	d11a                	sw	t1,160(sp)
 3ee:	cf1e                	sw	t2,156(sp)
 3f0:	cd22                	sw	s0,152(sp)
 3f2:	cb26                	sw	s1,148(sp)
 3f4:	c92a                	sw	a0,144(sp)
 3f6:	c72e                	sw	a1,140(sp)
 3f8:	c532                	sw	a2,136(sp)
 3fa:	c336                	sw	a3,132(sp)
 3fc:	c13a                	sw	a4,128(sp)
 3fe:	debe                	sw	a5,124(sp)
 400:	dcc2                	sw	a6,120(sp)
 402:	dac6                	sw	a7,116(sp)
 404:	d8ca                	sw	s2,112(sp)
 406:	d6ce                	sw	s3,108(sp)
 408:	d4f2                	sw	t3,104(sp)
 40a:	d2f6                	sw	t4,100(sp)
 40c:	d0fa                	sw	t5,96(sp)
 40e:	cefe                	sw	t6,92(sp)
 410:	e682                	fsw	ft0,76(sp)
 412:	e486                	fsw	ft1,72(sp)
 414:	e28a                	fsw	ft2,68(sp)
 416:	e08e                	fsw	ft3,64(sp)
 418:	fe12                	fsw	ft4,60(sp)
 41a:	fc16                	fsw	ft5,56(sp)
 41c:	fa1a                	fsw	ft6,52(sp)
 41e:	f81e                	fsw	ft7,48(sp)
 420:	f62a                	fsw	fa0,44(sp)
 422:	f42e                	fsw	fa1,40(sp)
 424:	f232                	fsw	fa2,36(sp)
 426:	f036                	fsw	fa3,32(sp)
 428:	ee3a                	fsw	fa4,28(sp)
 42a:	ec3e                	fsw	fa5,24(sp)
 42c:	ea42                	fsw	fa6,20(sp)
 42e:	e846                	fsw	fa7,16(sp)
 430:	e672                	fsw	ft8,12(sp)
 432:	e476                	fsw	ft9,8(sp)
 434:	e27a                	fsw	ft10,4(sp)
 436:	e07e                	fsw	ft11,0(sp)
  unsigned long cause = read_csr(mcause);
 438:	34202473          	csrr	s0,mcause
  if ((long)cause < 0) {
 43c:	06045963          	bgez	s0,4ae <trap_handler+0xce>
    unsigned long exception_code = cause & ~(1UL << (sizeof(long) * 8 - 1));
 440:	00141793          	slli	a5,s0,0x1
 444:	8385                	srli	a5,a5,0x1
    if (exception_code == IRQ_M_EXT) {
 446:	472d                	li	a4,11
 448:	0ce78f63          	beq	a5,a4,526 <trap_handler+0x146>
    } else if (exception_code == IRQ_M_TIMER) {
 44c:	471d                	li	a4,7
 44e:	0ce78e63          	beq	a5,a4,52a <trap_handler+0x14a>
}
 452:	50ba                	lw	ra,172(sp)
 454:	529a                	lw	t0,164(sp)
 456:	00329073          	fscsr	t0
 45a:	446a                	lw	s0,152(sp)
 45c:	52aa                	lw	t0,168(sp)
 45e:	530a                	lw	t1,160(sp)
 460:	43fa                	lw	t2,156(sp)
 462:	44da                	lw	s1,148(sp)
 464:	454a                	lw	a0,144(sp)
 466:	45ba                	lw	a1,140(sp)
 468:	462a                	lw	a2,136(sp)
 46a:	469a                	lw	a3,132(sp)
 46c:	470a                	lw	a4,128(sp)
 46e:	57f6                	lw	a5,124(sp)
 470:	5866                	lw	a6,120(sp)
 472:	58d6                	lw	a7,116(sp)
 474:	5946                	lw	s2,112(sp)
 476:	59b6                	lw	s3,108(sp)
 478:	5e26                	lw	t3,104(sp)
 47a:	5e96                	lw	t4,100(sp)
 47c:	5f06                	lw	t5,96(sp)
 47e:	4ff6                	lw	t6,92(sp)
 480:	6036                	flw	ft0,76(sp)
 482:	60a6                	flw	ft1,72(sp)
 484:	6116                	flw	ft2,68(sp)
 486:	6186                	flw	ft3,64(sp)
 488:	7272                	flw	ft4,60(sp)
 48a:	72e2                	flw	ft5,56(sp)
 48c:	7352                	flw	ft6,52(sp)
 48e:	73c2                	flw	ft7,48(sp)
 490:	7532                	flw	fa0,44(sp)
 492:	75a2                	flw	fa1,40(sp)
 494:	7612                	flw	fa2,36(sp)
 496:	7682                	flw	fa3,32(sp)
 498:	6772                	flw	fa4,28(sp)
 49a:	67e2                	flw	fa5,24(sp)
 49c:	6852                	flw	fa6,20(sp)
 49e:	68c2                	flw	fa7,16(sp)
 4a0:	6e32                	flw	ft8,12(sp)
 4a2:	6ea2                	flw	ft9,8(sp)
 4a4:	6f12                	flw	ft10,4(sp)
 4a6:	6f82                	flw	ft11,0(sp)
 4a8:	614d                	addi	sp,sp,176
 4aa:	30200073          	mret
    uart_polled_puts("\r\n\r\n=== CPU EXCEPTION / CRASH DETECTED ===\r\n");
 4ae:	6505                	lui	a0,0x1
 4b0:	ef850513          	addi	a0,a0,-264 # ef8 <uart_print_hex+0x102>
 4b4:	11f000ef          	jal	dd2 <uart_polled_puts>
    uart_print_hex("mcause: 0x", (uint32_t)cause);
 4b8:	6505                	lui	a0,0x1
 4ba:	85a2                	mv	a1,s0
 4bc:	f2850513          	addi	a0,a0,-216 # f28 <uart_print_hex+0x132>
 4c0:	137000ef          	jal	df6 <uart_print_hex>
    uart_print_hex("mepc  : 0x", (uint32_t)read_csr(mepc));
 4c4:	341025f3          	csrr	a1,mepc
 4c8:	6505                	lui	a0,0x1
 4ca:	f3450513          	addi	a0,a0,-204 # f34 <uart_print_hex+0x13e>
 4ce:	129000ef          	jal	df6 <uart_print_hex>
    uart_print_hex("mtval : 0x", (uint32_t)read_csr(mtval));
 4d2:	343025f3          	csrr	a1,mtval
 4d6:	6505                	lui	a0,0x1
 4d8:	f4050513          	addi	a0,a0,-192 # f40 <uart_print_hex+0x14a>
 4dc:	11b000ef          	jal	df6 <uart_print_hex>
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 4e0:	6505                	lui	a0,0x1
    while (stack_ptr < stack_top_ptr) {
 4e2:	100104b7          	lui	s1,0x10010
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 4e6:	f4c50513          	addi	a0,a0,-180 # f4c <uart_print_hex+0x156>
    while (stack_ptr < stack_top_ptr) {
 4ea:	00048493          	mv	s1,s1
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 4ee:	0e5000ef          	jal	dd2 <uart_polled_puts>
    while (stack_ptr < stack_top_ptr) {
 4f2:	02917463          	bgeu	sp,s1,51a <trap_handler+0x13a>
 4f6:	6785                	lui	a5,0x1
        uart_print_hex("  from instruction addr: 0x", val);
 4f8:	f7078993          	addi	s3,a5,-144 # f70 <uart_print_hex+0x17a>
 4fc:	840a                	mv	s0,sp
      if (val >= 0x00000000 && val < 0x00004000) {
 4fe:	6911                	lui	s2,0x4
 500:	a021                	j	508 <trap_handler+0x128>
    while (stack_ptr < stack_top_ptr) {
 502:	0411                	addi	s0,s0,4
 504:	00947b63          	bgeu	s0,s1,51a <trap_handler+0x13a>
      uint32_t val = *stack_ptr;
 508:	400c                	lw	a1,0(s0)
      if (val >= 0x00000000 && val < 0x00004000) {
 50a:	ff25fce3          	bgeu	a1,s2,502 <trap_handler+0x122>
        uart_print_hex("  from instruction addr: 0x", val);
 50e:	854e                	mv	a0,s3
    while (stack_ptr < stack_top_ptr) {
 510:	0411                	addi	s0,s0,4
        uart_print_hex("  from instruction addr: 0x", val);
 512:	0e5000ef          	jal	df6 <uart_print_hex>
    while (stack_ptr < stack_top_ptr) {
 516:	fe9469e3          	bltu	s0,s1,508 <trap_handler+0x128>
    uart_polled_puts("System halted.\r\n");
 51a:	6505                	lui	a0,0x1
 51c:	f8c50513          	addi	a0,a0,-116 # f8c <uart_print_hex+0x196>
 520:	0b3000ef          	jal	dd2 <uart_polled_puts>
    while (1) {
 524:	a001                	j	524 <trap_handler+0x144>
      plic_irq_handler();
 526:	3d2d                	jal	360 <plic_irq_handler>
 528:	b72d                	j	452 <trap_handler+0x72>
      if (timer_irq_handler) {
 52a:	100007b7          	lui	a5,0x10000
 52e:	0487a783          	lw	a5,72(a5) # 10000048 <timer_irq_handler>
 532:	f20780e3          	beqz	a5,452 <trap_handler+0x72>
        timer_irq_handler();
 536:	9782                	jalr	a5
 538:	bf29                	j	452 <trap_handler+0x72>

0000053a <resort_by_prior>:
  *PLIC_IRQ_ACTV |= actv_mask;

  resort_by_prior();
}

void resort_by_prior() {
 53a:	1141                	addi	sp,sp,-16

  for (int i = 0; i < 8; i++) {
    plic_idx_sort[i] = i;
 53c:	100007b7          	lui	a5,0x10000
 540:	00078793          	mv	a5,a5
void resort_by_prior() {
 544:	c622                	sw	s0,12(sp)
 546:	c426                	sw	s1,8(sp)
 548:	c24a                	sw	s2,4(sp)
 54a:	c04e                	sw	s3,0(sp)
    plic_idx_sort[i] = i;
 54c:	4709                	li	a4,2
 54e:	c798                	sw	a4,8(a5)
 550:	470d                	li	a4,3
 552:	c7d8                	sw	a4,12(a5)
 554:	4711                	li	a4,4
 556:	cb98                	sw	a4,16(a5)
 558:	4715                	li	a4,5
 55a:	cbd8                	sw	a4,20(a5)
 55c:	4719                	li	a4,6
 55e:	cf98                	sw	a4,24(a5)
  }

  // 19-Comparator Sorting Network for N=8
  // Layer 1
  CS(0, 1);
 560:	0207a283          	lw	t0,32(a5) # 10000020 <plic_irq_priorities>
    plic_idx_sort[i] = i;
 564:	471d                	li	a4,7
  CS(0, 1);
 566:	53c4                	lw	s1,36(a5)
    plic_idx_sort[i] = i;
 568:	cfd8                	sw	a4,28(a5)
 56a:	4705                	li	a4,1
 56c:	0007a023          	sw	zero,0(a5)
 570:	c3d8                	sw	a4,4(a5)
  CS(0, 1);
 572:	8eba                	mv	t4,a4
 574:	4401                	li	s0,0
 576:	0092da63          	bge	t0,s1,58a <resort_by_prior+0x50>
 57a:	8696                	mv	a3,t0
 57c:	c398                	sw	a4,0(a5)
 57e:	82a6                	mv	t0,s1
 580:	0007a223          	sw	zero,4(a5)
 584:	84b6                	mv	s1,a3
 586:	843a                	mv	s0,a4
 588:	4e81                	li	t4,0
  CS(2, 3);
 58a:	578c                	lw	a1,40(a5)
 58c:	57d8                	lw	a4,44(a5)
 58e:	4f0d                	li	t5,3
 590:	4809                	li	a6,2
 592:	00e5db63          	bge	a1,a4,5a8 <resort_by_prior+0x6e>
 596:	86ae                	mv	a3,a1
 598:	01e7a423          	sw	t5,8(a5)
 59c:	0107a623          	sw	a6,12(a5)
 5a0:	85ba                	mv	a1,a4
 5a2:	8f42                	mv	t5,a6
 5a4:	8736                	mv	a4,a3
 5a6:	480d                	li	a6,3
  CS(4, 5);
 5a8:	5b94                	lw	a3,48(a5)
 5aa:	5bd0                	lw	a2,52(a5)
 5ac:	4e15                	li	t3,5
 5ae:	4311                	li	t1,4
 5b0:	00c6db63          	bge	a3,a2,5c6 <resort_by_prior+0x8c>
 5b4:	8536                	mv	a0,a3
 5b6:	01c7a823          	sw	t3,16(a5)
 5ba:	0067aa23          	sw	t1,20(a5)
 5be:	86b2                	mv	a3,a2
 5c0:	8e1a                	mv	t3,t1
 5c2:	862a                	mv	a2,a0
 5c4:	4315                	li	t1,5
  CS(6, 7);
 5c6:	5f88                	lw	a0,56(a5)
 5c8:	03c7af83          	lw	t6,60(a5)
 5cc:	439d                	li	t2,7
 5ce:	4899                	li	a7,6
 5d0:	01f55b63          	bge	a0,t6,5e6 <resort_by_prior+0xac>
 5d4:	892a                	mv	s2,a0
 5d6:	0077ac23          	sw	t2,24(a5)
 5da:	0117ae23          	sw	a7,28(a5)
 5de:	857e                	mv	a0,t6
 5e0:	83c6                	mv	t2,a7
 5e2:	8fca                	mv	t6,s2
 5e4:	489d                	li	a7,7
  // Layer 2
  CS(0, 2);
 5e6:	00b2db63          	bge	t0,a1,5fc <resort_by_prior+0xc2>
 5ea:	89ae                	mv	s3,a1
 5ec:	8942                	mv	s2,a6
 5ee:	0107a023          	sw	a6,0(a5)
 5f2:	c780                	sw	s0,8(a5)
 5f4:	8596                	mv	a1,t0
 5f6:	8822                	mv	a6,s0
 5f8:	82ce                	mv	t0,s3
 5fa:	844a                	mv	s0,s2
  CS(1, 3);
 5fc:	00e4dc63          	bge	s1,a4,614 <resort_by_prior+0xda>
 600:	89a6                	mv	s3,s1
 602:	8976                	mv	s2,t4
 604:	01d7a623          	sw	t4,12(a5)
 608:	01e7a223          	sw	t5,4(a5)
 60c:	84ba                	mv	s1,a4
 60e:	8efa                	mv	t4,t5
 610:	874e                	mv	a4,s3
 612:	8f4a                	mv	t5,s2
  CS(4, 6);
 614:	00a6dc63          	bge	a3,a0,62c <resort_by_prior+0xf2>
 618:	89aa                	mv	s3,a0
 61a:	8946                	mv	s2,a7
 61c:	0117a823          	sw	a7,16(a5)
 620:	0067ac23          	sw	t1,24(a5)
 624:	8536                	mv	a0,a3
 626:	889a                	mv	a7,t1
 628:	86ce                	mv	a3,s3
 62a:	834a                	mv	t1,s2
  CS(5, 7);
 62c:	01f65c63          	bge	a2,t6,644 <resort_by_prior+0x10a>
 630:	89b2                	mv	s3,a2
 632:	8972                	mv	s2,t3
 634:	01c7ae23          	sw	t3,28(a5)
 638:	0077aa23          	sw	t2,20(a5)
 63c:	867e                	mv	a2,t6
 63e:	8e1e                	mv	t3,t2
 640:	8fce                	mv	t6,s3
 642:	83ca                	mv	t2,s2
  // Layer 3
  CS(1, 2);
 644:	00b4dc63          	bge	s1,a1,65c <resort_by_prior+0x122>
 648:	89a6                	mv	s3,s1
 64a:	8976                	mv	s2,t4
 64c:	01d7a423          	sw	t4,8(a5)
 650:	0107a223          	sw	a6,4(a5)
 654:	84ae                	mv	s1,a1
 656:	8ec2                	mv	t4,a6
 658:	85ce                	mv	a1,s3
 65a:	884a                	mv	a6,s2
  CS(5, 6);
 65c:	00a65c63          	bge	a2,a0,674 <resort_by_prior+0x13a>
 660:	89b2                	mv	s3,a2
 662:	8972                	mv	s2,t3
 664:	01c7ac23          	sw	t3,24(a5)
 668:	0117aa23          	sw	a7,20(a5)
 66c:	862a                	mv	a2,a0
 66e:	8e46                	mv	t3,a7
 670:	854e                	mv	a0,s3
 672:	88ca                	mv	a7,s2
  CS(0, 4);
 674:	00d2d763          	bge	t0,a3,682 <resort_by_prior+0x148>
 678:	0067a023          	sw	t1,0(a5)
 67c:	cb80                	sw	s0,16(a5)
 67e:	8696                	mv	a3,t0
 680:	8322                	mv	t1,s0
  CS(3, 7);
 682:	01f75863          	bge	a4,t6,692 <resort_by_prior+0x158>
 686:	01e7ae23          	sw	t5,28(a5)
 68a:	0077a623          	sw	t2,12(a5)
 68e:	877e                	mv	a4,t6
 690:	8f1e                	mv	t5,t2
  // Layer 4
  CS(1, 5);
 692:	00c4dc63          	bge	s1,a2,6aa <resort_by_prior+0x170>
 696:	82a6                	mv	t0,s1
 698:	8ff6                	mv	t6,t4
 69a:	01d7aa23          	sw	t4,20(a5)
 69e:	01c7a223          	sw	t3,4(a5)
 6a2:	84b2                	mv	s1,a2
 6a4:	8ef2                	mv	t4,t3
 6a6:	8616                	mv	a2,t0
 6a8:	8e7e                	mv	t3,t6
  CS(2, 6);
 6aa:	00a5dc63          	bge	a1,a0,6c2 <resort_by_prior+0x188>
 6ae:	82aa                	mv	t0,a0
 6b0:	8fc6                	mv	t6,a7
 6b2:	0117a423          	sw	a7,8(a5)
 6b6:	0107ac23          	sw	a6,24(a5)
 6ba:	852e                	mv	a0,a1
 6bc:	88c2                	mv	a7,a6
 6be:	8596                	mv	a1,t0
 6c0:	887e                	mv	a6,t6
  // Layer 5
  CS(1, 4);
 6c2:	00d4d863          	bge	s1,a3,6d2 <resort_by_prior+0x198>
 6c6:	0067a223          	sw	t1,4(a5)
 6ca:	01d7a823          	sw	t4,16(a5)
 6ce:	86a6                	mv	a3,s1
 6d0:	8376                	mv	t1,t4
  CS(3, 6);
 6d2:	00a75863          	bge	a4,a0,6e2 <resort_by_prior+0x1a8>
 6d6:	01e7ac23          	sw	t5,24(a5)
 6da:	0117a623          	sw	a7,12(a5)
 6de:	872a                	mv	a4,a0
 6e0:	8f46                	mv	t5,a7
  // Layer 6
  CS(2, 4);
 6e2:	00d5d863          	bge	a1,a3,6f2 <resort_by_prior+0x1b8>
 6e6:	0067a423          	sw	t1,8(a5)
 6ea:	0107a823          	sw	a6,16(a5)
 6ee:	86ae                	mv	a3,a1
 6f0:	8342                	mv	t1,a6
  CS(3, 5);
 6f2:	00c75863          	bge	a4,a2,702 <resort_by_prior+0x1c8>
 6f6:	01e7aa23          	sw	t5,20(a5)
 6fa:	01c7a623          	sw	t3,12(a5)
 6fe:	8732                	mv	a4,a2
 700:	8f72                	mv	t5,t3
  // Layer 7
  CS(3, 4);
 702:	00d75663          	bge	a4,a3,70e <resort_by_prior+0x1d4>
 706:	0067a623          	sw	t1,12(a5)
 70a:	01e7a823          	sw	t5,16(a5)
}
 70e:	4432                	lw	s0,12(sp)
 710:	44a2                	lw	s1,8(sp)
 712:	4912                	lw	s2,4(sp)
 714:	4982                	lw	s3,0(sp)
 716:	0141                	addi	sp,sp,16
 718:	8082                	ret

0000071a <reg_irq_handler>:
  *PLIC_IRQ_ACTV |= actv_mask;
 71a:	200008b7          	lui	a7,0x20000
 71e:	0008a803          	lw	a6,0(a7) # 20000000 <_stack_top+0xfff0000>
  plic_irq_priorities[arr_idx] = priority;
 722:	100007b7          	lui	a5,0x10000
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 726:	068a                	slli	a3,a3,0x2
 728:	81018713          	addi	a4,gp,-2032 # 10000050 <plic_irq_handlers>
  plic_irq_priorities[arr_idx] = priority;
 72c:	00078793          	mv	a5,a5
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 730:	9736                	add	a4,a4,a3
  plic_irq_priorities[arr_idx] = priority;
 732:	97b6                	add	a5,a5,a3
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 734:	c308                	sw	a0,0(a4)
  plic_irq_priorities[arr_idx] = priority;
 736:	d38c                	sw	a1,32(a5)
  *PLIC_IRQ_ACTV |= actv_mask;
 738:	00c86833          	or	a6,a6,a2
 73c:	0108a023          	sw	a6,0(a7)
  resort_by_prior();
 740:	bbed                	j	53a <resort_by_prior>

00000742 <reg_timer_irq>:

void reg_timer_irq(void (*_timer_irq_handler)(void)) {
  timer_irq_handler = _timer_irq_handler;
 742:	100007b7          	lui	a5,0x10000
 746:	04a7a423          	sw	a0,72(a5) # 10000048 <timer_irq_handler>
}
 74a:	8082                	ret
 74c:	0001                	nop

0000074e <init_ring_buffer>:
#include "../include/ring_buff.h"

void init_ring_buffer(ring_buffer_t *rb) {
  // No malloc needed! The memory is already allocated as part of the struct.
  rb->head = 0;
 74e:	10050023          	sb	zero,256(a0)
  rb->tail = 0;
 752:	100500a3          	sb	zero,257(a0)
}
 756:	8082                	ret

00000758 <reset_ring_buffer>:

void reset_ring_buffer(ring_buffer_t *rb) {
 758:	10050023          	sb	zero,256(a0)
 75c:	100500a3          	sb	zero,257(a0)
 760:	8082                	ret

00000762 <insert_rb>:
}

bool insert_rb(ring_buffer_t *rb, char c) {
  // Calculate what the next head position will be.
  // uint8_t naturally wraps from 255 back to 0.
  uint8_t next_head = (uint8_t)(rb->head + 1);
 762:	10054703          	lbu	a4,256(a0)

  // If the next head hits the tail, the buffer is full.
  // Note: This design sacrifices 1 byte of capacity, holding a max of 255
  // items.
  if (next_head == rb->tail) {
 766:	10154683          	lbu	a3,257(a0)
  uint8_t next_head = (uint8_t)(rb->head + 1);
 76a:	00170793          	addi	a5,a4,1 # 20003001 <_stack_top+0xfff3001>
 76e:	0ff7f793          	zext.b	a5,a5
  if (next_head == rb->tail) {
 772:	00f68963          	beq	a3,a5,784 <insert_rb+0x22>
    return false;
  }

  rb->buffer[rb->head] = c;
 776:	972a                	add	a4,a4,a0
 778:	00b70023          	sb	a1,0(a4)
  rb->head = next_head;
 77c:	10f50023          	sb	a5,256(a0)

  return true;
 780:	4505                	li	a0,1
 782:	8082                	ret
    return false;
 784:	4501                	li	a0,0
}
 786:	8082                	ret

00000788 <pop_rb>:

bool pop_rb(ring_buffer_t *rb, char *c) {
  // If head and tail are at the same position, the buffer is empty.
  if (rb->head == rb->tail) {
 788:	10154703          	lbu	a4,257(a0)
 78c:	10054683          	lbu	a3,256(a0)
bool pop_rb(ring_buffer_t *rb, char *c) {
 790:	87aa                	mv	a5,a0
  if (rb->head == rb->tail) {
 792:	00e68e63          	beq	a3,a4,7ae <pop_rb+0x26>
    return false;
  }

  *c = rb->buffer[rb->tail];
 796:	972a                	add	a4,a4,a0
 798:	00074703          	lbu	a4,0(a4)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0

  return true;
 79c:	4505                	li	a0,1
  *c = rb->buffer[rb->tail];
 79e:	00e58023          	sb	a4,0(a1)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0
 7a2:	1017c703          	lbu	a4,257(a5)
 7a6:	972a                	add	a4,a4,a0
 7a8:	10e780a3          	sb	a4,257(a5)
  return true;
 7ac:	8082                	ret
    return false;
 7ae:	4501                	li	a0,0
}
 7b0:	8082                	ret

000007b2 <init_timers>:
#include "../include/timer.h"
#include <stdint.h>

void init_timers() {
 7b2:	1141                	addi	sp,sp,-16
 7b4:	c606                	sw	ra,12(sp)

  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 7b6:	20000737          	lui	a4,0x20000
 7ba:	56fd                	li	a3,-1
 7bc:	c714                	sw	a3,8(a4)
  *TIMER_COMP_PART2 = 0xFFFFFFFF;

  reg_timer_irq(master_timer_isr);
 7be:	6505                	lui	a0,0x1
  *TIMER_COMP_PART2 = 0xFFFFFFFF;
 7c0:	c754                	sw	a3,12(a4)
  reg_timer_irq(master_timer_isr);
 7c2:	9ee50513          	addi	a0,a0,-1554 # 9ee <master_timer_isr>
 7c6:	3fb5                	jal	742 <reg_timer_irq>

  set_csr(mie, MIE_MTIE);
 7c8:	08000793          	li	a5,128
 7cc:	3047a7f3          	csrrs	a5,mie,a5
}
 7d0:	40b2                	lw	ra,12(sp)
 7d2:	0141                	addi	sp,sp,16
 7d4:	8082                	ret

000007d6 <read_time>:

uint64_t read_time() {
  uint32_t lo = *TIMER_COMP_PART1;
 7d6:	200007b7          	lui	a5,0x20000
 7da:	4788                	lw	a0,8(a5)

  uint32_t hi = *TIMER_COMP_PART2;
 7dc:	200007b7          	lui	a5,0x20000

  return (((uint64_t)hi) << 32) | lo;
}
 7e0:	47cc                	lw	a1,12(a5)
 7e2:	8082                	ret

000007e4 <set_compare>:

void set_compare(uint64_t comp) {
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 7e4:	200007b7          	lui	a5,0x20000
 7e8:	56fd                	li	a3,-1
 7ea:	c794                	sw	a3,8(a5)

  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 7ec:	c7cc                	sw	a1,12(a5)

  *TIMER_COMP_PART1 = (uint32_t)comp;
 7ee:	c788                	sw	a0,8(a5)
}
 7f0:	8082                	ret

000007f2 <swap_in_heap>:

void swap_in_heap(int a_i, int b_i) {
  irq_timer_t *temp = timer_heap[a_i];
 7f2:	83018793          	addi	a5,gp,-2000 # 10000070 <timer_heap>
  timer_heap[a_i] = timer_heap[b_i];
 7f6:	058a                	slli	a1,a1,0x2
 7f8:	95be                	add	a1,a1,a5
  irq_timer_t *temp = timer_heap[a_i];
 7fa:	050a                	slli	a0,a0,0x2
  timer_heap[a_i] = timer_heap[b_i];
 7fc:	4194                	lw	a3,0(a1)
  irq_timer_t *temp = timer_heap[a_i];
 7fe:	97aa                	add	a5,a5,a0
 800:	4398                	lw	a4,0(a5)
  timer_heap[a_i] = timer_heap[b_i];
 802:	c394                	sw	a3,0(a5)
  timer_heap[b_i] = temp;
 804:	c198                	sw	a4,0(a1)
}
 806:	8082                	ret

00000808 <min_heapify>:

// first call should be, num_timers, 0
void min_heapify(int sz, int i) {
  int smallest = i;
  int left = 2 * i + 1;
 808:	00159793          	slli	a5,a1,0x1
 80c:	00178693          	addi	a3,a5,1 # 20000001 <_stack_top+0xfff0001>
  int right = 2 * i + 2;

  if (left < sz &&
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 810:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
  int right = 2 * i + 2;
 814:	0789                	addi	a5,a5,2
  if (left < sz &&
 816:	06a6de63          	bge	a3,a0,892 <min_heapify+0x8a>
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 81a:	00269713          	slli	a4,a3,0x2
 81e:	00259613          	slli	a2,a1,0x2
 822:	9742                	add	a4,a4,a6
 824:	00c80333          	add	t1,a6,a2
 828:	00072883          	lw	a7,0(a4) # 20000000 <_stack_top+0xfff0000>
 82c:	00032e03          	lw	t3,0(t1)
 830:	0048a703          	lw	a4,4(a7)
  if (left < sz &&
 834:	004e2303          	lw	t1,4(t3)
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 838:	0008a883          	lw	a7,0(a7)
  if (left < sz &&
 83c:	00676863          	bltu	a4,t1,84c <min_heapify+0x44>
 840:	04e31963          	bne	t1,a4,892 <min_heapify+0x8a>
 844:	000e2303          	lw	t1,0(t3)
 848:	0468f563          	bgeu	a7,t1,892 <min_heapify+0x8a>
    smallest = left;
  }

  if (right < sz &&
 84c:	00a7dd63          	bge	a5,a0,866 <min_heapify+0x5e>
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 850:	00279313          	slli	t1,a5,0x2
 854:	9342                	add	t1,t1,a6
 856:	00032e03          	lw	t3,0(t1)
  if (right < sz &&
 85a:	004e2303          	lw	t1,4(t3)
 85e:	00e36563          	bltu	t1,a4,868 <min_heapify+0x60>
 862:	06e30563          	beq	t1,a4,8cc <min_heapify+0xc4>
 866:	87b6                	mv	a5,a3
    smallest = right;
  }

  if (smallest != i) {
 868:	06b78163          	beq	a5,a1,8ca <min_heapify+0xc2>
  timer_heap[a_i] = timer_heap[b_i];
 86c:	00279713          	slli	a4,a5,0x2
 870:	9742                	add	a4,a4,a6
  irq_timer_t *temp = timer_heap[a_i];
 872:	00c806b3          	add	a3,a6,a2
  timer_heap[a_i] = timer_heap[b_i];
 876:	00072883          	lw	a7,0(a4)
  irq_timer_t *temp = timer_heap[a_i];
 87a:	4290                	lw	a2,0(a3)
    swap_in_heap(i, smallest);
    min_heapify(sz, smallest);
 87c:	85be                	mv	a1,a5
  timer_heap[a_i] = timer_heap[b_i];
 87e:	0116a023          	sw	a7,0(a3)
  int left = 2 * i + 1;
 882:	00159793          	slli	a5,a1,0x1
 886:	00178693          	addi	a3,a5,1
  timer_heap[b_i] = temp;
 88a:	c310                	sw	a2,0(a4)
  int right = 2 * i + 2;
 88c:	0789                	addi	a5,a5,2
  if (left < sz &&
 88e:	f8a6c6e3          	blt	a3,a0,81a <min_heapify+0x12>
  if (right < sz &&
 892:	00a7c363          	blt	a5,a0,898 <min_heapify+0x90>
 896:	8082                	ret
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 898:	00259613          	slli	a2,a1,0x2
 89c:	00279713          	slli	a4,a5,0x2
 8a0:	00c806b3          	add	a3,a6,a2
 8a4:	9742                	add	a4,a4,a6
 8a6:	0006a303          	lw	t1,0(a3)
 8aa:	00072883          	lw	a7,0(a4)
  if (right < sz &&
 8ae:	00432683          	lw	a3,4(t1)
 8b2:	0048a703          	lw	a4,4(a7)
 8b6:	fad769e3          	bltu	a4,a3,868 <min_heapify+0x60>
 8ba:	00e69863          	bne	a3,a4,8ca <min_heapify+0xc2>
 8be:	00032683          	lw	a3,0(t1)
 8c2:	0008a703          	lw	a4,0(a7)
 8c6:	fad761e3          	bltu	a4,a3,868 <min_heapify+0x60>
  }
}
 8ca:	8082                	ret
  if (right < sz &&
 8cc:	000e2703          	lw	a4,0(t3)
 8d0:	f9176ce3          	bltu	a4,a7,868 <min_heapify+0x60>
 8d4:	87b6                	mv	a5,a3
 8d6:	bf49                	j	868 <min_heapify+0x60>

000008d8 <sift_up>:

void sift_up(int i) {
  int parent = (i - 1) / 2;
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 8d8:	04a05f63          	blez	a0,936 <sift_up+0x5e>
 8dc:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 8e0:	00251793          	slli	a5,a0,0x2
 8e4:	97b2                	add	a5,a5,a2
 8e6:	0007a303          	lw	t1,0(a5)
  int parent = (i - 1) / 2;
 8ea:	fff50713          	addi	a4,a0,-1
 8ee:	8705                	srai	a4,a4,0x1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 8f0:	00032e83          	lw	t4,0(t1)
 8f4:	00432e03          	lw	t3,4(t1)
 8f8:	a809                	j	90a <sift_up+0x32>
  timer_heap[a_i] = timer_heap[b_i];
 8fa:	c10c                	sw	a1,0(a0)
  timer_heap[b_i] = temp;
 8fc:	0067a023          	sw	t1,0(a5)
    swap_in_heap(i, parent);

    // Move up the tree
    i = parent;
    parent = (i - 1) / 2;
 900:	96c2                	add	a3,a3,a6
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 902:	853a                	mv	a0,a4
 904:	cb0d                	beqz	a4,936 <sift_up+0x5e>
 906:	4016d713          	srai	a4,a3,0x1
 90a:	00271793          	slli	a5,a4,0x2
 90e:	00f606b3          	add	a3,a2,a5
 912:	428c                	lw	a1,0(a3)
  timer_heap[a_i] = timer_heap[b_i];
 914:	050a                	slli	a0,a0,0x2
    parent = (i - 1) / 2;
 916:	fff70813          	addi	a6,a4,-1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 91a:	0045a883          	lw	a7,4(a1)
  timer_heap[b_i] = temp;
 91e:	87b6                	mv	a5,a3
  timer_heap[a_i] = timer_heap[b_i];
 920:	9532                	add	a0,a0,a2
    parent = (i - 1) / 2;
 922:	01f85693          	srli	a3,a6,0x1f
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 926:	fd1e6ae3          	bltu	t3,a7,8fa <sift_up+0x22>
 92a:	01c89663          	bne	a7,t3,936 <sift_up+0x5e>
 92e:	0005a883          	lw	a7,0(a1)
 932:	fd1ee4e3          	bltu	t4,a7,8fa <sift_up+0x22>
  }
}
 936:	8082                	ret

00000938 <_deactivate_timer.part.0>:
  // 1. Mark as inactive so the pool slot can be reused
  timer->active = false;

  // 2. Find the timer in the heap (O(N) search, but MAX_TIMERS is small)
  int heap_idx = -1;
  for (int i = 0; i < num_timers; i++) {
 938:	80c1a683          	lw	a3,-2036(gp) # 1000004c <num_timers>
  timer->active = false;
 93c:	00050a23          	sb	zero,20(a0)
  for (int i = 0; i < num_timers; i++) {
 940:	06d05063          	blez	a3,9a0 <_deactivate_timer.part.0+0x68>
 944:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 948:	87b2                	mv	a5,a2
 94a:	4581                	li	a1,0
 94c:	a021                	j	954 <_deactivate_timer.part.0+0x1c>
 94e:	0585                	addi	a1,a1,1
 950:	04d58863          	beq	a1,a3,9a0 <_deactivate_timer.part.0+0x68>
    if (timer_heap[i] == timer) {
 954:	4398                	lw	a4,0(a5)
  for (int i = 0; i < num_timers; i++) {
 956:	0791                	addi	a5,a5,4
    if (timer_heap[i] == timer) {
 958:	fee51be3          	bne	a0,a4,94e <_deactivate_timer.part.0+0x16>
  if (heap_idx == -1) {
    return false; // Timer was active but not in heap (state error)
  }

  // 3. Replace the removed timer with the last timer in the heap
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 95c:	fff68513          	addi	a0,a3,-1
 960:	00251793          	slli	a5,a0,0x2
 964:	97b2                	add	a5,a5,a2
 966:	4398                	lw	a4,0(a5)
bool _deactivate_timer(irq_timer_t *timer) {
 968:	1141                	addi	sp,sp,-16
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 96a:	00259793          	slli	a5,a1,0x2
bool _deactivate_timer(irq_timer_t *timer) {
 96e:	c606                	sw	ra,12(sp)
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 970:	97b2                	add	a5,a5,a2
  num_timers--;
 972:	80a1a623          	sw	a0,-2036(gp) # 1000004c <num_timers>
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 976:	c398                	sw	a4,0(a5)

  // 4. Restore the heap property
  if (heap_idx < num_timers) {
 978:	02a5d663          	bge	a1,a0,9a4 <_deactivate_timer.part.0+0x6c>
    int parent = (heap_idx - 1) / 2;

    // If the new node is smaller than its parent, it needs to bubble up
    if (heap_idx > 0 &&
 97c:	c5ad                	beqz	a1,9e6 <_deactivate_timer.part.0+0xae>
    int parent = (heap_idx - 1) / 2;
 97e:	fff58793          	addi	a5,a1,-1
 982:	8785                	srai	a5,a5,0x1
        timer_heap[heap_idx]->expires_at < timer_heap[parent]->expires_at) {
 984:	078a                	slli	a5,a5,0x2
 986:	963e                	add	a2,a2,a5
 988:	4210                	lw	a2,0(a2)
    if (heap_idx > 0 &&
 98a:	435c                	lw	a5,4(a4)
 98c:	4254                	lw	a3,4(a2)
 98e:	04d7e963          	bltu	a5,a3,9e0 <_deactivate_timer.part.0+0xa8>
 992:	04f68363          	beq	a3,a5,9d8 <_deactivate_timer.part.0+0xa0>
      sift_up(heap_idx);
    }
    // Otherwise, it might need to bubble down
    else {
      min_heapify(num_timers, heap_idx);
 996:	3d8d                	jal	808 <min_heapify>
      set_compare(0xFFFFFFFFFFFFFFFFULL);
    }
  }

  return true;
}
 998:	40b2                	lw	ra,12(sp)
  return true;
 99a:	4505                	li	a0,1
}
 99c:	0141                	addi	sp,sp,16
 99e:	8082                	ret
    return false;
 9a0:	4501                	li	a0,0
}
 9a2:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 9a4:	ed99                	bnez	a1,9c2 <_deactivate_timer.part.0+0x8a>
    if (num_timers > 0) {
 9a6:	cd19                	beqz	a0,9c4 <_deactivate_timer.part.0+0x8c>
      set_compare(timer_heap[0]->expires_at);
 9a8:	4218                	lw	a4,0(a2)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 9aa:	200007b7          	lui	a5,0x20000
 9ae:	55fd                	li	a1,-1
      set_compare(timer_heap[0]->expires_at);
 9b0:	4350                	lw	a2,4(a4)
 9b2:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 9b4:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 9b6:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 9b8:	c794                	sw	a3,8(a5)
}
 9ba:	40b2                	lw	ra,12(sp)
  return true;
 9bc:	4505                	li	a0,1
}
 9be:	0141                	addi	sp,sp,16
 9c0:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 9c2:	fd65                	bnez	a0,9ba <_deactivate_timer.part.0+0x82>
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 9c4:	200007b7          	lui	a5,0x20000
 9c8:	577d                	li	a4,-1
 9ca:	c798                	sw	a4,8(a5)
}
 9cc:	40b2                	lw	ra,12(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 9ce:	c7d8                	sw	a4,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 9d0:	c798                	sw	a4,8(a5)
  return true;
 9d2:	4505                	li	a0,1
}
 9d4:	0141                	addi	sp,sp,16
 9d6:	8082                	ret
    if (heap_idx > 0 &&
 9d8:	4214                	lw	a3,0(a2)
 9da:	431c                	lw	a5,0(a4)
 9dc:	fad7fde3          	bgeu	a5,a3,996 <_deactivate_timer.part.0+0x5e>
      sift_up(heap_idx);
 9e0:	852e                	mv	a0,a1
 9e2:	3ddd                	jal	8d8 <sift_up>
  if (heap_idx == 0 || num_timers == 0) {
 9e4:	bfd9                	j	9ba <_deactivate_timer.part.0+0x82>
      min_heapify(num_timers, heap_idx);
 9e6:	350d                	jal	808 <min_heapify>
  if (heap_idx == 0 || num_timers == 0) {
 9e8:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 9ec:	bf75                	j	9a8 <_deactivate_timer.part.0+0x70>

000009ee <master_timer_isr>:

void master_timer_isr() {
 9ee:	1101                	addi	sp,sp,-32
 9f0:	c452                	sw	s4,8(sp)
  // Loop to handle cases where multiple timers expire at the same time,
  // or if a callback execution delays us past the next timer's expiration.
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 9f2:	80c1a783          	lw	a5,-2036(gp) # 1000004c <num_timers>
void master_timer_isr() {
 9f6:	ce06                	sw	ra,28(sp)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 9f8:	04f05f63          	blez	a5,a56 <master_timer_isr+0x68>
 9fc:	ca26                	sw	s1,20(sp)
 9fe:	c84a                	sw	s2,16(sp)
 a00:	c64e                	sw	s3,12(sp)
 a02:	200009b7          	lui	s3,0x20000
 a06:	20000937          	lui	s2,0x20000
 a0a:	cc22                	sw	s0,24(sp)
 a0c:	c256                	sw	s5,4(sp)
 a0e:	83018493          	addi	s1,gp,-2000 # 10000070 <timer_heap>
 a12:	09a1                	addi	s3,s3,8 # 20000008 <_stack_top+0xfff0008>
 a14:	0931                	addi	s2,s2,12 # 2000000c <_stack_top+0xfff000c>
 a16:	4080                	lw	s0,0(s1)
  uint32_t lo = *TIMER_COMP_PART1;
 a18:	0009a683          	lw	a3,0(s3)
  uint32_t hi = *TIMER_COMP_PART2;
 a1c:	00092783          	lw	a5,0(s2)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 a20:	4058                	lw	a4,4(s0)
 a22:	06e7e263          	bltu	a5,a4,a86 <master_timer_isr+0x98>
 a26:	04f70d63          	beq	a4,a5,a80 <master_timer_isr+0x92>

    // 1. Get the timer at the top of the heap
    irq_timer_t *top_timer = timer_heap[0];

    // 2. Run the callback function
    if (top_timer->callback_function != NULL) {
 a2a:	481c                	lw	a5,16(s0)
 a2c:	c391                	beqz	a5,a30 <master_timer_isr+0x42>
      // Cast the void* to a function pointer and execute it
      void (*callback)(void) = (void (*)(void))top_timer->callback_function;
      callback();
 a2e:	9782                	jalr	a5
    }

    // 3. Handle periodic vs absolute
    if (top_timer->period > 0) {
 a30:	441c                	lw	a5,8(s0)
 a32:	4454                	lw	a3,12(s0)
 a34:	00d7e733          	or	a4,a5,a3
 a38:	e31d                	bnez	a4,a5e <master_timer_isr+0x70>
  if (timer == NULL || !timer->active) {
 a3a:	01444783          	lbu	a5,20(s0)
 a3e:	c399                	beqz	a5,a44 <master_timer_isr+0x56>
  timer->active = false;
 a40:	8522                	mv	a0,s0
 a42:	3ddd                	jal	938 <_deactivate_timer.part.0>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 a44:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
 a48:	fd5047e3          	bgtz	s5,a16 <master_timer_isr+0x28>
 a4c:	4462                	lw	s0,24(sp)
 a4e:	44d2                	lw	s1,20(sp)
 a50:	4942                	lw	s2,16(sp)
 a52:	49b2                	lw	s3,12(sp)
 a54:	4a92                	lw	s5,4(sp)
  }

  if (num_timers > 0) {
    set_compare(timer_heap[0]->expires_at);
  }
}
 a56:	40f2                	lw	ra,28(sp)
 a58:	4a22                	lw	s4,8(sp)
 a5a:	6105                	addi	sp,sp,32
 a5c:	8082                	ret
      top_timer->expires_at += top_timer->period;
 a5e:	4018                	lw	a4,0(s0)
 a60:	4050                	lw	a2,4(s0)
      min_heapify(num_timers, 0);
 a62:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
      top_timer->expires_at += top_timer->period;
 a66:	97ba                	add	a5,a5,a4
 a68:	00e7b733          	sltu	a4,a5,a4
 a6c:	96b2                	add	a3,a3,a2
 a6e:	9736                	add	a4,a4,a3
 a70:	c01c                	sw	a5,0(s0)
 a72:	c058                	sw	a4,4(s0)
      min_heapify(num_timers, 0);
 a74:	8556                	mv	a0,s5
 a76:	4581                	li	a1,0
 a78:	3b41                	jal	808 <min_heapify>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 a7a:	f9504ee3          	bgtz	s5,a16 <master_timer_isr+0x28>
 a7e:	b7f9                	j	a4c <master_timer_isr+0x5e>
 a80:	401c                	lw	a5,0(s0)
 a82:	faf6f4e3          	bgeu	a3,a5,a2a <master_timer_isr+0x3c>
    set_compare(timer_heap[0]->expires_at);
 a86:	4098                	lw	a4,0(s1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a88:	200007b7          	lui	a5,0x20000
 a8c:	55fd                	li	a1,-1
    set_compare(timer_heap[0]->expires_at);
 a8e:	4350                	lw	a2,4(a4)
 a90:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a92:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 a94:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 a96:	c794                	sw	a3,8(a5)
 a98:	bf55                	j	a4c <master_timer_isr+0x5e>

00000a9a <register_isr_periodic>:
  if (num_timers == MAX_TIMERS) {
 a9a:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 a9e:	04000793          	li	a5,64
 aa2:	0af88e63          	beq	a7,a5,b5e <register_isr_periodic+0xc4>
    if (timer_pool[i].active == false) {
 aa6:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 aaa:	11484783          	lbu	a5,276(a6)
irq_timer_handler register_isr_periodic(uint64_t period, void *cb) {
 aae:	1101                	addi	sp,sp,-32
 ab0:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 ab2:	cbc5                	beqz	a5,b62 <register_isr_periodic+0xc8>
 ab4:	12c80793          	addi	a5,a6,300
  int i = 0;
 ab8:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 aba:	0007c683          	lbu	a3,0(a5) # 20000000 <_stack_top+0xfff0000>
 abe:	07e1                	addi	a5,a5,24
      i++;
 ac0:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 ac2:	fee5                	bnez	a3,aba <register_isr_periodic+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 ac4:	00171793          	slli	a5,a4,0x1
 ac8:	00e78333          	add	t1,a5,a4
 acc:	030e                	slli	t1,t1,0x3
 ace:	10080693          	addi	a3,a6,256
 ad2:	969a                	add	a3,a3,t1
  uint32_t lo = *TIMER_COMP_PART1;
 ad4:	20000e37          	lui	t3,0x20000
  timer_pool[i].expires_at = read_time() + period;
 ad8:	97ba                	add	a5,a5,a4
  uint32_t lo = *TIMER_COMP_PART1;
 ada:	008e2703          	lw	a4,8(t3) # 20000008 <_stack_top+0xfff0008>
 ade:	832a                	mv	t1,a0
  uint32_t hi = *TIMER_COMP_PART2;
 ae0:	00ce2503          	lw	a0,12(t3)
  timer_pool[i].expires_at = read_time() + period;
 ae4:	006702b3          	add	t0,a4,t1
 ae8:	00e2b733          	sltu	a4,t0,a4
 aec:	952e                	add	a0,a0,a1
 aee:	078e                	slli	a5,a5,0x3
 af0:	97c2                	add	a5,a5,a6
 af2:	972a                	add	a4,a4,a0
  timer_pool[i].active = true;
 af4:	4385                	li	t2,1
  timer_heap[num_timers - 1] = &timer_pool[i];
 af6:	00289f13          	slli	t5,a7,0x2
  timer_pool[i].expires_at = read_time() + period;
 afa:	10e7a223          	sw	a4,260(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 afe:	9f42                	add	t5,t5,a6
  num_timers++;
 b00:	00788733          	add	a4,a7,t2
  sift_up(num_timers - 1);
 b04:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + period;
 b06:	1057a023          	sw	t0,256(a5)
  timer_pool[i].period = period;
 b0a:	1067a423          	sw	t1,264(a5)
 b0e:	10b7a623          	sw	a1,268(a5)
  timer_pool[i].callback_function = cb;
 b12:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 b16:	10778a23          	sb	t2,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 b1a:	00df2023          	sw	a3,0(t5)
 b1e:	c636                	sw	a3,12(sp)
  num_timers++;
 b20:	80e1a623          	sw	a4,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 b24:	3b55                	jal	8d8 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 b26:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 b2a:	46b2                	lw	a3,12(sp)
 b2c:	20000eb7          	lui	t4,0x20000
 b30:	20000e37          	lui	t3,0x20000
 b34:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 b36:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 b38:	00d78663          	beq	a5,a3,b44 <register_isr_periodic+0xaa>
}
 b3c:	40f2                	lw	ra,28(sp)
  return new_handler;
 b3e:	8536                	mv	a0,a3
}
 b40:	6105                	addi	sp,sp,32
 b42:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 b44:	42d8                	lw	a4,4(a3)
 b46:	429c                	lw	a5,0(a3)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 b48:	567d                	li	a2,-1
 b4a:	00ce2023          	sw	a2,0(t3)
}
 b4e:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 b50:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 b54:	00fe2023          	sw	a5,0(t3)
  return new_handler;
 b58:	8536                	mv	a0,a3
}
 b5a:	6105                	addi	sp,sp,32
 b5c:	8082                	ret
    return (irq_timer_handler){};
 b5e:	4501                	li	a0,0
}
 b60:	8082                	ret
    if (timer_pool[i].active == false) {
 b62:	10080693          	addi	a3,a6,256
  int i = 0;
 b66:	4701                	li	a4,0
 b68:	b7b5                	j	ad4 <register_isr_periodic+0x3a>

00000b6a <register_isr_abs>:
  if (num_timers == MAX_TIMERS) {
 b6a:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 b6e:	04000793          	li	a5,64
 b72:	0cf88063          	beq	a7,a5,c32 <register_isr_abs+0xc8>
    if (timer_pool[i].active == false) {
 b76:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 b7a:	11484783          	lbu	a5,276(a6)
bool register_isr_abs(uint64_t offset, void *cb) {
 b7e:	1101                	addi	sp,sp,-32
 b80:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 b82:	cbd5                	beqz	a5,c36 <register_isr_abs+0xcc>
 b84:	12c80793          	addi	a5,a6,300
  int i = 0;
 b88:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 b8a:	0007c683          	lbu	a3,0(a5)
 b8e:	07e1                	addi	a5,a5,24
      i++;
 b90:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 b92:	fee5                	bnez	a3,b8a <register_isr_abs+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 b94:	00171793          	slli	a5,a4,0x1
 b98:	00e786b3          	add	a3,a5,a4
 b9c:	068e                	slli	a3,a3,0x3
 b9e:	10080313          	addi	t1,a6,256
 ba2:	9336                	add	t1,t1,a3
  uint32_t lo = *TIMER_COMP_PART1;
 ba4:	20000e37          	lui	t3,0x20000
 ba8:	008e2683          	lw	a3,8(t3) # 20000008 <_stack_top+0xfff0008>
  uint32_t hi = *TIMER_COMP_PART2;
 bac:	00ce2f83          	lw	t6,12(t3)
  timer_pool[i].expires_at = read_time() + offset;
 bb0:	97ba                	add	a5,a5,a4
 bb2:	00a68733          	add	a4,a3,a0
  timer_pool[i].active = true;
 bb6:	4285                	li	t0,1
  timer_pool[i].expires_at = read_time() + offset;
 bb8:	00bf8533          	add	a0,t6,a1
 bbc:	00d736b3          	sltu	a3,a4,a3
  timer_heap[num_timers - 1] = &timer_pool[i];
 bc0:	00289593          	slli	a1,a7,0x2
  timer_pool[i].expires_at = read_time() + offset;
 bc4:	078e                	slli	a5,a5,0x3
 bc6:	97c2                	add	a5,a5,a6
 bc8:	96aa                	add	a3,a3,a0
  timer_heap[num_timers - 1] = &timer_pool[i];
 bca:	95c2                	add	a1,a1,a6
  num_timers++;
 bcc:	00588fb3          	add	t6,a7,t0
  sift_up(num_timers - 1);
 bd0:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + offset;
 bd2:	10d7a223          	sw	a3,260(a5)
 bd6:	10e7a023          	sw	a4,256(a5)
  timer_pool[i].period = 0;
 bda:	1007a423          	sw	zero,264(a5)
 bde:	1007a623          	sw	zero,268(a5)
  timer_pool[i].callback_function = cb;
 be2:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 be6:	10578a23          	sb	t0,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 bea:	0065a023          	sw	t1,0(a1)
 bee:	c61a                	sw	t1,12(sp)
  num_timers++;
 bf0:	81f1a623          	sw	t6,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 bf4:	31d5                	jal	8d8 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 bf6:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 bfa:	4332                	lw	t1,12(sp)
 bfc:	20000eb7          	lui	t4,0x20000
 c00:	20000e37          	lui	t3,0x20000
 c04:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 c06:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 c08:	00678663          	beq	a5,t1,c14 <register_isr_abs+0xaa>
}
 c0c:	40f2                	lw	ra,28(sp)
  return true;
 c0e:	4505                	li	a0,1
}
 c10:	6105                	addi	sp,sp,32
 c12:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 c14:	00432703          	lw	a4,4(t1)
 c18:	00032783          	lw	a5,0(t1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 c1c:	56fd                	li	a3,-1
 c1e:	00de2023          	sw	a3,0(t3)
}
 c22:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 c24:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 c28:	00fe2023          	sw	a5,0(t3)
  return true;
 c2c:	4505                	li	a0,1
}
 c2e:	6105                	addi	sp,sp,32
 c30:	8082                	ret
    return false;
 c32:	4501                	li	a0,0
}
 c34:	8082                	ret
    if (timer_pool[i].active == false) {
 c36:	10080313          	addi	t1,a6,256
  int i = 0;
 c3a:	4701                	li	a4,0
 c3c:	b7a5                	j	ba4 <register_isr_abs+0x3a>

00000c3e <deactivate_timer>:
  if (timer == NULL || !timer->active) {
 c3e:	c509                	beqz	a0,c48 <deactivate_timer+0xa>
 c40:	01454783          	lbu	a5,20(a0)
 c44:	c391                	beqz	a5,c48 <deactivate_timer+0xa>
  timer->active = false;
 c46:	b9cd                	j	938 <_deactivate_timer.part.0>
}
 c48:	4501                	li	a0,0
 c4a:	8082                	ret

00000c4c <_deactivate_timer>:
  if (timer == NULL || !timer->active) {
 c4c:	c509                	beqz	a0,c56 <_deactivate_timer+0xa>
 c4e:	01454783          	lbu	a5,20(a0)
 c52:	c391                	beqz	a5,c56 <_deactivate_timer+0xa>
  timer->active = false;
 c54:	b1d5                	j	938 <_deactivate_timer.part.0>
}
 c56:	4501                	li	a0,0
 c58:	8082                	ret

00000c5a <uart_isr>:
ring_buffer_t rx_buffer;
ring_buffer_t tx_buffer;

// Define the Interrupt Service Routine
void uart_isr(void) {
  uint32_t irq_status = *UART_IRQ_STATUS;
 c5a:	200027b7          	lui	a5,0x20002
 c5e:	07d1                	addi	a5,a5,20 # 20002014 <_stack_top+0xfff2014>
 c60:	439c                	lw	a5,0(a5)
void uart_isr(void) {
 c62:	7179                	addi	sp,sp,-48
 c64:	d606                	sw	ra,44(sp)

  // Handle Incoming Data
  if (irq_status & IRQ_RX_AVAIL) {
 c66:	0017f713          	andi	a4,a5,1
 c6a:	e705                	bnez	a4,c92 <uart_isr+0x38>
    char c = (char)(*UART_RX_FIFO);
    insert_rb(&rx_buffer, c); // Push to RX buffer
  }

  // Handle Outgoing Data
  if ((irq_status & IRQ_TX_EMPTY) && (*UART_IRQ_EN & IRQ_TX_EMPTY)) {
 c6c:	0027f713          	andi	a4,a5,2
 c70:	c711                	beqz	a4,c7c <uart_isr+0x22>
 c72:	20002737          	lui	a4,0x20002
 c76:	4b14                	lw	a3,16(a4)
 c78:	8a89                	andi	a3,a3,2
 c7a:	e69d                	bnez	a3,ca8 <uart_isr+0x4e>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
    }
  }

  // Handle Hardware Errors
  if (irq_status & (IRQ_RX_OVERRUN | IRQ_FRAME_ERROR)) {
 c7c:	8bb1                	andi	a5,a5,12
 c7e:	c799                	beqz	a5,c8c <uart_isr+0x32>
    *UART_CTRL |= CTRL_CLR_ERRORS; // Clear the hardware error states
 c80:	200027b7          	lui	a5,0x20002
 c84:	47d8                	lw	a4,12(a5)
 c86:	00476713          	ori	a4,a4,4
 c8a:	c7d8                	sw	a4,12(a5)
  }
}
 c8c:	50b2                	lw	ra,44(sp)
 c8e:	6145                	addi	sp,sp,48
 c90:	8082                	ret
    char c = (char)(*UART_RX_FIFO);
 c92:	200026b7          	lui	a3,0x20002
 c96:	428c                	lw	a1,0(a3)
    insert_rb(&rx_buffer, c); // Push to RX buffer
 c98:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 c9c:	0ff5f593          	zext.b	a1,a1
 ca0:	c63e                	sw	a5,12(sp)
 ca2:	34c1                	jal	762 <insert_rb>
 ca4:	47b2                	lw	a5,12(sp)
 ca6:	b7d9                	j	c6c <uart_isr+0x12>
    if (pop_rb(&tx_buffer, &c)) {
 ca8:	03418513          	addi	a0,gp,52 # 10000874 <tx_buffer>
 cac:	01f10593          	addi	a1,sp,31
 cb0:	c63e                	sw	a5,12(sp)
 cb2:	3cd9                	jal	788 <pop_rb>
 cb4:	20002737          	lui	a4,0x20002
 cb8:	47b2                	lw	a5,12(sp)
 cba:	0741                	addi	a4,a4,16 # 20002010 <_stack_top+0xfff2010>
 cbc:	c519                	beqz	a0,cca <uart_isr+0x70>
      *UART_TX_FIFO = (uint32_t)c;
 cbe:	01f14683          	lbu	a3,31(sp)
 cc2:	20002737          	lui	a4,0x20002
 cc6:	c354                	sw	a3,4(a4)
 cc8:	bf55                	j	c7c <uart_isr+0x22>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 cca:	4314                	lw	a3,0(a4)
 ccc:	9af5                	andi	a3,a3,-3
 cce:	c314                	sw	a3,0(a4)
 cd0:	b775                	j	c7c <uart_isr+0x22>

00000cd2 <uart_init>:

// Initialization function (Call this in main!)
void uart_init(void) {
 cd2:	1141                	addi	sp,sp,-16
  init_ring_buffer(&rx_buffer);
 cd4:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
void uart_init(void) {
 cd8:	c606                	sw	ra,12(sp)
  init_ring_buffer(&rx_buffer);
 cda:	3c95                	jal	74e <init_ring_buffer>
  init_ring_buffer(&tx_buffer);
 cdc:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 ce0:	10450513          	addi	a0,a0,260
 ce4:	34ad                	jal	74e <init_ring_buffer>

  // Register ISR with the MINA PLIC at priority 1
  reg_UART_irq(uart_isr, 1);
 ce6:	4605                	li	a2,1
 ce8:	6505                	lui	a0,0x1
 cea:	85b2                	mv	a1,a2
 cec:	c5a50513          	addi	a0,a0,-934 # c5a <uart_isr>
 cf0:	4681                	li	a3,0
 cf2:	3425                	jal	71a <reg_irq_handler>

  // Enable the RX interrupt permanently so we never miss incoming data
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 cf4:	200027b7          	lui	a5,0x20002
 cf8:	4b98                	lw	a4,16(a5)
}
 cfa:	40b2                	lw	ra,12(sp)
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 cfc:	00176713          	ori	a4,a4,1
 d00:	cb98                	sw	a4,16(a5)
}
 d02:	0141                	addi	sp,sp,16
 d04:	8082                	ret

00000d06 <uart_putc>:

void uart_putc(char c) {
  // 1. Temporarily disable TX interrupts to check state safely
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 d06:	200027b7          	lui	a5,0x20002
 d0a:	4b94                	lw	a3,16(a5)

  // 2. If the software buffer is empty AND the hardware TX FIFO is empty,
  // bypass the software buffer to kickstart the hardware transmission.
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 d0c:	f3018713          	addi	a4,gp,-208 # 10000770 <rx_buffer>
 d10:	20474583          	lbu	a1,516(a4) # 20002204 <_stack_top+0xfff2204>
 d14:	20574603          	lbu	a2,517(a4)
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 d18:	ffd6f713          	andi	a4,a3,-3
 d1c:	cb98                	sw	a4,16(a5)
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 d1e:	04c58263          	beq	a1,a2,d62 <uart_putc+0x5c>
void uart_putc(char c) {
 d22:	1141                	addi	sp,sp,-16
 d24:	c422                	sw	s0,8(sp)
 d26:	c04a                	sw	s2,0(sp)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
  } else {
    // Try to insert while TX IRQ is masked; if the 256-byte buffer is full,
    // re-enable IRQ_TX_EMPTY while waiting so uart_isr() can drain it!
    while (!insert_rb(&tx_buffer, c)) {
      *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d28:	20002437          	lui	s0,0x20002
void uart_putc(char c) {
 d2c:	c226                	sw	s1,4(sp)
 d2e:	c606                	sw	ra,12(sp)
 d30:	84aa                	mv	s1,a0
 d32:	03418913          	addi	s2,gp,52 # 10000874 <tx_buffer>
      *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d36:	0441                	addi	s0,s0,16 # 20002010 <_stack_top+0xfff2010>
 d38:	a029                	j	d42 <uart_putc+0x3c>
 d3a:	401c                	lw	a5,0(s0)
 d3c:	0027e793          	ori	a5,a5,2
 d40:	c01c                	sw	a5,0(s0)
    while (!insert_rb(&tx_buffer, c)) {
 d42:	85a6                	mv	a1,s1
 d44:	854a                	mv	a0,s2
 d46:	3c31                	jal	762 <insert_rb>
 d48:	d96d                	beqz	a0,d3a <uart_putc+0x34>
    }
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d4a:	200027b7          	lui	a5,0x20002
 d4e:	4b98                	lw	a4,16(a5)
  }
}
 d50:	40b2                	lw	ra,12(sp)
 d52:	4422                	lw	s0,8(sp)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d54:	00276713          	ori	a4,a4,2
 d58:	cb98                	sw	a4,16(a5)
}
 d5a:	4492                	lw	s1,4(sp)
 d5c:	4902                	lw	s2,0(sp)
 d5e:	0141                	addi	sp,sp,16
 d60:	8082                	ret
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 d62:	20002737          	lui	a4,0x20002
 d66:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 d68:	4318                	lw	a4,0(a4)
 d6a:	8b11                	andi	a4,a4,4
 d6c:	db5d                	beqz	a4,d22 <uart_putc+0x1c>
    *UART_TX_FIFO = (uint32_t)c;
 d6e:	20002737          	lui	a4,0x20002
 d72:	c348                	sw	a0,4(a4)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d74:	4b98                	lw	a4,16(a5)
 d76:	00276713          	ori	a4,a4,2
 d7a:	cb98                	sw	a4,16(a5)
 d7c:	8082                	ret

00000d7e <uart_getc>:

char uart_getc(void) {
 d7e:	1101                	addi	sp,sp,-32
 d80:	cc22                	sw	s0,24(sp)
 d82:	ce06                	sw	ra,28(sp)
 d84:	f3018413          	addi	s0,gp,-208 # 10000770 <rx_buffer>
  char c;
  // Block only when the software buffer is completely empty
  while (!pop_rb(&rx_buffer, &c)) {
 d88:	00f10593          	addi	a1,sp,15
 d8c:	8522                	mv	a0,s0
 d8e:	3aed                	jal	788 <pop_rb>
 d90:	dd65                	beqz	a0,d88 <uart_getc+0xa>
    // Busy wait until the ISR receives new data
  }
  return c;
}
 d92:	40f2                	lw	ra,28(sp)
 d94:	4462                	lw	s0,24(sp)
 d96:	00f14503          	lbu	a0,15(sp)
 d9a:	6105                	addi	sp,sp,32
 d9c:	8082                	ret

00000d9e <uart_puts>:

void uart_puts(const char *str) {
 d9e:	1141                	addi	sp,sp,-16
 da0:	c422                	sw	s0,8(sp)
 da2:	c606                	sw	ra,12(sp)
 da4:	842a                	mv	s0,a0
  while (*str != '\0') {
 da6:	00054503          	lbu	a0,0(a0)
 daa:	c511                	beqz	a0,db6 <uart_puts+0x18>
    uart_putc(*str);
 dac:	3fa9                	jal	d06 <uart_putc>
  while (*str != '\0') {
 dae:	00144503          	lbu	a0,1(s0)
    str++;
 db2:	0405                	addi	s0,s0,1
  while (*str != '\0') {
 db4:	fd65                	bnez	a0,dac <uart_puts+0xe>
  }
}
 db6:	40b2                	lw	ra,12(sp)
 db8:	4422                	lw	s0,8(sp)
 dba:	0141                	addi	sp,sp,16
 dbc:	8082                	ret

00000dbe <uart_polled_putc>:

void uart_polled_putc(char c) {
  // Wait directly on the hardware status register until TX FIFO is empty
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dbe:	20002737          	lui	a4,0x20002
 dc2:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 dc4:	431c                	lw	a5,0(a4)
 dc6:	8b91                	andi	a5,a5,4
 dc8:	dff5                	beqz	a5,dc4 <uart_polled_putc+0x6>
    ;
  *UART_TX_FIFO = (uint32_t)c;
 dca:	200027b7          	lui	a5,0x20002
 dce:	c3c8                	sw	a0,4(a5)
}
 dd0:	8082                	ret

00000dd2 <uart_polled_puts>:

void uart_polled_puts(const char *str) {
  while (*str != '\0') {
 dd2:	00054683          	lbu	a3,0(a0)
 dd6:	ce99                	beqz	a3,df4 <uart_polled_puts+0x22>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dd8:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 ddc:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 de0:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 de2:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 de4:	431c                	lw	a5,0(a4)
 de6:	8b91                	andi	a5,a5,4
 de8:	dff5                	beqz	a5,de4 <uart_polled_puts+0x12>
  *UART_TX_FIFO = (uint32_t)c;
 dea:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 dec:	00154683          	lbu	a3,1(a0)
    uart_polled_putc(*str);
    str++;
 df0:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 df2:	faed                	bnez	a3,de4 <uart_polled_puts+0x12>
  }
}
 df4:	8082                	ret

00000df6 <uart_print_hex>:
  while (*str != '\0') {
 df6:	00054683          	lbu	a3,0(a0)

void uart_print_hex(const char *prefix, uint32_t val) {
 dfa:	1141                	addi	sp,sp,-16
  while (*str != '\0') {
 dfc:	ce99                	beqz	a3,e1a <uart_print_hex+0x24>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dfe:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 e02:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e06:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 e08:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e0a:	431c                	lw	a5,0(a4)
 e0c:	8b91                	andi	a5,a5,4
 e0e:	dff5                	beqz	a5,e0a <uart_print_hex+0x14>
  *UART_TX_FIFO = (uint32_t)c;
 e10:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 e12:	00154683          	lbu	a3,1(a0)
    str++;
 e16:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 e18:	faed                	bnez	a3,e0a <uart_print_hex+0x14>
  uart_polled_puts(prefix);
  char buf[9];
  buf[8] = '\0';
 e1a:	00010623          	sb	zero,12(sp)
  for (int i = 7; i >= 0; i--) {
 e1e:	005c                	addi	a5,sp,4
 e20:	ffc10513          	addi	a0,sp,-4
    uint32_t nibble = val & 0xF;
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 e24:	4625                	li	a2,9
    uint32_t nibble = val & 0xF;
 e26:	00f5f713          	andi	a4,a1,15
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 e2a:	05770693          	addi	a3,a4,87
 e2e:	00e66463          	bltu	a2,a4,e36 <uart_print_hex+0x40>
 e32:	03070693          	addi	a3,a4,48
 e36:	00d783a3          	sb	a3,7(a5) # 20002007 <_stack_top+0xfff2007>
  for (int i = 7; i >= 0; i--) {
 e3a:	17fd                	addi	a5,a5,-1
    val >>= 4;
 e3c:	8191                	srli	a1,a1,0x4
  for (int i = 7; i >= 0; i--) {
 e3e:	fef514e3          	bne	a0,a5,e26 <uart_print_hex+0x30>
  while (*str != '\0') {
 e42:	00414683          	lbu	a3,4(sp)
 e46:	c285                	beqz	a3,e66 <uart_print_hex+0x70>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e48:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 e4c:	200025b7          	lui	a1,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e50:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 e52:	0591                	addi	a1,a1,4 # 20002004 <_stack_top+0xfff2004>
  while (*str != '\0') {
 e54:	0050                	addi	a2,sp,4
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e56:	431c                	lw	a5,0(a4)
 e58:	8b91                	andi	a5,a5,4
 e5a:	dff5                	beqz	a5,e56 <uart_print_hex+0x60>
  *UART_TX_FIFO = (uint32_t)c;
 e5c:	c194                	sw	a3,0(a1)
  while (*str != '\0') {
 e5e:	00164683          	lbu	a3,1(a2)
    str++;
 e62:	0605                	addi	a2,a2,1
  while (*str != '\0') {
 e64:	faed                	bnez	a3,e56 <uart_print_hex+0x60>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e66:	20002737          	lui	a4,0x20002
 e6a:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 e6c:	431c                	lw	a5,0(a4)
 e6e:	8b91                	andi	a5,a5,4
 e70:	dff5                	beqz	a5,e6c <uart_print_hex+0x76>
  *UART_TX_FIFO = (uint32_t)c;
 e72:	200027b7          	lui	a5,0x20002
 e76:	46b5                	li	a3,13
 e78:	c3d4                	sw	a3,4(a5)
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e7a:	00878713          	addi	a4,a5,8 # 20002008 <_stack_top+0xfff2008>
 e7e:	431c                	lw	a5,0(a4)
 e80:	8b91                	andi	a5,a5,4
 e82:	dff5                	beqz	a5,e7e <uart_print_hex+0x88>
  *UART_TX_FIFO = (uint32_t)c;
 e84:	200027b7          	lui	a5,0x20002
 e88:	4729                	li	a4,10
 e8a:	c3d8                	sw	a4,4(a5)
  }
  uart_polled_puts(buf);
  uart_polled_puts("\r\n");
}
 e8c:	0141                	addi	sp,sp,16
 e8e:	8082                	ret
