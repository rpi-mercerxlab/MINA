
/tmp/mina_build_nHBaSU/firmware.elf:     file format elf32-littleriscv


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
  18:	f7c50513          	addi	a0,a0,-132 # f90 <_data_load_start>
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
  68:	204d                	jal	10a <main>

0000006a <inf_loop>:

    /* 7. Catch return from main (should not happen in bare-metal) */
inf_loop:
    j inf_loop
  6a:	a001                	j	6a <inf_loop>

0000006c <fill_matrix>:

static void fill_matrix(void) {
  volatile uint32_t *dst =
      NPU_SCRATCHPAD_BASE + (NPU_SOURCE_OFFSET / sizeof(uint32_t));

  uint8_t base = simple_counter;
  6c:	10000eb7          	lui	t4,0x10000
  70:	044ece03          	lbu	t3,68(t4) # 10000044 <simple_counter>
  74:	40300537          	lui	a0,0x40300
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
  78:	40300337          	lui	t1,0x40300
  7c:	004e0593          	addi	a1,t3,4
  uint8_t base = simple_counter;
  80:	20050513          	addi	a0,a0,512 # 40300200 <_stack_top+0x302f0200>
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
  84:	24030313          	addi	t1,t1,576 # 40300240 <_stack_top+0x302f0240>
    for (uint32_t half = 0; half < 2u; ++half) {
      uint32_t packed = 0;
      for (uint32_t lane = 0; lane < 4u; ++lane) {
  88:	4891                	li	a7,4
        uint32_t col = half * 4u + lane;
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  8a:	ffc58813          	addi	a6,a1,-4
      for (uint32_t lane = 0; lane < 4u; ++lane) {
  8e:	4701                	li	a4,0
      uint32_t packed = 0;
  90:	4681                	li	a3,0
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  92:	00e807b3          	add	a5,a6,a4
        packed |= ((uint32_t)val << (8u * lane));
  96:	00371613          	slli	a2,a4,0x3
  9a:	07f7f793          	andi	a5,a5,127
  9e:	00c797b3          	sll	a5,a5,a2
      for (uint32_t lane = 0; lane < 4u; ++lane) {
  a2:	0705                	addi	a4,a4,1
        packed |= ((uint32_t)val << (8u * lane));
  a4:	8edd                	or	a3,a3,a5
      for (uint32_t lane = 0; lane < 4u; ++lane) {
  a6:	ff1716e3          	bne	a4,a7,92 <fill_matrix+0x26>
      }
      dst[row * 2u + half] = packed;
  aa:	c114                	sw	a3,0(a0)
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  ac:	00158793          	addi	a5,a1,1
  b0:	00258693          	addi	a3,a1,2
        packed |= ((uint32_t)val << (8u * lane));
  b4:	07f7f793          	andi	a5,a5,127
  b8:	07f6f693          	andi	a3,a3,127
  bc:	06c2                	slli	a3,a3,0x10
        uint8_t val = (uint8_t)((base + row * MATRIX_DIM + col) & 0x7Fu);
  be:	00358713          	addi	a4,a1,3
        packed |= ((uint32_t)val << (8u * lane));
  c2:	07a2                	slli	a5,a5,0x8
  c4:	8fd5                	or	a5,a5,a3
  c6:	07f77713          	andi	a4,a4,127
  ca:	07f5f693          	andi	a3,a1,127
  ce:	8fd5                	or	a5,a5,a3
  d0:	0762                	slli	a4,a4,0x18
  d2:	8fd9                	or	a5,a5,a4
      dst[row * 2u + half] = packed;
  d4:	c15c                	sw	a5,4(a0)
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
  d6:	0521                	addi	a0,a0,8
  d8:	05a1                	addi	a1,a1,8
  da:	fa6518e3          	bne	a0,t1,8a <fill_matrix+0x1e>
    }
  }
  simple_counter = (uint8_t)((simple_counter + 64u) & 0x7Fu);
  de:	040e0793          	addi	a5,t3,64
  e2:	07f7f793          	andi	a5,a5,127
  e6:	04fe8223          	sb	a5,68(t4)
}
  ea:	8082                	ret

000000ec <npu_irq_handler>:
  }
}

void npu_irq_handler(void) {
  // 1. Stop the NPU and clear the interrupt pulse immediately
  NPU_HALT();
  ec:	40000737          	lui	a4,0x40000
  f0:	00072023          	sw	zero,0(a4) # 40000000 <_stack_top+0x2fff0000>
  NPU_CLEAR_IRQ();
  f4:	431c                	lw	a5,0(a4)

  // 2. Signal main() to read the scratchpad and print over UART
  npu_done_flag = 1;
  f6:	4605                	li	a2,1
  f8:	100006b7          	lui	a3,0x10000
  NPU_CLEAR_IRQ();
  fc:	8ff1                	and	a5,a5,a2
  fe:	0087e793          	ori	a5,a5,8
 102:	c31c                	sw	a5,0(a4)
  npu_done_flag = 1;
 104:	04c6a023          	sw	a2,64(a3) # 10000040 <npu_done_flag>
}
 108:	8082                	ret

0000010a <main>:

int main(void) {
 10a:	715d                	addi	sp,sp,-80
 10c:	c4a2                	sw	s0,72(sp)
 10e:	c686                	sw	ra,76(sp)
  // 1. Put NPU in a known halted/reset state and clear any stale IRQ
  //    BEFORE enabling interrupts in the CPU or PLIC
  NPU_HALT();
 110:	40000437          	lui	s0,0x40000
int main(void) {
 114:	c2a6                	sw	s1,68(sp)
 116:	c0ca                	sw	s2,64(sp)
 118:	de4e                	sw	s3,60(sp)
 11a:	dc52                	sw	s4,56(sp)
 11c:	da56                	sw	s5,52(sp)
 11e:	d85a                	sw	s6,48(sp)
 120:	d65e                	sw	s7,44(sp)
 122:	d462                	sw	s8,40(sp)
 124:	d266                	sw	s9,36(sp)
 126:	d06a                	sw	s10,32(sp)
 128:	ce6e                	sw	s11,28(sp)
  NPU_HALT();
 12a:	00042023          	sw	zero,0(s0) # 40000000 <_stack_top+0x2fff0000>
  NPU_RESET();
 12e:	4789                	li	a5,2
 130:	c01c                	sw	a5,0(s0)
  NPU_CLEAR_IRQ();
 132:	401c                	lw	a5,0(s0)
  while (!NPU_IS_HALTED()) {
 134:	00440713          	addi	a4,s0,4
  NPU_CLEAR_IRQ();
 138:	8b85                	andi	a5,a5,1
 13a:	0087e793          	ori	a5,a5,8
 13e:	c01c                	sw	a5,0(s0)
  NPU_HALT();
 140:	00042023          	sw	zero,0(s0)
  while (!NPU_IS_HALTED()) {
 144:	431c                	lw	a5,0(a4)
 146:	8b85                	andi	a5,a5,1
 148:	dff5                	beqz	a5,144 <main+0x3a>
  npu_wait_halted();

  // 2. Initialize CPU interrupts and UART driver
  init_interrupts();
 14a:	22fd                	jal	338 <init_interrupts>
  uart_init();
 14c:	377000ef          	jal	cc2 <uart_init>

  uart_puts("About to register NPU interrupt\r\n");
 150:	6505                	lui	a0,0x1
 152:	e8050513          	addi	a0,a0,-384 # e80 <uart_print_hex+0x9a>
 156:	439000ef          	jal	d8e <uart_puts>

  reg_NPU_irq(npu_irq_handler, 1);
 15a:	4691                	li	a3,4
 15c:	4641                	li	a2,16
 15e:	4585                	li	a1,1
 160:	0ec00513          	li	a0,236
 164:	235d                	jal	70a <reg_irq_handler>

  uart_puts("Starting program, loaded interrupts\r\n");
 166:	6505                	lui	a0,0x1
 168:	ea450513          	addi	a0,a0,-348 # ea4 <uart_print_hex+0xbe>
 16c:	423000ef          	jal	d8e <uart_puts>

  // 3. Load initial Matrix A into Scratchpad at offset 0x200
  fill_matrix();
 170:	3df5                	jal	6c <fill_matrix>

  // 4. Start NPU execution from PC = 0
  NPU_START();
 172:	4785                	li	a5,1
 174:	c01c                	sw	a5,0(s0)
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 176:	ccccd437          	lui	s0,0xccccd
 17a:	ccd40413          	addi	s0,s0,-819 # cccccccd <_stack_top+0xbccbcccd>
 17e:	10000cb7          	lui	s9,0x10000
 182:	4ba5                	li	s7,9
int main(void) {
 184:	05f5ec37          	lui	s8,0x5f5e
 188:	100c0c13          	addi	s8,s8,256 # 5f5e100 <_data_load_start+0x5f5d170>
 18c:	a021                	j	194 <main+0x8a>
      npu_wait_halted();
      NPU_START();
    }

    counter++;
    if (counter == 100000000) {
 18e:	1c7d                	addi	s8,s8,-1
 190:	0e0c0f63          	beqz	s8,28e <main+0x184>
    if (npu_done_flag) {
 194:	040ca783          	lw	a5,64(s9) # 10000040 <npu_done_flag>
 198:	dbfd                	beqz	a5,18e <main+0x84>
  NPU_HALT();
 19a:	400007b7          	lui	a5,0x40000
      npu_done_flag = 0;
 19e:	040ca023          	sw	zero,64(s9)
  NPU_HALT();
 1a2:	0007a023          	sw	zero,0(a5) # 40000000 <_stack_top+0x2fff0000>
  while (!NPU_IS_HALTED()) {
 1a6:	00478713          	addi	a4,a5,4
 1aa:	431c                	lw	a5,0(a4)
 1ac:	8b85                	andi	a5,a5,1
 1ae:	dff5                	beqz	a5,1aa <main+0xa0>
 1b0:	40300ab7          	lui	s5,0x40300
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1b4:	51eb8b37          	lui	s6,0x51eb8
  while (!NPU_IS_HALTED()) {
 1b8:	408a8a93          	addi	s5,s5,1032 # 40300408 <_stack_top+0x302f0408>
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1bc:	51fb0b13          	addi	s6,s6,1311 # 51eb851f <_stack_top+0x41ea851f>
    for (uint32_t word = 0; word < 2u; ++word) {
 1c0:	ff8a8493          	addi	s1,s5,-8
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1c4:	06300a13          	li	s4,99
      uint32_t packed = src[row * 2u + word];
 1c8:	0004a983          	lw	s3,0(s1)
 1cc:	4d81                	li	s11,0
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1ce:	02000913          	li	s2,32
        uint8_t value = (uint8_t)(packed >> (8u * lane));
 1d2:	01b9d7b3          	srl	a5,s3,s11
 1d6:	0ff7fd13          	zext.b	s10,a5
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 1da:	02000513          	li	a0,32
 1de:	11aa7763          	bgeu	s4,s10,2ec <main+0x1e2>
 1e2:	036d3533          	mulhu	a0,s10,s6
 1e6:	8115                	srli	a0,a0,0x5
 1e8:	03050513          	addi	a0,a0,48
 1ec:	30b000ef          	jal	cf6 <uart_putc>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 1f0:	028d3533          	mulhu	a0,s10,s0
 1f4:	810d                	srli	a0,a0,0x3
 1f6:	028536b3          	mulhu	a3,a0,s0
 1fa:	828d                	srli	a3,a3,0x3
 1fc:	00269713          	slli	a4,a3,0x2
 200:	9736                	add	a4,a4,a3
 202:	0706                	slli	a4,a4,0x1
 204:	8d19                	sub	a0,a0,a4
 206:	03050513          	addi	a0,a0,48
 20a:	0ff57513          	zext.b	a0,a0
 20e:	2e9000ef          	jal	cf6 <uart_putc>
  uart_putc('0' + value % 10);
 212:	028d36b3          	mulhu	a3,s10,s0
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 216:	0da1                	addi	s11,s11,8
  uart_putc('0' + value % 10);
 218:	828d                	srli	a3,a3,0x3
 21a:	00269713          	slli	a4,a3,0x2
 21e:	9736                	add	a4,a4,a3
 220:	0706                	slli	a4,a4,0x1
 222:	40ed0533          	sub	a0,s10,a4
 226:	03050513          	addi	a0,a0,48
 22a:	0ff57513          	zext.b	a0,a0
 22e:	2c9000ef          	jal	cf6 <uart_putc>
        uart_putc(' ');
 232:	02000513          	li	a0,32
 236:	2c1000ef          	jal	cf6 <uart_putc>
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 23a:	f92d9ce3          	bne	s11,s2,1d2 <main+0xc8>
    for (uint32_t word = 0; word < 2u; ++word) {
 23e:	0491                	addi	s1,s1,4
 240:	f95494e3          	bne	s1,s5,1c8 <main+0xbe>
    uart_putc('\r');
 244:	4535                	li	a0,13
 246:	2b1000ef          	jal	cf6 <uart_putc>
    uart_putc('\n');
 24a:	4529                	li	a0,10
 24c:	2ab000ef          	jal	cf6 <uart_putc>
  for (uint32_t row = 0; row < MATRIX_DIM; ++row) {
 250:	403007b7          	lui	a5,0x40300
 254:	00848a93          	addi	s5,s1,8
 258:	44878793          	addi	a5,a5,1096 # 40300448 <_stack_top+0x302f0448>
 25c:	f6fa92e3          	bne	s5,a5,1c0 <main+0xb6>
  uart_putc('\r');
 260:	4535                	li	a0,13
 262:	295000ef          	jal	cf6 <uart_putc>
  uart_putc('\n');
 266:	4529                	li	a0,10
 268:	28f000ef          	jal	cf6 <uart_putc>
      fill_matrix();
 26c:	3501                	jal	6c <fill_matrix>
      NPU_RESET();
 26e:	400006b7          	lui	a3,0x40000
 272:	4789                	li	a5,2
 274:	c29c                	sw	a5,0(a3)
  NPU_HALT();
 276:	0006a023          	sw	zero,0(a3) # 40000000 <_stack_top+0x2fff0000>
  while (!NPU_IS_HALTED()) {
 27a:	00468713          	addi	a4,a3,4
 27e:	431c                	lw	a5,0(a4)
 280:	8b85                	andi	a5,a5,1
 282:	dff5                	beqz	a5,27e <main+0x174>
      NPU_START();
 284:	4785                	li	a5,1
 286:	c29c                	sw	a5,0(a3)
    if (counter == 100000000) {
 288:	1c7d                	addi	s8,s8,-1
 28a:	f00c15e3          	bnez	s8,194 <main+0x8a>
      uart_puts("Program counter, NPU: ");
 28e:	6785                	lui	a5,0x1
 290:	ecc78513          	addi	a0,a5,-308 # ecc <uart_print_hex+0xe6>
 294:	2fb000ef          	jal	d8e <uart_puts>
      uart_print_u32(NPU_READ_PC());
 298:	400007b7          	lui	a5,0x40000
 29c:	07a1                	addi	a5,a5,8 # 40000008 <_stack_top+0x2fff0008>
 29e:	439c                	lw	a5,0(a5)
  int i = 0;
 2a0:	4601                	li	a2,0
      uart_print_u32(NPU_READ_PC());
 2a2:	3ff7f793          	andi	a5,a5,1023
  if (val == 0) {
 2a6:	cbb1                	beqz	a5,2fa <main+0x1f0>
    buf[i++] = '0' + (val % 10);
 2a8:	0287b733          	mulhu	a4,a5,s0
 2ac:	0054                	addi	a3,sp,4
 2ae:	0605                	addi	a2,a2,1
 2b0:	00c684b3          	add	s1,a3,a2
 2b4:	85be                	mv	a1,a5
 2b6:	830d                	srli	a4,a4,0x3
 2b8:	00271693          	slli	a3,a4,0x2
 2bc:	96ba                	add	a3,a3,a4
 2be:	0686                	slli	a3,a3,0x1
 2c0:	8f95                	sub	a5,a5,a3
 2c2:	03078793          	addi	a5,a5,48
 2c6:	fef48fa3          	sb	a5,-1(s1)
    val /= 10;
 2ca:	87ba                	mv	a5,a4
  while (val > 0) {
 2cc:	fcbbeee3          	bltu	s7,a1,2a8 <main+0x19e>
    uart_putc(buf[--i]);
 2d0:	fff4c503          	lbu	a0,-1(s1)
  while (i > 0) {
 2d4:	14fd                	addi	s1,s1,-1
    uart_putc(buf[--i]);
 2d6:	221000ef          	jal	cf6 <uart_putc>
  while (i > 0) {
 2da:	005c                	addi	a5,sp,4
 2dc:	fe979ae3          	bne	a5,s1,2d0 <main+0x1c6>
      uart_puts("\r\n");
 2e0:	6785                	lui	a5,0x1
 2e2:	ee478513          	addi	a0,a5,-284 # ee4 <uart_print_hex+0xfe>
 2e6:	2a9000ef          	jal	d8e <uart_puts>
      counter = 0;
 2ea:	bd69                	j	184 <main+0x7a>
  uart_putc(value >= 100 ? '0' + value / 100 : ' ');
 2ec:	20b000ef          	jal	cf6 <uart_putc>
  uart_putc(value >= 10 ? '0' + (value / 10) % 10 : ' ');
 2f0:	02000513          	li	a0,32
 2f4:	f1abfde3          	bgeu	s7,s10,20e <main+0x104>
 2f8:	bde5                	j	1f0 <main+0xe6>
    uart_putc('0');
 2fa:	03000513          	li	a0,48
 2fe:	1f9000ef          	jal	cf6 <uart_putc>
      uart_puts("\r\n");
 302:	6785                	lui	a5,0x1
 304:	ee478513          	addi	a0,a5,-284 # ee4 <uart_print_hex+0xfe>
 308:	287000ef          	jal	d8e <uart_puts>
      counter = 0;
 30c:	bda5                	j	184 <main+0x7a>

0000030e <set_input>:
#include "../include/gpio.h"

void set_input(int gpio_num) { *GPIO_T |= (1 << gpio_num); }
 30e:	20003737          	lui	a4,0x20003
 312:	4354                	lw	a3,4(a4)
 314:	4785                	li	a5,1
 316:	00a797b3          	sll	a5,a5,a0
 31a:	8fd5                	or	a5,a5,a3
 31c:	c35c                	sw	a5,4(a4)
 31e:	8082                	ret

00000320 <set_output>:
void set_output(int gpio_num) { *GPIO_T &= ~(1 << gpio_num); }
 320:	20003737          	lui	a4,0x20003
 324:	4354                	lw	a3,4(a4)
 326:	4785                	li	a5,1
 328:	00a797b3          	sll	a5,a5,a0
 32c:	fff7c793          	not	a5,a5
 330:	8ff5                	and	a5,a5,a3
 332:	c35c                	sw	a5,4(a4)
 334:	8082                	ret
	...

00000338 <init_interrupts>:
int plic_idx_sort[8] = {0, 1, 2, 3, 4, 5, 6, 7};
void (*timer_irq_handler)(void) = NULL;

void init_interrupts(void) {
  // A. Point mtvec to our handler (Direct mode: lowest 2 bits are 00)
  write_csr(mtvec, (unsigned long)trap_handler);
 338:	3d000793          	li	a5,976
 33c:	30579073          	csrw	mtvec,a5

  // B. Enable Machine External Interrupts in the 'mie' register
  set_csr(mie, MIE_MEIE);
 340:	6785                	lui	a5,0x1
 342:	80078793          	addi	a5,a5,-2048 # 800 <min_heapify+0x8>
 346:	3047a7f3          	csrrs	a5,mie,a5

  // C. Enable Global Machine Interrupts in the 'mstatus' register
  set_csr(mstatus, MSTATUS_MIE);
 34a:	300467f3          	csrrsi	a5,mstatus,8
}
 34e:	8082                	ret

00000350 <plic_irq_handler>:
      // Hang indefinitely for debugger attachment
    }
  }
}

void plic_irq_handler(void) {
 350:	7179                	addi	sp,sp,-48

  uint32_t pending = *PLIC_IRQ_PEND;
 352:	200007b7          	lui	a5,0x20000
void plic_irq_handler(void) {
 356:	c85a                	sw	s6,16(sp)
 358:	c65e                	sw	s7,12(sp)
 35a:	10000b37          	lui	s6,0x10000
  uint32_t pending = *PLIC_IRQ_PEND;
 35e:	0047ab83          	lw	s7,4(a5) # 20000004 <_stack_top+0xfff0004>

  for (int i = 0; i < 8; i++) {
 362:	000b0b13          	mv	s6,s6
void plic_irq_handler(void) {
 366:	d04a                	sw	s2,32(sp)
 368:	ca56                	sw	s5,20(sp)
          plic_irq_priorities[current_idx] != -1) {
        plic_irq_handlers[current_idx]();

        // THIS ASSUMES THE HANDLER CLEARS THE STATE CAUSING THE INTERRUPT,
        // OTHERWISE THE IRQ WILL TRIGGER AGAIN
        *PLIC_CLAIM_REG = 1 << current_idx;
 36a:	20000ab7          	lui	s5,0x20000
void plic_irq_handler(void) {
 36e:	d226                	sw	s1,36(sp)
 370:	ce4e                	sw	s3,28(sp)
 372:	cc52                	sw	s4,24(sp)
 374:	c462                	sw	s8,8(sp)
 376:	d606                	sw	ra,44(sp)
 378:	d422                	sw	s0,40(sp)
 37a:	84da                	mv	s1,s6
 37c:	020b0a13          	addi	s4,s6,32 # 10000020 <plic_irq_priorities>
      if (plic_irq_handlers[current_idx] &&
 380:	81018913          	addi	s2,gp,-2032 # 10000050 <plic_irq_handlers>
        *PLIC_CLAIM_REG = 1 << current_idx;
 384:	0aa1                	addi	s5,s5,8 # 20000008 <_stack_top+0xfff0008>
    if ((pending & (1 << current_idx)) != 0) {
 386:	4985                	li	s3,1
      if (plic_irq_handlers[current_idx] &&
 388:	5c7d                	li	s8,-1
    int current_idx = plic_idx_sort[i];
 38a:	409c                	lw	a5,0(s1)
    if ((pending & (1 << current_idx)) != 0) {
 38c:	00f99433          	sll	s0,s3,a5
      if (plic_irq_handlers[current_idx] &&
 390:	00279713          	slli	a4,a5,0x2
    if ((pending & (1 << current_idx)) != 0) {
 394:	017477b3          	and	a5,s0,s7
      if (plic_irq_handlers[current_idx] &&
 398:	00e906b3          	add	a3,s2,a4
    if ((pending & (1 << current_idx)) != 0) {
 39c:	cb91                	beqz	a5,3b0 <plic_irq_handler+0x60>
      if (plic_irq_handlers[current_idx] &&
 39e:	429c                	lw	a5,0(a3)
          plic_irq_priorities[current_idx] != -1) {
 3a0:	975a                	add	a4,a4,s6
      if (plic_irq_handlers[current_idx] &&
 3a2:	c799                	beqz	a5,3b0 <plic_irq_handler+0x60>
 3a4:	5318                	lw	a4,32(a4)
 3a6:	01870563          	beq	a4,s8,3b0 <plic_irq_handler+0x60>
        plic_irq_handlers[current_idx]();
 3aa:	9782                	jalr	a5
        *PLIC_CLAIM_REG = 1 << current_idx;
 3ac:	008aa023          	sw	s0,0(s5)
  for (int i = 0; i < 8; i++) {
 3b0:	0491                	addi	s1,s1,4
 3b2:	fd449ce3          	bne	s1,s4,38a <plic_irq_handler+0x3a>
      }
    }
  }
}
 3b6:	50b2                	lw	ra,44(sp)
 3b8:	5422                	lw	s0,40(sp)
 3ba:	5492                	lw	s1,36(sp)
 3bc:	5902                	lw	s2,32(sp)
 3be:	49f2                	lw	s3,28(sp)
 3c0:	4a62                	lw	s4,24(sp)
 3c2:	4ad2                	lw	s5,20(sp)
 3c4:	4b42                	lw	s6,16(sp)
 3c6:	4bb2                	lw	s7,12(sp)
 3c8:	4c22                	lw	s8,8(sp)
 3ca:	6145                	addi	sp,sp,48
 3cc:	8082                	ret
 3ce:	0001                	nop

000003d0 <trap_handler>:
void __attribute__((interrupt("machine"), aligned(4))) trap_handler(void) {
 3d0:	7171                	addi	sp,sp,-176
 3d2:	d706                	sw	ra,172(sp)
 3d4:	d516                	sw	t0,168(sp)
 3d6:	003022f3          	frcsr	t0
 3da:	d316                	sw	t0,164(sp)
 3dc:	d11a                	sw	t1,160(sp)
 3de:	cf1e                	sw	t2,156(sp)
 3e0:	cd22                	sw	s0,152(sp)
 3e2:	cb26                	sw	s1,148(sp)
 3e4:	c92a                	sw	a0,144(sp)
 3e6:	c72e                	sw	a1,140(sp)
 3e8:	c532                	sw	a2,136(sp)
 3ea:	c336                	sw	a3,132(sp)
 3ec:	c13a                	sw	a4,128(sp)
 3ee:	debe                	sw	a5,124(sp)
 3f0:	dcc2                	sw	a6,120(sp)
 3f2:	dac6                	sw	a7,116(sp)
 3f4:	d8ca                	sw	s2,112(sp)
 3f6:	d6ce                	sw	s3,108(sp)
 3f8:	d4f2                	sw	t3,104(sp)
 3fa:	d2f6                	sw	t4,100(sp)
 3fc:	d0fa                	sw	t5,96(sp)
 3fe:	cefe                	sw	t6,92(sp)
 400:	e682                	fsw	ft0,76(sp)
 402:	e486                	fsw	ft1,72(sp)
 404:	e28a                	fsw	ft2,68(sp)
 406:	e08e                	fsw	ft3,64(sp)
 408:	fe12                	fsw	ft4,60(sp)
 40a:	fc16                	fsw	ft5,56(sp)
 40c:	fa1a                	fsw	ft6,52(sp)
 40e:	f81e                	fsw	ft7,48(sp)
 410:	f62a                	fsw	fa0,44(sp)
 412:	f42e                	fsw	fa1,40(sp)
 414:	f232                	fsw	fa2,36(sp)
 416:	f036                	fsw	fa3,32(sp)
 418:	ee3a                	fsw	fa4,28(sp)
 41a:	ec3e                	fsw	fa5,24(sp)
 41c:	ea42                	fsw	fa6,20(sp)
 41e:	e846                	fsw	fa7,16(sp)
 420:	e672                	fsw	ft8,12(sp)
 422:	e476                	fsw	ft9,8(sp)
 424:	e27a                	fsw	ft10,4(sp)
 426:	e07e                	fsw	ft11,0(sp)
  unsigned long cause = read_csr(mcause);
 428:	34202473          	csrr	s0,mcause
  if ((long)cause < 0) {
 42c:	06045963          	bgez	s0,49e <trap_handler+0xce>
    unsigned long exception_code = cause & ~(1UL << (sizeof(long) * 8 - 1));
 430:	00141793          	slli	a5,s0,0x1
 434:	8385                	srli	a5,a5,0x1
    if (exception_code == IRQ_M_EXT) {
 436:	472d                	li	a4,11
 438:	0ce78f63          	beq	a5,a4,516 <trap_handler+0x146>
    } else if (exception_code == IRQ_M_TIMER) {
 43c:	471d                	li	a4,7
 43e:	0ce78e63          	beq	a5,a4,51a <trap_handler+0x14a>
}
 442:	50ba                	lw	ra,172(sp)
 444:	529a                	lw	t0,164(sp)
 446:	00329073          	fscsr	t0
 44a:	446a                	lw	s0,152(sp)
 44c:	52aa                	lw	t0,168(sp)
 44e:	530a                	lw	t1,160(sp)
 450:	43fa                	lw	t2,156(sp)
 452:	44da                	lw	s1,148(sp)
 454:	454a                	lw	a0,144(sp)
 456:	45ba                	lw	a1,140(sp)
 458:	462a                	lw	a2,136(sp)
 45a:	469a                	lw	a3,132(sp)
 45c:	470a                	lw	a4,128(sp)
 45e:	57f6                	lw	a5,124(sp)
 460:	5866                	lw	a6,120(sp)
 462:	58d6                	lw	a7,116(sp)
 464:	5946                	lw	s2,112(sp)
 466:	59b6                	lw	s3,108(sp)
 468:	5e26                	lw	t3,104(sp)
 46a:	5e96                	lw	t4,100(sp)
 46c:	5f06                	lw	t5,96(sp)
 46e:	4ff6                	lw	t6,92(sp)
 470:	6036                	flw	ft0,76(sp)
 472:	60a6                	flw	ft1,72(sp)
 474:	6116                	flw	ft2,68(sp)
 476:	6186                	flw	ft3,64(sp)
 478:	7272                	flw	ft4,60(sp)
 47a:	72e2                	flw	ft5,56(sp)
 47c:	7352                	flw	ft6,52(sp)
 47e:	73c2                	flw	ft7,48(sp)
 480:	7532                	flw	fa0,44(sp)
 482:	75a2                	flw	fa1,40(sp)
 484:	7612                	flw	fa2,36(sp)
 486:	7682                	flw	fa3,32(sp)
 488:	6772                	flw	fa4,28(sp)
 48a:	67e2                	flw	fa5,24(sp)
 48c:	6852                	flw	fa6,20(sp)
 48e:	68c2                	flw	fa7,16(sp)
 490:	6e32                	flw	ft8,12(sp)
 492:	6ea2                	flw	ft9,8(sp)
 494:	6f12                	flw	ft10,4(sp)
 496:	6f82                	flw	ft11,0(sp)
 498:	614d                	addi	sp,sp,176
 49a:	30200073          	mret
    uart_polled_puts("\r\n\r\n=== CPU EXCEPTION / CRASH DETECTED ===\r\n");
 49e:	6505                	lui	a0,0x1
 4a0:	ee850513          	addi	a0,a0,-280 # ee8 <uart_print_hex+0x102>
 4a4:	11f000ef          	jal	dc2 <uart_polled_puts>
    uart_print_hex("mcause: 0x", (uint32_t)cause);
 4a8:	6505                	lui	a0,0x1
 4aa:	85a2                	mv	a1,s0
 4ac:	f1850513          	addi	a0,a0,-232 # f18 <uart_print_hex+0x132>
 4b0:	137000ef          	jal	de6 <uart_print_hex>
    uart_print_hex("mepc  : 0x", (uint32_t)read_csr(mepc));
 4b4:	341025f3          	csrr	a1,mepc
 4b8:	6505                	lui	a0,0x1
 4ba:	f2450513          	addi	a0,a0,-220 # f24 <uart_print_hex+0x13e>
 4be:	129000ef          	jal	de6 <uart_print_hex>
    uart_print_hex("mtval : 0x", (uint32_t)read_csr(mtval));
 4c2:	343025f3          	csrr	a1,mtval
 4c6:	6505                	lui	a0,0x1
 4c8:	f3050513          	addi	a0,a0,-208 # f30 <uart_print_hex+0x14a>
 4cc:	11b000ef          	jal	de6 <uart_print_hex>
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 4d0:	6505                	lui	a0,0x1
    while (stack_ptr < stack_top_ptr) {
 4d2:	100104b7          	lui	s1,0x10010
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 4d6:	f3c50513          	addi	a0,a0,-196 # f3c <uart_print_hex+0x156>
    while (stack_ptr < stack_top_ptr) {
 4da:	00048493          	mv	s1,s1
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 4de:	0e5000ef          	jal	dc2 <uart_polled_puts>
    while (stack_ptr < stack_top_ptr) {
 4e2:	02917463          	bgeu	sp,s1,50a <trap_handler+0x13a>
 4e6:	6785                	lui	a5,0x1
        uart_print_hex("  from instruction addr: 0x", val);
 4e8:	f6078993          	addi	s3,a5,-160 # f60 <uart_print_hex+0x17a>
 4ec:	840a                	mv	s0,sp
      if (val >= 0x00000000 && val < 0x00004000) {
 4ee:	6911                	lui	s2,0x4
 4f0:	a021                	j	4f8 <trap_handler+0x128>
    while (stack_ptr < stack_top_ptr) {
 4f2:	0411                	addi	s0,s0,4
 4f4:	00947b63          	bgeu	s0,s1,50a <trap_handler+0x13a>
      uint32_t val = *stack_ptr;
 4f8:	400c                	lw	a1,0(s0)
      if (val >= 0x00000000 && val < 0x00004000) {
 4fa:	ff25fce3          	bgeu	a1,s2,4f2 <trap_handler+0x122>
        uart_print_hex("  from instruction addr: 0x", val);
 4fe:	854e                	mv	a0,s3
    while (stack_ptr < stack_top_ptr) {
 500:	0411                	addi	s0,s0,4
        uart_print_hex("  from instruction addr: 0x", val);
 502:	0e5000ef          	jal	de6 <uart_print_hex>
    while (stack_ptr < stack_top_ptr) {
 506:	fe9469e3          	bltu	s0,s1,4f8 <trap_handler+0x128>
    uart_polled_puts("System halted.\r\n");
 50a:	6505                	lui	a0,0x1
 50c:	f7c50513          	addi	a0,a0,-132 # f7c <uart_print_hex+0x196>
 510:	0b3000ef          	jal	dc2 <uart_polled_puts>
    while (1) {
 514:	a001                	j	514 <trap_handler+0x144>
      plic_irq_handler();
 516:	3d2d                	jal	350 <plic_irq_handler>
 518:	b72d                	j	442 <trap_handler+0x72>
      if (timer_irq_handler) {
 51a:	100007b7          	lui	a5,0x10000
 51e:	0487a783          	lw	a5,72(a5) # 10000048 <timer_irq_handler>
 522:	f20780e3          	beqz	a5,442 <trap_handler+0x72>
        timer_irq_handler();
 526:	9782                	jalr	a5
 528:	bf29                	j	442 <trap_handler+0x72>

0000052a <resort_by_prior>:
  *PLIC_IRQ_ACTV |= actv_mask;

  resort_by_prior();
}

void resort_by_prior() {
 52a:	1141                	addi	sp,sp,-16

  for (int i = 0; i < 8; i++) {
    plic_idx_sort[i] = i;
 52c:	100007b7          	lui	a5,0x10000
 530:	00078793          	mv	a5,a5
void resort_by_prior() {
 534:	c622                	sw	s0,12(sp)
 536:	c426                	sw	s1,8(sp)
 538:	c24a                	sw	s2,4(sp)
 53a:	c04e                	sw	s3,0(sp)
    plic_idx_sort[i] = i;
 53c:	4709                	li	a4,2
 53e:	c798                	sw	a4,8(a5)
 540:	470d                	li	a4,3
 542:	c7d8                	sw	a4,12(a5)
 544:	4711                	li	a4,4
 546:	cb98                	sw	a4,16(a5)
 548:	4715                	li	a4,5
 54a:	cbd8                	sw	a4,20(a5)
 54c:	4719                	li	a4,6
 54e:	cf98                	sw	a4,24(a5)
  }

  // 19-Comparator Sorting Network for N=8
  // Layer 1
  CS(0, 1);
 550:	0207a283          	lw	t0,32(a5) # 10000020 <plic_irq_priorities>
    plic_idx_sort[i] = i;
 554:	471d                	li	a4,7
  CS(0, 1);
 556:	53c4                	lw	s1,36(a5)
    plic_idx_sort[i] = i;
 558:	cfd8                	sw	a4,28(a5)
 55a:	4705                	li	a4,1
 55c:	0007a023          	sw	zero,0(a5)
 560:	c3d8                	sw	a4,4(a5)
  CS(0, 1);
 562:	8eba                	mv	t4,a4
 564:	4401                	li	s0,0
 566:	0092da63          	bge	t0,s1,57a <resort_by_prior+0x50>
 56a:	8696                	mv	a3,t0
 56c:	c398                	sw	a4,0(a5)
 56e:	82a6                	mv	t0,s1
 570:	0007a223          	sw	zero,4(a5)
 574:	84b6                	mv	s1,a3
 576:	843a                	mv	s0,a4
 578:	4e81                	li	t4,0
  CS(2, 3);
 57a:	578c                	lw	a1,40(a5)
 57c:	57d8                	lw	a4,44(a5)
 57e:	4f0d                	li	t5,3
 580:	4809                	li	a6,2
 582:	00e5db63          	bge	a1,a4,598 <resort_by_prior+0x6e>
 586:	86ae                	mv	a3,a1
 588:	01e7a423          	sw	t5,8(a5)
 58c:	0107a623          	sw	a6,12(a5)
 590:	85ba                	mv	a1,a4
 592:	8f42                	mv	t5,a6
 594:	8736                	mv	a4,a3
 596:	480d                	li	a6,3
  CS(4, 5);
 598:	5b94                	lw	a3,48(a5)
 59a:	5bd0                	lw	a2,52(a5)
 59c:	4e15                	li	t3,5
 59e:	4311                	li	t1,4
 5a0:	00c6db63          	bge	a3,a2,5b6 <resort_by_prior+0x8c>
 5a4:	8536                	mv	a0,a3
 5a6:	01c7a823          	sw	t3,16(a5)
 5aa:	0067aa23          	sw	t1,20(a5)
 5ae:	86b2                	mv	a3,a2
 5b0:	8e1a                	mv	t3,t1
 5b2:	862a                	mv	a2,a0
 5b4:	4315                	li	t1,5
  CS(6, 7);
 5b6:	5f88                	lw	a0,56(a5)
 5b8:	03c7af83          	lw	t6,60(a5)
 5bc:	439d                	li	t2,7
 5be:	4899                	li	a7,6
 5c0:	01f55b63          	bge	a0,t6,5d6 <resort_by_prior+0xac>
 5c4:	892a                	mv	s2,a0
 5c6:	0077ac23          	sw	t2,24(a5)
 5ca:	0117ae23          	sw	a7,28(a5)
 5ce:	857e                	mv	a0,t6
 5d0:	83c6                	mv	t2,a7
 5d2:	8fca                	mv	t6,s2
 5d4:	489d                	li	a7,7
  // Layer 2
  CS(0, 2);
 5d6:	00b2db63          	bge	t0,a1,5ec <resort_by_prior+0xc2>
 5da:	89ae                	mv	s3,a1
 5dc:	8942                	mv	s2,a6
 5de:	0107a023          	sw	a6,0(a5)
 5e2:	c780                	sw	s0,8(a5)
 5e4:	8596                	mv	a1,t0
 5e6:	8822                	mv	a6,s0
 5e8:	82ce                	mv	t0,s3
 5ea:	844a                	mv	s0,s2
  CS(1, 3);
 5ec:	00e4dc63          	bge	s1,a4,604 <resort_by_prior+0xda>
 5f0:	89a6                	mv	s3,s1
 5f2:	8976                	mv	s2,t4
 5f4:	01d7a623          	sw	t4,12(a5)
 5f8:	01e7a223          	sw	t5,4(a5)
 5fc:	84ba                	mv	s1,a4
 5fe:	8efa                	mv	t4,t5
 600:	874e                	mv	a4,s3
 602:	8f4a                	mv	t5,s2
  CS(4, 6);
 604:	00a6dc63          	bge	a3,a0,61c <resort_by_prior+0xf2>
 608:	89aa                	mv	s3,a0
 60a:	8946                	mv	s2,a7
 60c:	0117a823          	sw	a7,16(a5)
 610:	0067ac23          	sw	t1,24(a5)
 614:	8536                	mv	a0,a3
 616:	889a                	mv	a7,t1
 618:	86ce                	mv	a3,s3
 61a:	834a                	mv	t1,s2
  CS(5, 7);
 61c:	01f65c63          	bge	a2,t6,634 <resort_by_prior+0x10a>
 620:	89b2                	mv	s3,a2
 622:	8972                	mv	s2,t3
 624:	01c7ae23          	sw	t3,28(a5)
 628:	0077aa23          	sw	t2,20(a5)
 62c:	867e                	mv	a2,t6
 62e:	8e1e                	mv	t3,t2
 630:	8fce                	mv	t6,s3
 632:	83ca                	mv	t2,s2
  // Layer 3
  CS(1, 2);
 634:	00b4dc63          	bge	s1,a1,64c <resort_by_prior+0x122>
 638:	89a6                	mv	s3,s1
 63a:	8976                	mv	s2,t4
 63c:	01d7a423          	sw	t4,8(a5)
 640:	0107a223          	sw	a6,4(a5)
 644:	84ae                	mv	s1,a1
 646:	8ec2                	mv	t4,a6
 648:	85ce                	mv	a1,s3
 64a:	884a                	mv	a6,s2
  CS(5, 6);
 64c:	00a65c63          	bge	a2,a0,664 <resort_by_prior+0x13a>
 650:	89b2                	mv	s3,a2
 652:	8972                	mv	s2,t3
 654:	01c7ac23          	sw	t3,24(a5)
 658:	0117aa23          	sw	a7,20(a5)
 65c:	862a                	mv	a2,a0
 65e:	8e46                	mv	t3,a7
 660:	854e                	mv	a0,s3
 662:	88ca                	mv	a7,s2
  CS(0, 4);
 664:	00d2d763          	bge	t0,a3,672 <resort_by_prior+0x148>
 668:	0067a023          	sw	t1,0(a5)
 66c:	cb80                	sw	s0,16(a5)
 66e:	8696                	mv	a3,t0
 670:	8322                	mv	t1,s0
  CS(3, 7);
 672:	01f75863          	bge	a4,t6,682 <resort_by_prior+0x158>
 676:	01e7ae23          	sw	t5,28(a5)
 67a:	0077a623          	sw	t2,12(a5)
 67e:	877e                	mv	a4,t6
 680:	8f1e                	mv	t5,t2
  // Layer 4
  CS(1, 5);
 682:	00c4dc63          	bge	s1,a2,69a <resort_by_prior+0x170>
 686:	82a6                	mv	t0,s1
 688:	8ff6                	mv	t6,t4
 68a:	01d7aa23          	sw	t4,20(a5)
 68e:	01c7a223          	sw	t3,4(a5)
 692:	84b2                	mv	s1,a2
 694:	8ef2                	mv	t4,t3
 696:	8616                	mv	a2,t0
 698:	8e7e                	mv	t3,t6
  CS(2, 6);
 69a:	00a5dc63          	bge	a1,a0,6b2 <resort_by_prior+0x188>
 69e:	82aa                	mv	t0,a0
 6a0:	8fc6                	mv	t6,a7
 6a2:	0117a423          	sw	a7,8(a5)
 6a6:	0107ac23          	sw	a6,24(a5)
 6aa:	852e                	mv	a0,a1
 6ac:	88c2                	mv	a7,a6
 6ae:	8596                	mv	a1,t0
 6b0:	887e                	mv	a6,t6
  // Layer 5
  CS(1, 4);
 6b2:	00d4d863          	bge	s1,a3,6c2 <resort_by_prior+0x198>
 6b6:	0067a223          	sw	t1,4(a5)
 6ba:	01d7a823          	sw	t4,16(a5)
 6be:	86a6                	mv	a3,s1
 6c0:	8376                	mv	t1,t4
  CS(3, 6);
 6c2:	00a75863          	bge	a4,a0,6d2 <resort_by_prior+0x1a8>
 6c6:	01e7ac23          	sw	t5,24(a5)
 6ca:	0117a623          	sw	a7,12(a5)
 6ce:	872a                	mv	a4,a0
 6d0:	8f46                	mv	t5,a7
  // Layer 6
  CS(2, 4);
 6d2:	00d5d863          	bge	a1,a3,6e2 <resort_by_prior+0x1b8>
 6d6:	0067a423          	sw	t1,8(a5)
 6da:	0107a823          	sw	a6,16(a5)
 6de:	86ae                	mv	a3,a1
 6e0:	8342                	mv	t1,a6
  CS(3, 5);
 6e2:	00c75863          	bge	a4,a2,6f2 <resort_by_prior+0x1c8>
 6e6:	01e7aa23          	sw	t5,20(a5)
 6ea:	01c7a623          	sw	t3,12(a5)
 6ee:	8732                	mv	a4,a2
 6f0:	8f72                	mv	t5,t3
  // Layer 7
  CS(3, 4);
 6f2:	00d75663          	bge	a4,a3,6fe <resort_by_prior+0x1d4>
 6f6:	0067a623          	sw	t1,12(a5)
 6fa:	01e7a823          	sw	t5,16(a5)
}
 6fe:	4432                	lw	s0,12(sp)
 700:	44a2                	lw	s1,8(sp)
 702:	4912                	lw	s2,4(sp)
 704:	4982                	lw	s3,0(sp)
 706:	0141                	addi	sp,sp,16
 708:	8082                	ret

0000070a <reg_irq_handler>:
  *PLIC_IRQ_ACTV |= actv_mask;
 70a:	200008b7          	lui	a7,0x20000
 70e:	0008a803          	lw	a6,0(a7) # 20000000 <_stack_top+0xfff0000>
  plic_irq_priorities[arr_idx] = priority;
 712:	100007b7          	lui	a5,0x10000
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 716:	068a                	slli	a3,a3,0x2
 718:	81018713          	addi	a4,gp,-2032 # 10000050 <plic_irq_handlers>
  plic_irq_priorities[arr_idx] = priority;
 71c:	00078793          	mv	a5,a5
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 720:	9736                	add	a4,a4,a3
  plic_irq_priorities[arr_idx] = priority;
 722:	97b6                	add	a5,a5,a3
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 724:	c308                	sw	a0,0(a4)
  plic_irq_priorities[arr_idx] = priority;
 726:	d38c                	sw	a1,32(a5)
  *PLIC_IRQ_ACTV |= actv_mask;
 728:	00c86833          	or	a6,a6,a2
 72c:	0108a023          	sw	a6,0(a7)
  resort_by_prior();
 730:	bbed                	j	52a <resort_by_prior>

00000732 <reg_timer_irq>:

void reg_timer_irq(void (*_timer_irq_handler)(void)) {
  timer_irq_handler = _timer_irq_handler;
 732:	100007b7          	lui	a5,0x10000
 736:	04a7a423          	sw	a0,72(a5) # 10000048 <timer_irq_handler>
}
 73a:	8082                	ret
 73c:	0001                	nop

0000073e <init_ring_buffer>:
#include "../include/ring_buff.h"

void init_ring_buffer(ring_buffer_t *rb) {
  // No malloc needed! The memory is already allocated as part of the struct.
  rb->head = 0;
 73e:	10050023          	sb	zero,256(a0)
  rb->tail = 0;
 742:	100500a3          	sb	zero,257(a0)
}
 746:	8082                	ret

00000748 <reset_ring_buffer>:

void reset_ring_buffer(ring_buffer_t *rb) {
 748:	10050023          	sb	zero,256(a0)
 74c:	100500a3          	sb	zero,257(a0)
 750:	8082                	ret

00000752 <insert_rb>:
}

bool insert_rb(ring_buffer_t *rb, char c) {
  // Calculate what the next head position will be.
  // uint8_t naturally wraps from 255 back to 0.
  uint8_t next_head = (uint8_t)(rb->head + 1);
 752:	10054703          	lbu	a4,256(a0)

  // If the next head hits the tail, the buffer is full.
  // Note: This design sacrifices 1 byte of capacity, holding a max of 255
  // items.
  if (next_head == rb->tail) {
 756:	10154683          	lbu	a3,257(a0)
  uint8_t next_head = (uint8_t)(rb->head + 1);
 75a:	00170793          	addi	a5,a4,1 # 20003001 <_stack_top+0xfff3001>
 75e:	0ff7f793          	zext.b	a5,a5
  if (next_head == rb->tail) {
 762:	00f68963          	beq	a3,a5,774 <insert_rb+0x22>
    return false;
  }

  rb->buffer[rb->head] = c;
 766:	972a                	add	a4,a4,a0
 768:	00b70023          	sb	a1,0(a4)
  rb->head = next_head;
 76c:	10f50023          	sb	a5,256(a0)

  return true;
 770:	4505                	li	a0,1
 772:	8082                	ret
    return false;
 774:	4501                	li	a0,0
}
 776:	8082                	ret

00000778 <pop_rb>:

bool pop_rb(ring_buffer_t *rb, char *c) {
  // If head and tail are at the same position, the buffer is empty.
  if (rb->head == rb->tail) {
 778:	10154703          	lbu	a4,257(a0)
 77c:	10054683          	lbu	a3,256(a0)
bool pop_rb(ring_buffer_t *rb, char *c) {
 780:	87aa                	mv	a5,a0
  if (rb->head == rb->tail) {
 782:	00e68e63          	beq	a3,a4,79e <pop_rb+0x26>
    return false;
  }

  *c = rb->buffer[rb->tail];
 786:	972a                	add	a4,a4,a0
 788:	00074703          	lbu	a4,0(a4)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0

  return true;
 78c:	4505                	li	a0,1
  *c = rb->buffer[rb->tail];
 78e:	00e58023          	sb	a4,0(a1)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0
 792:	1017c703          	lbu	a4,257(a5)
 796:	972a                	add	a4,a4,a0
 798:	10e780a3          	sb	a4,257(a5)
  return true;
 79c:	8082                	ret
    return false;
 79e:	4501                	li	a0,0
}
 7a0:	8082                	ret

000007a2 <init_timers>:
#include "../include/timer.h"
#include <stdint.h>

void init_timers() {
 7a2:	1141                	addi	sp,sp,-16
 7a4:	c606                	sw	ra,12(sp)

  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 7a6:	20000737          	lui	a4,0x20000
 7aa:	56fd                	li	a3,-1
 7ac:	c714                	sw	a3,8(a4)
  *TIMER_COMP_PART2 = 0xFFFFFFFF;

  reg_timer_irq(master_timer_isr);
 7ae:	6505                	lui	a0,0x1
  *TIMER_COMP_PART2 = 0xFFFFFFFF;
 7b0:	c754                	sw	a3,12(a4)
  reg_timer_irq(master_timer_isr);
 7b2:	9de50513          	addi	a0,a0,-1570 # 9de <master_timer_isr>
 7b6:	3fb5                	jal	732 <reg_timer_irq>

  set_csr(mie, MIE_MTIE);
 7b8:	08000793          	li	a5,128
 7bc:	3047a7f3          	csrrs	a5,mie,a5
}
 7c0:	40b2                	lw	ra,12(sp)
 7c2:	0141                	addi	sp,sp,16
 7c4:	8082                	ret

000007c6 <read_time>:

uint64_t read_time() {
  uint32_t lo = *TIMER_COMP_PART1;
 7c6:	200007b7          	lui	a5,0x20000
 7ca:	4788                	lw	a0,8(a5)

  uint32_t hi = *TIMER_COMP_PART2;
 7cc:	200007b7          	lui	a5,0x20000

  return (((uint64_t)hi) << 32) | lo;
}
 7d0:	47cc                	lw	a1,12(a5)
 7d2:	8082                	ret

000007d4 <set_compare>:

void set_compare(uint64_t comp) {
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 7d4:	200007b7          	lui	a5,0x20000
 7d8:	56fd                	li	a3,-1
 7da:	c794                	sw	a3,8(a5)

  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 7dc:	c7cc                	sw	a1,12(a5)

  *TIMER_COMP_PART1 = (uint32_t)comp;
 7de:	c788                	sw	a0,8(a5)
}
 7e0:	8082                	ret

000007e2 <swap_in_heap>:

void swap_in_heap(int a_i, int b_i) {
  irq_timer_t *temp = timer_heap[a_i];
 7e2:	83018793          	addi	a5,gp,-2000 # 10000070 <timer_heap>
  timer_heap[a_i] = timer_heap[b_i];
 7e6:	058a                	slli	a1,a1,0x2
 7e8:	95be                	add	a1,a1,a5
  irq_timer_t *temp = timer_heap[a_i];
 7ea:	050a                	slli	a0,a0,0x2
  timer_heap[a_i] = timer_heap[b_i];
 7ec:	4194                	lw	a3,0(a1)
  irq_timer_t *temp = timer_heap[a_i];
 7ee:	97aa                	add	a5,a5,a0
 7f0:	4398                	lw	a4,0(a5)
  timer_heap[a_i] = timer_heap[b_i];
 7f2:	c394                	sw	a3,0(a5)
  timer_heap[b_i] = temp;
 7f4:	c198                	sw	a4,0(a1)
}
 7f6:	8082                	ret

000007f8 <min_heapify>:

// first call should be, num_timers, 0
void min_heapify(int sz, int i) {
  int smallest = i;
  int left = 2 * i + 1;
 7f8:	00159793          	slli	a5,a1,0x1
 7fc:	00178693          	addi	a3,a5,1 # 20000001 <_stack_top+0xfff0001>
  int right = 2 * i + 2;

  if (left < sz &&
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 800:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
  int right = 2 * i + 2;
 804:	0789                	addi	a5,a5,2
  if (left < sz &&
 806:	06a6de63          	bge	a3,a0,882 <min_heapify+0x8a>
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 80a:	00269713          	slli	a4,a3,0x2
 80e:	00259613          	slli	a2,a1,0x2
 812:	9742                	add	a4,a4,a6
 814:	00c80333          	add	t1,a6,a2
 818:	00072883          	lw	a7,0(a4) # 20000000 <_stack_top+0xfff0000>
 81c:	00032e03          	lw	t3,0(t1)
 820:	0048a703          	lw	a4,4(a7)
  if (left < sz &&
 824:	004e2303          	lw	t1,4(t3)
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 828:	0008a883          	lw	a7,0(a7)
  if (left < sz &&
 82c:	00676863          	bltu	a4,t1,83c <min_heapify+0x44>
 830:	04e31963          	bne	t1,a4,882 <min_heapify+0x8a>
 834:	000e2303          	lw	t1,0(t3)
 838:	0468f563          	bgeu	a7,t1,882 <min_heapify+0x8a>
    smallest = left;
  }

  if (right < sz &&
 83c:	00a7dd63          	bge	a5,a0,856 <min_heapify+0x5e>
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 840:	00279313          	slli	t1,a5,0x2
 844:	9342                	add	t1,t1,a6
 846:	00032e03          	lw	t3,0(t1)
  if (right < sz &&
 84a:	004e2303          	lw	t1,4(t3)
 84e:	00e36563          	bltu	t1,a4,858 <min_heapify+0x60>
 852:	06e30563          	beq	t1,a4,8bc <min_heapify+0xc4>
 856:	87b6                	mv	a5,a3
    smallest = right;
  }

  if (smallest != i) {
 858:	06b78163          	beq	a5,a1,8ba <min_heapify+0xc2>
  timer_heap[a_i] = timer_heap[b_i];
 85c:	00279713          	slli	a4,a5,0x2
 860:	9742                	add	a4,a4,a6
  irq_timer_t *temp = timer_heap[a_i];
 862:	00c806b3          	add	a3,a6,a2
  timer_heap[a_i] = timer_heap[b_i];
 866:	00072883          	lw	a7,0(a4)
  irq_timer_t *temp = timer_heap[a_i];
 86a:	4290                	lw	a2,0(a3)
    swap_in_heap(i, smallest);
    min_heapify(sz, smallest);
 86c:	85be                	mv	a1,a5
  timer_heap[a_i] = timer_heap[b_i];
 86e:	0116a023          	sw	a7,0(a3)
  int left = 2 * i + 1;
 872:	00159793          	slli	a5,a1,0x1
 876:	00178693          	addi	a3,a5,1
  timer_heap[b_i] = temp;
 87a:	c310                	sw	a2,0(a4)
  int right = 2 * i + 2;
 87c:	0789                	addi	a5,a5,2
  if (left < sz &&
 87e:	f8a6c6e3          	blt	a3,a0,80a <min_heapify+0x12>
  if (right < sz &&
 882:	00a7c363          	blt	a5,a0,888 <min_heapify+0x90>
 886:	8082                	ret
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 888:	00259613          	slli	a2,a1,0x2
 88c:	00279713          	slli	a4,a5,0x2
 890:	00c806b3          	add	a3,a6,a2
 894:	9742                	add	a4,a4,a6
 896:	0006a303          	lw	t1,0(a3)
 89a:	00072883          	lw	a7,0(a4)
  if (right < sz &&
 89e:	00432683          	lw	a3,4(t1)
 8a2:	0048a703          	lw	a4,4(a7)
 8a6:	fad769e3          	bltu	a4,a3,858 <min_heapify+0x60>
 8aa:	00e69863          	bne	a3,a4,8ba <min_heapify+0xc2>
 8ae:	00032683          	lw	a3,0(t1)
 8b2:	0008a703          	lw	a4,0(a7)
 8b6:	fad761e3          	bltu	a4,a3,858 <min_heapify+0x60>
  }
}
 8ba:	8082                	ret
  if (right < sz &&
 8bc:	000e2703          	lw	a4,0(t3)
 8c0:	f9176ce3          	bltu	a4,a7,858 <min_heapify+0x60>
 8c4:	87b6                	mv	a5,a3
 8c6:	bf49                	j	858 <min_heapify+0x60>

000008c8 <sift_up>:

void sift_up(int i) {
  int parent = (i - 1) / 2;
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 8c8:	04a05f63          	blez	a0,926 <sift_up+0x5e>
 8cc:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 8d0:	00251793          	slli	a5,a0,0x2
 8d4:	97b2                	add	a5,a5,a2
 8d6:	0007a303          	lw	t1,0(a5)
  int parent = (i - 1) / 2;
 8da:	fff50713          	addi	a4,a0,-1
 8de:	8705                	srai	a4,a4,0x1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 8e0:	00032e83          	lw	t4,0(t1)
 8e4:	00432e03          	lw	t3,4(t1)
 8e8:	a809                	j	8fa <sift_up+0x32>
  timer_heap[a_i] = timer_heap[b_i];
 8ea:	c10c                	sw	a1,0(a0)
  timer_heap[b_i] = temp;
 8ec:	0067a023          	sw	t1,0(a5)
    swap_in_heap(i, parent);

    // Move up the tree
    i = parent;
    parent = (i - 1) / 2;
 8f0:	96c2                	add	a3,a3,a6
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 8f2:	853a                	mv	a0,a4
 8f4:	cb0d                	beqz	a4,926 <sift_up+0x5e>
 8f6:	4016d713          	srai	a4,a3,0x1
 8fa:	00271793          	slli	a5,a4,0x2
 8fe:	00f606b3          	add	a3,a2,a5
 902:	428c                	lw	a1,0(a3)
  timer_heap[a_i] = timer_heap[b_i];
 904:	050a                	slli	a0,a0,0x2
    parent = (i - 1) / 2;
 906:	fff70813          	addi	a6,a4,-1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 90a:	0045a883          	lw	a7,4(a1)
  timer_heap[b_i] = temp;
 90e:	87b6                	mv	a5,a3
  timer_heap[a_i] = timer_heap[b_i];
 910:	9532                	add	a0,a0,a2
    parent = (i - 1) / 2;
 912:	01f85693          	srli	a3,a6,0x1f
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 916:	fd1e6ae3          	bltu	t3,a7,8ea <sift_up+0x22>
 91a:	01c89663          	bne	a7,t3,926 <sift_up+0x5e>
 91e:	0005a883          	lw	a7,0(a1)
 922:	fd1ee4e3          	bltu	t4,a7,8ea <sift_up+0x22>
  }
}
 926:	8082                	ret

00000928 <_deactivate_timer.part.0>:
  // 1. Mark as inactive so the pool slot can be reused
  timer->active = false;

  // 2. Find the timer in the heap (O(N) search, but MAX_TIMERS is small)
  int heap_idx = -1;
  for (int i = 0; i < num_timers; i++) {
 928:	80c1a683          	lw	a3,-2036(gp) # 1000004c <num_timers>
  timer->active = false;
 92c:	00050a23          	sb	zero,20(a0)
  for (int i = 0; i < num_timers; i++) {
 930:	06d05063          	blez	a3,990 <_deactivate_timer.part.0+0x68>
 934:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 938:	87b2                	mv	a5,a2
 93a:	4581                	li	a1,0
 93c:	a021                	j	944 <_deactivate_timer.part.0+0x1c>
 93e:	0585                	addi	a1,a1,1
 940:	04d58863          	beq	a1,a3,990 <_deactivate_timer.part.0+0x68>
    if (timer_heap[i] == timer) {
 944:	4398                	lw	a4,0(a5)
  for (int i = 0; i < num_timers; i++) {
 946:	0791                	addi	a5,a5,4
    if (timer_heap[i] == timer) {
 948:	fee51be3          	bne	a0,a4,93e <_deactivate_timer.part.0+0x16>
  if (heap_idx == -1) {
    return false; // Timer was active but not in heap (state error)
  }

  // 3. Replace the removed timer with the last timer in the heap
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 94c:	fff68513          	addi	a0,a3,-1
 950:	00251793          	slli	a5,a0,0x2
 954:	97b2                	add	a5,a5,a2
 956:	4398                	lw	a4,0(a5)
bool _deactivate_timer(irq_timer_t *timer) {
 958:	1141                	addi	sp,sp,-16
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 95a:	00259793          	slli	a5,a1,0x2
bool _deactivate_timer(irq_timer_t *timer) {
 95e:	c606                	sw	ra,12(sp)
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 960:	97b2                	add	a5,a5,a2
  num_timers--;
 962:	80a1a623          	sw	a0,-2036(gp) # 1000004c <num_timers>
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 966:	c398                	sw	a4,0(a5)

  // 4. Restore the heap property
  if (heap_idx < num_timers) {
 968:	02a5d663          	bge	a1,a0,994 <_deactivate_timer.part.0+0x6c>
    int parent = (heap_idx - 1) / 2;

    // If the new node is smaller than its parent, it needs to bubble up
    if (heap_idx > 0 &&
 96c:	c5ad                	beqz	a1,9d6 <_deactivate_timer.part.0+0xae>
    int parent = (heap_idx - 1) / 2;
 96e:	fff58793          	addi	a5,a1,-1
 972:	8785                	srai	a5,a5,0x1
        timer_heap[heap_idx]->expires_at < timer_heap[parent]->expires_at) {
 974:	078a                	slli	a5,a5,0x2
 976:	963e                	add	a2,a2,a5
 978:	4210                	lw	a2,0(a2)
    if (heap_idx > 0 &&
 97a:	435c                	lw	a5,4(a4)
 97c:	4254                	lw	a3,4(a2)
 97e:	04d7e963          	bltu	a5,a3,9d0 <_deactivate_timer.part.0+0xa8>
 982:	04f68363          	beq	a3,a5,9c8 <_deactivate_timer.part.0+0xa0>
      sift_up(heap_idx);
    }
    // Otherwise, it might need to bubble down
    else {
      min_heapify(num_timers, heap_idx);
 986:	3d8d                	jal	7f8 <min_heapify>
      set_compare(0xFFFFFFFFFFFFFFFFULL);
    }
  }

  return true;
}
 988:	40b2                	lw	ra,12(sp)
  return true;
 98a:	4505                	li	a0,1
}
 98c:	0141                	addi	sp,sp,16
 98e:	8082                	ret
    return false;
 990:	4501                	li	a0,0
}
 992:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 994:	ed99                	bnez	a1,9b2 <_deactivate_timer.part.0+0x8a>
    if (num_timers > 0) {
 996:	cd19                	beqz	a0,9b4 <_deactivate_timer.part.0+0x8c>
      set_compare(timer_heap[0]->expires_at);
 998:	4218                	lw	a4,0(a2)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 99a:	200007b7          	lui	a5,0x20000
 99e:	55fd                	li	a1,-1
      set_compare(timer_heap[0]->expires_at);
 9a0:	4350                	lw	a2,4(a4)
 9a2:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 9a4:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 9a6:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 9a8:	c794                	sw	a3,8(a5)
}
 9aa:	40b2                	lw	ra,12(sp)
  return true;
 9ac:	4505                	li	a0,1
}
 9ae:	0141                	addi	sp,sp,16
 9b0:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 9b2:	fd65                	bnez	a0,9aa <_deactivate_timer.part.0+0x82>
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 9b4:	200007b7          	lui	a5,0x20000
 9b8:	577d                	li	a4,-1
 9ba:	c798                	sw	a4,8(a5)
}
 9bc:	40b2                	lw	ra,12(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 9be:	c7d8                	sw	a4,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 9c0:	c798                	sw	a4,8(a5)
  return true;
 9c2:	4505                	li	a0,1
}
 9c4:	0141                	addi	sp,sp,16
 9c6:	8082                	ret
    if (heap_idx > 0 &&
 9c8:	4214                	lw	a3,0(a2)
 9ca:	431c                	lw	a5,0(a4)
 9cc:	fad7fde3          	bgeu	a5,a3,986 <_deactivate_timer.part.0+0x5e>
      sift_up(heap_idx);
 9d0:	852e                	mv	a0,a1
 9d2:	3ddd                	jal	8c8 <sift_up>
  if (heap_idx == 0 || num_timers == 0) {
 9d4:	bfd9                	j	9aa <_deactivate_timer.part.0+0x82>
      min_heapify(num_timers, heap_idx);
 9d6:	350d                	jal	7f8 <min_heapify>
  if (heap_idx == 0 || num_timers == 0) {
 9d8:	83018613          	addi	a2,gp,-2000 # 10000070 <timer_heap>
 9dc:	bf75                	j	998 <_deactivate_timer.part.0+0x70>

000009de <master_timer_isr>:

void master_timer_isr() {
 9de:	1101                	addi	sp,sp,-32
 9e0:	c452                	sw	s4,8(sp)
  // Loop to handle cases where multiple timers expire at the same time,
  // or if a callback execution delays us past the next timer's expiration.
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 9e2:	80c1a783          	lw	a5,-2036(gp) # 1000004c <num_timers>
void master_timer_isr() {
 9e6:	ce06                	sw	ra,28(sp)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 9e8:	04f05f63          	blez	a5,a46 <master_timer_isr+0x68>
 9ec:	ca26                	sw	s1,20(sp)
 9ee:	c84a                	sw	s2,16(sp)
 9f0:	c64e                	sw	s3,12(sp)
 9f2:	200009b7          	lui	s3,0x20000
 9f6:	20000937          	lui	s2,0x20000
 9fa:	cc22                	sw	s0,24(sp)
 9fc:	c256                	sw	s5,4(sp)
 9fe:	83018493          	addi	s1,gp,-2000 # 10000070 <timer_heap>
 a02:	09a1                	addi	s3,s3,8 # 20000008 <_stack_top+0xfff0008>
 a04:	0931                	addi	s2,s2,12 # 2000000c <_stack_top+0xfff000c>
 a06:	4080                	lw	s0,0(s1)
  uint32_t lo = *TIMER_COMP_PART1;
 a08:	0009a683          	lw	a3,0(s3)
  uint32_t hi = *TIMER_COMP_PART2;
 a0c:	00092783          	lw	a5,0(s2)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 a10:	4058                	lw	a4,4(s0)
 a12:	06e7e263          	bltu	a5,a4,a76 <master_timer_isr+0x98>
 a16:	04f70d63          	beq	a4,a5,a70 <master_timer_isr+0x92>

    // 1. Get the timer at the top of the heap
    irq_timer_t *top_timer = timer_heap[0];

    // 2. Run the callback function
    if (top_timer->callback_function != NULL) {
 a1a:	481c                	lw	a5,16(s0)
 a1c:	c391                	beqz	a5,a20 <master_timer_isr+0x42>
      // Cast the void* to a function pointer and execute it
      void (*callback)(void) = (void (*)(void))top_timer->callback_function;
      callback();
 a1e:	9782                	jalr	a5
    }

    // 3. Handle periodic vs absolute
    if (top_timer->period > 0) {
 a20:	441c                	lw	a5,8(s0)
 a22:	4454                	lw	a3,12(s0)
 a24:	00d7e733          	or	a4,a5,a3
 a28:	e31d                	bnez	a4,a4e <master_timer_isr+0x70>
  if (timer == NULL || !timer->active) {
 a2a:	01444783          	lbu	a5,20(s0)
 a2e:	c399                	beqz	a5,a34 <master_timer_isr+0x56>
  timer->active = false;
 a30:	8522                	mv	a0,s0
 a32:	3ddd                	jal	928 <_deactivate_timer.part.0>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 a34:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
 a38:	fd5047e3          	bgtz	s5,a06 <master_timer_isr+0x28>
 a3c:	4462                	lw	s0,24(sp)
 a3e:	44d2                	lw	s1,20(sp)
 a40:	4942                	lw	s2,16(sp)
 a42:	49b2                	lw	s3,12(sp)
 a44:	4a92                	lw	s5,4(sp)
  }

  if (num_timers > 0) {
    set_compare(timer_heap[0]->expires_at);
  }
}
 a46:	40f2                	lw	ra,28(sp)
 a48:	4a22                	lw	s4,8(sp)
 a4a:	6105                	addi	sp,sp,32
 a4c:	8082                	ret
      top_timer->expires_at += top_timer->period;
 a4e:	4018                	lw	a4,0(s0)
 a50:	4050                	lw	a2,4(s0)
      min_heapify(num_timers, 0);
 a52:	80c1aa83          	lw	s5,-2036(gp) # 1000004c <num_timers>
      top_timer->expires_at += top_timer->period;
 a56:	97ba                	add	a5,a5,a4
 a58:	00e7b733          	sltu	a4,a5,a4
 a5c:	96b2                	add	a3,a3,a2
 a5e:	9736                	add	a4,a4,a3
 a60:	c01c                	sw	a5,0(s0)
 a62:	c058                	sw	a4,4(s0)
      min_heapify(num_timers, 0);
 a64:	8556                	mv	a0,s5
 a66:	4581                	li	a1,0
 a68:	3b41                	jal	7f8 <min_heapify>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 a6a:	f9504ee3          	bgtz	s5,a06 <master_timer_isr+0x28>
 a6e:	b7f9                	j	a3c <master_timer_isr+0x5e>
 a70:	401c                	lw	a5,0(s0)
 a72:	faf6f4e3          	bgeu	a3,a5,a1a <master_timer_isr+0x3c>
    set_compare(timer_heap[0]->expires_at);
 a76:	4098                	lw	a4,0(s1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a78:	200007b7          	lui	a5,0x20000
 a7c:	55fd                	li	a1,-1
    set_compare(timer_heap[0]->expires_at);
 a7e:	4350                	lw	a2,4(a4)
 a80:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a82:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 a84:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 a86:	c794                	sw	a3,8(a5)
 a88:	bf55                	j	a3c <master_timer_isr+0x5e>

00000a8a <register_isr_periodic>:
  if (num_timers == MAX_TIMERS) {
 a8a:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 a8e:	04000793          	li	a5,64
 a92:	0af88e63          	beq	a7,a5,b4e <register_isr_periodic+0xc4>
    if (timer_pool[i].active == false) {
 a96:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 a9a:	11484783          	lbu	a5,276(a6)
irq_timer_handler register_isr_periodic(uint64_t period, void *cb) {
 a9e:	1101                	addi	sp,sp,-32
 aa0:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 aa2:	cbc5                	beqz	a5,b52 <register_isr_periodic+0xc8>
 aa4:	12c80793          	addi	a5,a6,300
  int i = 0;
 aa8:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 aaa:	0007c683          	lbu	a3,0(a5) # 20000000 <_stack_top+0xfff0000>
 aae:	07e1                	addi	a5,a5,24
      i++;
 ab0:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 ab2:	fee5                	bnez	a3,aaa <register_isr_periodic+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 ab4:	00171793          	slli	a5,a4,0x1
 ab8:	00e78333          	add	t1,a5,a4
 abc:	030e                	slli	t1,t1,0x3
 abe:	10080693          	addi	a3,a6,256
 ac2:	969a                	add	a3,a3,t1
  uint32_t lo = *TIMER_COMP_PART1;
 ac4:	20000e37          	lui	t3,0x20000
  timer_pool[i].expires_at = read_time() + period;
 ac8:	97ba                	add	a5,a5,a4
  uint32_t lo = *TIMER_COMP_PART1;
 aca:	008e2703          	lw	a4,8(t3) # 20000008 <_stack_top+0xfff0008>
 ace:	832a                	mv	t1,a0
  uint32_t hi = *TIMER_COMP_PART2;
 ad0:	00ce2503          	lw	a0,12(t3)
  timer_pool[i].expires_at = read_time() + period;
 ad4:	006702b3          	add	t0,a4,t1
 ad8:	00e2b733          	sltu	a4,t0,a4
 adc:	952e                	add	a0,a0,a1
 ade:	078e                	slli	a5,a5,0x3
 ae0:	97c2                	add	a5,a5,a6
 ae2:	972a                	add	a4,a4,a0
  timer_pool[i].active = true;
 ae4:	4385                	li	t2,1
  timer_heap[num_timers - 1] = &timer_pool[i];
 ae6:	00289f13          	slli	t5,a7,0x2
  timer_pool[i].expires_at = read_time() + period;
 aea:	10e7a223          	sw	a4,260(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 aee:	9f42                	add	t5,t5,a6
  num_timers++;
 af0:	00788733          	add	a4,a7,t2
  sift_up(num_timers - 1);
 af4:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + period;
 af6:	1057a023          	sw	t0,256(a5)
  timer_pool[i].period = period;
 afa:	1067a423          	sw	t1,264(a5)
 afe:	10b7a623          	sw	a1,268(a5)
  timer_pool[i].callback_function = cb;
 b02:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 b06:	10778a23          	sb	t2,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 b0a:	00df2023          	sw	a3,0(t5)
 b0e:	c636                	sw	a3,12(sp)
  num_timers++;
 b10:	80e1a623          	sw	a4,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 b14:	3b55                	jal	8c8 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 b16:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 b1a:	46b2                	lw	a3,12(sp)
 b1c:	20000eb7          	lui	t4,0x20000
 b20:	20000e37          	lui	t3,0x20000
 b24:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 b26:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 b28:	00d78663          	beq	a5,a3,b34 <register_isr_periodic+0xaa>
}
 b2c:	40f2                	lw	ra,28(sp)
  return new_handler;
 b2e:	8536                	mv	a0,a3
}
 b30:	6105                	addi	sp,sp,32
 b32:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 b34:	42d8                	lw	a4,4(a3)
 b36:	429c                	lw	a5,0(a3)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 b38:	567d                	li	a2,-1
 b3a:	00ce2023          	sw	a2,0(t3)
}
 b3e:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 b40:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 b44:	00fe2023          	sw	a5,0(t3)
  return new_handler;
 b48:	8536                	mv	a0,a3
}
 b4a:	6105                	addi	sp,sp,32
 b4c:	8082                	ret
    return (irq_timer_handler){};
 b4e:	4501                	li	a0,0
}
 b50:	8082                	ret
    if (timer_pool[i].active == false) {
 b52:	10080693          	addi	a3,a6,256
  int i = 0;
 b56:	4701                	li	a4,0
 b58:	b7b5                	j	ac4 <register_isr_periodic+0x3a>

00000b5a <register_isr_abs>:
  if (num_timers == MAX_TIMERS) {
 b5a:	80c1a883          	lw	a7,-2036(gp) # 1000004c <num_timers>
 b5e:	04000793          	li	a5,64
 b62:	0cf88063          	beq	a7,a5,c22 <register_isr_abs+0xc8>
    if (timer_pool[i].active == false) {
 b66:	83018813          	addi	a6,gp,-2000 # 10000070 <timer_heap>
 b6a:	11484783          	lbu	a5,276(a6)
bool register_isr_abs(uint64_t offset, void *cb) {
 b6e:	1101                	addi	sp,sp,-32
 b70:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 b72:	cbd5                	beqz	a5,c26 <register_isr_abs+0xcc>
 b74:	12c80793          	addi	a5,a6,300
  int i = 0;
 b78:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 b7a:	0007c683          	lbu	a3,0(a5)
 b7e:	07e1                	addi	a5,a5,24
      i++;
 b80:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 b82:	fee5                	bnez	a3,b7a <register_isr_abs+0x20>
  timer_heap[num_timers - 1] = &timer_pool[i];
 b84:	00171793          	slli	a5,a4,0x1
 b88:	00e786b3          	add	a3,a5,a4
 b8c:	068e                	slli	a3,a3,0x3
 b8e:	10080313          	addi	t1,a6,256
 b92:	9336                	add	t1,t1,a3
  uint32_t lo = *TIMER_COMP_PART1;
 b94:	20000e37          	lui	t3,0x20000
 b98:	008e2683          	lw	a3,8(t3) # 20000008 <_stack_top+0xfff0008>
  uint32_t hi = *TIMER_COMP_PART2;
 b9c:	00ce2f83          	lw	t6,12(t3)
  timer_pool[i].expires_at = read_time() + offset;
 ba0:	97ba                	add	a5,a5,a4
 ba2:	00a68733          	add	a4,a3,a0
  timer_pool[i].active = true;
 ba6:	4285                	li	t0,1
  timer_pool[i].expires_at = read_time() + offset;
 ba8:	00bf8533          	add	a0,t6,a1
 bac:	00d736b3          	sltu	a3,a4,a3
  timer_heap[num_timers - 1] = &timer_pool[i];
 bb0:	00289593          	slli	a1,a7,0x2
  timer_pool[i].expires_at = read_time() + offset;
 bb4:	078e                	slli	a5,a5,0x3
 bb6:	97c2                	add	a5,a5,a6
 bb8:	96aa                	add	a3,a3,a0
  timer_heap[num_timers - 1] = &timer_pool[i];
 bba:	95c2                	add	a1,a1,a6
  num_timers++;
 bbc:	00588fb3          	add	t6,a7,t0
  sift_up(num_timers - 1);
 bc0:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + offset;
 bc2:	10d7a223          	sw	a3,260(a5)
 bc6:	10e7a023          	sw	a4,256(a5)
  timer_pool[i].period = 0;
 bca:	1007a423          	sw	zero,264(a5)
 bce:	1007a623          	sw	zero,268(a5)
  timer_pool[i].callback_function = cb;
 bd2:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 bd6:	10578a23          	sb	t0,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 bda:	0065a023          	sw	t1,0(a1)
 bde:	c61a                	sw	t1,12(sp)
  num_timers++;
 be0:	81f1a623          	sw	t6,-2036(gp) # 1000004c <num_timers>
  sift_up(num_timers - 1);
 be4:	31d5                	jal	8c8 <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 be6:	8301a783          	lw	a5,-2000(gp) # 10000070 <timer_heap>
 bea:	4332                	lw	t1,12(sp)
 bec:	20000eb7          	lui	t4,0x20000
 bf0:	20000e37          	lui	t3,0x20000
 bf4:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 bf6:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 bf8:	00678663          	beq	a5,t1,c04 <register_isr_abs+0xaa>
}
 bfc:	40f2                	lw	ra,28(sp)
  return true;
 bfe:	4505                	li	a0,1
}
 c00:	6105                	addi	sp,sp,32
 c02:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 c04:	00432703          	lw	a4,4(t1)
 c08:	00032783          	lw	a5,0(t1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 c0c:	56fd                	li	a3,-1
 c0e:	00de2023          	sw	a3,0(t3)
}
 c12:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 c14:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 c18:	00fe2023          	sw	a5,0(t3)
  return true;
 c1c:	4505                	li	a0,1
}
 c1e:	6105                	addi	sp,sp,32
 c20:	8082                	ret
    return false;
 c22:	4501                	li	a0,0
}
 c24:	8082                	ret
    if (timer_pool[i].active == false) {
 c26:	10080313          	addi	t1,a6,256
  int i = 0;
 c2a:	4701                	li	a4,0
 c2c:	b7a5                	j	b94 <register_isr_abs+0x3a>

00000c2e <deactivate_timer>:
  if (timer == NULL || !timer->active) {
 c2e:	c509                	beqz	a0,c38 <deactivate_timer+0xa>
 c30:	01454783          	lbu	a5,20(a0)
 c34:	c391                	beqz	a5,c38 <deactivate_timer+0xa>
  timer->active = false;
 c36:	b9cd                	j	928 <_deactivate_timer.part.0>
}
 c38:	4501                	li	a0,0
 c3a:	8082                	ret

00000c3c <_deactivate_timer>:
  if (timer == NULL || !timer->active) {
 c3c:	c509                	beqz	a0,c46 <_deactivate_timer+0xa>
 c3e:	01454783          	lbu	a5,20(a0)
 c42:	c391                	beqz	a5,c46 <_deactivate_timer+0xa>
  timer->active = false;
 c44:	b1d5                	j	928 <_deactivate_timer.part.0>
}
 c46:	4501                	li	a0,0
 c48:	8082                	ret

00000c4a <uart_isr>:
ring_buffer_t rx_buffer;
ring_buffer_t tx_buffer;

// Define the Interrupt Service Routine
void uart_isr(void) {
  uint32_t irq_status = *UART_IRQ_STATUS;
 c4a:	200027b7          	lui	a5,0x20002
 c4e:	07d1                	addi	a5,a5,20 # 20002014 <_stack_top+0xfff2014>
 c50:	439c                	lw	a5,0(a5)
void uart_isr(void) {
 c52:	7179                	addi	sp,sp,-48
 c54:	d606                	sw	ra,44(sp)

  // Handle Incoming Data
  if (irq_status & IRQ_RX_AVAIL) {
 c56:	0017f713          	andi	a4,a5,1
 c5a:	e705                	bnez	a4,c82 <uart_isr+0x38>
    char c = (char)(*UART_RX_FIFO);
    insert_rb(&rx_buffer, c); // Push to RX buffer
  }

  // Handle Outgoing Data
  if ((irq_status & IRQ_TX_EMPTY) && (*UART_IRQ_EN & IRQ_TX_EMPTY)) {
 c5c:	0027f713          	andi	a4,a5,2
 c60:	c711                	beqz	a4,c6c <uart_isr+0x22>
 c62:	20002737          	lui	a4,0x20002
 c66:	4b14                	lw	a3,16(a4)
 c68:	8a89                	andi	a3,a3,2
 c6a:	e69d                	bnez	a3,c98 <uart_isr+0x4e>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
    }
  }

  // Handle Hardware Errors
  if (irq_status & (IRQ_RX_OVERRUN | IRQ_FRAME_ERROR)) {
 c6c:	8bb1                	andi	a5,a5,12
 c6e:	c799                	beqz	a5,c7c <uart_isr+0x32>
    *UART_CTRL |= CTRL_CLR_ERRORS; // Clear the hardware error states
 c70:	200027b7          	lui	a5,0x20002
 c74:	47d8                	lw	a4,12(a5)
 c76:	00476713          	ori	a4,a4,4
 c7a:	c7d8                	sw	a4,12(a5)
  }
}
 c7c:	50b2                	lw	ra,44(sp)
 c7e:	6145                	addi	sp,sp,48
 c80:	8082                	ret
    char c = (char)(*UART_RX_FIFO);
 c82:	200026b7          	lui	a3,0x20002
 c86:	428c                	lw	a1,0(a3)
    insert_rb(&rx_buffer, c); // Push to RX buffer
 c88:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 c8c:	0ff5f593          	zext.b	a1,a1
 c90:	c63e                	sw	a5,12(sp)
 c92:	34c1                	jal	752 <insert_rb>
 c94:	47b2                	lw	a5,12(sp)
 c96:	b7d9                	j	c5c <uart_isr+0x12>
    if (pop_rb(&tx_buffer, &c)) {
 c98:	03418513          	addi	a0,gp,52 # 10000874 <tx_buffer>
 c9c:	01f10593          	addi	a1,sp,31
 ca0:	c63e                	sw	a5,12(sp)
 ca2:	3cd9                	jal	778 <pop_rb>
 ca4:	20002737          	lui	a4,0x20002
 ca8:	47b2                	lw	a5,12(sp)
 caa:	0741                	addi	a4,a4,16 # 20002010 <_stack_top+0xfff2010>
 cac:	c519                	beqz	a0,cba <uart_isr+0x70>
      *UART_TX_FIFO = (uint32_t)c;
 cae:	01f14683          	lbu	a3,31(sp)
 cb2:	20002737          	lui	a4,0x20002
 cb6:	c354                	sw	a3,4(a4)
 cb8:	bf55                	j	c6c <uart_isr+0x22>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 cba:	4314                	lw	a3,0(a4)
 cbc:	9af5                	andi	a3,a3,-3
 cbe:	c314                	sw	a3,0(a4)
 cc0:	b775                	j	c6c <uart_isr+0x22>

00000cc2 <uart_init>:

// Initialization function (Call this in main!)
void uart_init(void) {
 cc2:	1141                	addi	sp,sp,-16
  init_ring_buffer(&rx_buffer);
 cc4:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
void uart_init(void) {
 cc8:	c606                	sw	ra,12(sp)
  init_ring_buffer(&rx_buffer);
 cca:	3c95                	jal	73e <init_ring_buffer>
  init_ring_buffer(&tx_buffer);
 ccc:	f3018513          	addi	a0,gp,-208 # 10000770 <rx_buffer>
 cd0:	10450513          	addi	a0,a0,260
 cd4:	34ad                	jal	73e <init_ring_buffer>

  // Register ISR with the MINA PLIC at priority 1
  reg_UART_irq(uart_isr, 1);
 cd6:	4605                	li	a2,1
 cd8:	6505                	lui	a0,0x1
 cda:	85b2                	mv	a1,a2
 cdc:	c4a50513          	addi	a0,a0,-950 # c4a <uart_isr>
 ce0:	4681                	li	a3,0
 ce2:	3425                	jal	70a <reg_irq_handler>

  // Enable the RX interrupt permanently so we never miss incoming data
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 ce4:	200027b7          	lui	a5,0x20002
 ce8:	4b98                	lw	a4,16(a5)
}
 cea:	40b2                	lw	ra,12(sp)
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 cec:	00176713          	ori	a4,a4,1
 cf0:	cb98                	sw	a4,16(a5)
}
 cf2:	0141                	addi	sp,sp,16
 cf4:	8082                	ret

00000cf6 <uart_putc>:

void uart_putc(char c) {
  // 1. Temporarily disable TX interrupts to check state safely
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 cf6:	200027b7          	lui	a5,0x20002
 cfa:	4b94                	lw	a3,16(a5)

  // 2. If the software buffer is empty AND the hardware TX FIFO is empty,
  // bypass the software buffer to kickstart the hardware transmission.
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 cfc:	f3018713          	addi	a4,gp,-208 # 10000770 <rx_buffer>
 d00:	20474583          	lbu	a1,516(a4) # 20002204 <_stack_top+0xfff2204>
 d04:	20574603          	lbu	a2,517(a4)
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 d08:	ffd6f713          	andi	a4,a3,-3
 d0c:	cb98                	sw	a4,16(a5)
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 d0e:	04c58263          	beq	a1,a2,d52 <uart_putc+0x5c>
void uart_putc(char c) {
 d12:	1141                	addi	sp,sp,-16
 d14:	c422                	sw	s0,8(sp)
 d16:	c04a                	sw	s2,0(sp)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
  } else {
    // Try to insert while TX IRQ is masked; if the 256-byte buffer is full,
    // re-enable IRQ_TX_EMPTY while waiting so uart_isr() can drain it!
    while (!insert_rb(&tx_buffer, c)) {
      *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d18:	20002437          	lui	s0,0x20002
void uart_putc(char c) {
 d1c:	c226                	sw	s1,4(sp)
 d1e:	c606                	sw	ra,12(sp)
 d20:	84aa                	mv	s1,a0
 d22:	03418913          	addi	s2,gp,52 # 10000874 <tx_buffer>
      *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d26:	0441                	addi	s0,s0,16 # 20002010 <_stack_top+0xfff2010>
 d28:	a029                	j	d32 <uart_putc+0x3c>
 d2a:	401c                	lw	a5,0(s0)
 d2c:	0027e793          	ori	a5,a5,2
 d30:	c01c                	sw	a5,0(s0)
    while (!insert_rb(&tx_buffer, c)) {
 d32:	85a6                	mv	a1,s1
 d34:	854a                	mv	a0,s2
 d36:	3c31                	jal	752 <insert_rb>
 d38:	d96d                	beqz	a0,d2a <uart_putc+0x34>
    }
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d3a:	200027b7          	lui	a5,0x20002
 d3e:	4b98                	lw	a4,16(a5)
  }
}
 d40:	40b2                	lw	ra,12(sp)
 d42:	4422                	lw	s0,8(sp)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d44:	00276713          	ori	a4,a4,2
 d48:	cb98                	sw	a4,16(a5)
}
 d4a:	4492                	lw	s1,4(sp)
 d4c:	4902                	lw	s2,0(sp)
 d4e:	0141                	addi	sp,sp,16
 d50:	8082                	ret
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 d52:	20002737          	lui	a4,0x20002
 d56:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 d58:	4318                	lw	a4,0(a4)
 d5a:	8b11                	andi	a4,a4,4
 d5c:	db5d                	beqz	a4,d12 <uart_putc+0x1c>
    *UART_TX_FIFO = (uint32_t)c;
 d5e:	20002737          	lui	a4,0x20002
 d62:	c348                	sw	a0,4(a4)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 d64:	4b98                	lw	a4,16(a5)
 d66:	00276713          	ori	a4,a4,2
 d6a:	cb98                	sw	a4,16(a5)
 d6c:	8082                	ret

00000d6e <uart_getc>:

char uart_getc(void) {
 d6e:	1101                	addi	sp,sp,-32
 d70:	cc22                	sw	s0,24(sp)
 d72:	ce06                	sw	ra,28(sp)
 d74:	f3018413          	addi	s0,gp,-208 # 10000770 <rx_buffer>
  char c;
  // Block only when the software buffer is completely empty
  while (!pop_rb(&rx_buffer, &c)) {
 d78:	00f10593          	addi	a1,sp,15
 d7c:	8522                	mv	a0,s0
 d7e:	3aed                	jal	778 <pop_rb>
 d80:	dd65                	beqz	a0,d78 <uart_getc+0xa>
    // Busy wait until the ISR receives new data
  }
  return c;
}
 d82:	40f2                	lw	ra,28(sp)
 d84:	4462                	lw	s0,24(sp)
 d86:	00f14503          	lbu	a0,15(sp)
 d8a:	6105                	addi	sp,sp,32
 d8c:	8082                	ret

00000d8e <uart_puts>:

void uart_puts(const char *str) {
 d8e:	1141                	addi	sp,sp,-16
 d90:	c422                	sw	s0,8(sp)
 d92:	c606                	sw	ra,12(sp)
 d94:	842a                	mv	s0,a0
  while (*str != '\0') {
 d96:	00054503          	lbu	a0,0(a0)
 d9a:	c511                	beqz	a0,da6 <uart_puts+0x18>
    uart_putc(*str);
 d9c:	3fa9                	jal	cf6 <uart_putc>
  while (*str != '\0') {
 d9e:	00144503          	lbu	a0,1(s0)
    str++;
 da2:	0405                	addi	s0,s0,1
  while (*str != '\0') {
 da4:	fd65                	bnez	a0,d9c <uart_puts+0xe>
  }
}
 da6:	40b2                	lw	ra,12(sp)
 da8:	4422                	lw	s0,8(sp)
 daa:	0141                	addi	sp,sp,16
 dac:	8082                	ret

00000dae <uart_polled_putc>:

void uart_polled_putc(char c) {
  // Wait directly on the hardware status register until TX FIFO is empty
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dae:	20002737          	lui	a4,0x20002
 db2:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 db4:	431c                	lw	a5,0(a4)
 db6:	8b91                	andi	a5,a5,4
 db8:	dff5                	beqz	a5,db4 <uart_polled_putc+0x6>
    ;
  *UART_TX_FIFO = (uint32_t)c;
 dba:	200027b7          	lui	a5,0x20002
 dbe:	c3c8                	sw	a0,4(a5)
}
 dc0:	8082                	ret

00000dc2 <uart_polled_puts>:

void uart_polled_puts(const char *str) {
  while (*str != '\0') {
 dc2:	00054683          	lbu	a3,0(a0)
 dc6:	ce99                	beqz	a3,de4 <uart_polled_puts+0x22>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dc8:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 dcc:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dd0:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 dd2:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dd4:	431c                	lw	a5,0(a4)
 dd6:	8b91                	andi	a5,a5,4
 dd8:	dff5                	beqz	a5,dd4 <uart_polled_puts+0x12>
  *UART_TX_FIFO = (uint32_t)c;
 dda:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 ddc:	00154683          	lbu	a3,1(a0)
    uart_polled_putc(*str);
    str++;
 de0:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 de2:	faed                	bnez	a3,dd4 <uart_polled_puts+0x12>
  }
}
 de4:	8082                	ret

00000de6 <uart_print_hex>:
  while (*str != '\0') {
 de6:	00054683          	lbu	a3,0(a0)

void uart_print_hex(const char *prefix, uint32_t val) {
 dea:	1141                	addi	sp,sp,-16
  while (*str != '\0') {
 dec:	ce99                	beqz	a3,e0a <uart_print_hex+0x24>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dee:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 df2:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 df6:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 df8:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 dfa:	431c                	lw	a5,0(a4)
 dfc:	8b91                	andi	a5,a5,4
 dfe:	dff5                	beqz	a5,dfa <uart_print_hex+0x14>
  *UART_TX_FIFO = (uint32_t)c;
 e00:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 e02:	00154683          	lbu	a3,1(a0)
    str++;
 e06:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 e08:	faed                	bnez	a3,dfa <uart_print_hex+0x14>
  uart_polled_puts(prefix);
  char buf[9];
  buf[8] = '\0';
 e0a:	00010623          	sb	zero,12(sp)
  for (int i = 7; i >= 0; i--) {
 e0e:	005c                	addi	a5,sp,4
 e10:	ffc10513          	addi	a0,sp,-4
    uint32_t nibble = val & 0xF;
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 e14:	4625                	li	a2,9
    uint32_t nibble = val & 0xF;
 e16:	00f5f713          	andi	a4,a1,15
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 e1a:	05770693          	addi	a3,a4,87
 e1e:	00e66463          	bltu	a2,a4,e26 <uart_print_hex+0x40>
 e22:	03070693          	addi	a3,a4,48
 e26:	00d783a3          	sb	a3,7(a5) # 20002007 <_stack_top+0xfff2007>
  for (int i = 7; i >= 0; i--) {
 e2a:	17fd                	addi	a5,a5,-1
    val >>= 4;
 e2c:	8191                	srli	a1,a1,0x4
  for (int i = 7; i >= 0; i--) {
 e2e:	fef514e3          	bne	a0,a5,e16 <uart_print_hex+0x30>
  while (*str != '\0') {
 e32:	00414683          	lbu	a3,4(sp)
 e36:	c285                	beqz	a3,e56 <uart_print_hex+0x70>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e38:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 e3c:	200025b7          	lui	a1,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e40:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 e42:	0591                	addi	a1,a1,4 # 20002004 <_stack_top+0xfff2004>
  while (*str != '\0') {
 e44:	0050                	addi	a2,sp,4
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e46:	431c                	lw	a5,0(a4)
 e48:	8b91                	andi	a5,a5,4
 e4a:	dff5                	beqz	a5,e46 <uart_print_hex+0x60>
  *UART_TX_FIFO = (uint32_t)c;
 e4c:	c194                	sw	a3,0(a1)
  while (*str != '\0') {
 e4e:	00164683          	lbu	a3,1(a2)
    str++;
 e52:	0605                	addi	a2,a2,1
  while (*str != '\0') {
 e54:	faed                	bnez	a3,e46 <uart_print_hex+0x60>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e56:	20002737          	lui	a4,0x20002
 e5a:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 e5c:	431c                	lw	a5,0(a4)
 e5e:	8b91                	andi	a5,a5,4
 e60:	dff5                	beqz	a5,e5c <uart_print_hex+0x76>
  *UART_TX_FIFO = (uint32_t)c;
 e62:	200027b7          	lui	a5,0x20002
 e66:	46b5                	li	a3,13
 e68:	c3d4                	sw	a3,4(a5)
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 e6a:	00878713          	addi	a4,a5,8 # 20002008 <_stack_top+0xfff2008>
 e6e:	431c                	lw	a5,0(a4)
 e70:	8b91                	andi	a5,a5,4
 e72:	dff5                	beqz	a5,e6e <uart_print_hex+0x88>
  *UART_TX_FIFO = (uint32_t)c;
 e74:	200027b7          	lui	a5,0x20002
 e78:	4729                	li	a4,10
 e7a:	c3d8                	sw	a4,4(a5)
  }
  uart_polled_puts(buf);
  uart_polled_puts("\r\n");
}
 e7c:	0141                	addi	sp,sp,16
 e7e:	8082                	ret
