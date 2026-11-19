
/tmp/mina_build_hU95tl/firmware.elf:     file format elf32-littleriscv


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
  18:	e3c50513          	addi	a0,a0,-452 # e50 <_data_load_start>
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
  56:	c3658593          	addi	a1,a1,-970 # 10000c88 <_ebss>
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
  68:	200d                	jal	8a <main>

0000006a <inf_loop>:

    /* 7. Catch return from main (should not happen in bare-metal) */
inf_loop:
    j inf_loop
  6a:	a001                	j	6a <inf_loop>

0000006c <npu_irq_handler>:
    // Wait for fetch_halted before host accesses scratchpad RAM
  }
}

void npu_irq_handler(void) {
  NPU_HALT();
  6c:	40000737          	lui	a4,0x40000
  70:	00072023          	sw	zero,0(a4) # 40000000 <_stack_top+0x2fff0000>
  NPU_CLEAR_IRQ();
  74:	431c                	lw	a5,0(a4)
  npu_done_flag = 1;
  76:	4605                	li	a2,1
  78:	100006b7          	lui	a3,0x10000
  NPU_CLEAR_IRQ();
  7c:	8ff1                	and	a5,a5,a2
  7e:	0087e793          	ori	a5,a5,8
  82:	c31c                	sw	a5,0(a4)
  npu_done_flag = 1;
  84:	04c6a023          	sw	a2,64(a3) # 10000040 <npu_done_flag>
}
  88:	8082                	ret

0000008a <main>:
  for (uint32_t lane = 0; lane < 2u; ++lane) {
    uart_putc(format_output_byte((uint8_t)(w2 >> (8u * lane))));
  }
}

int main(void) {
  8a:	7139                	addi	sp,sp,-64
  // 1. Put NPU in a known halted/reset state and clear any stale IRQ
  NPU_HALT();
  8c:	400007b7          	lui	a5,0x40000
int main(void) {
  90:	de06                	sw	ra,60(sp)
  92:	dc22                	sw	s0,56(sp)
  94:	da26                	sw	s1,52(sp)
  96:	d84a                	sw	s2,48(sp)
  98:	d64e                	sw	s3,44(sp)
  9a:	d452                	sw	s4,40(sp)
  9c:	d256                	sw	s5,36(sp)
  9e:	d05a                	sw	s6,32(sp)
  a0:	ce5e                	sw	s7,28(sp)
  a2:	cc62                	sw	s8,24(sp)
  a4:	ca66                	sw	s9,20(sp)
  a6:	c86a                	sw	s10,16(sp)
  a8:	c66e                	sw	s11,12(sp)
  NPU_HALT();
  aa:	0007a023          	sw	zero,0(a5) # 40000000 <_stack_top+0x2fff0000>
  NPU_RESET();
  ae:	4709                	li	a4,2
  b0:	c398                	sw	a4,0(a5)
  NPU_CLEAR_IRQ();
  b2:	4398                	lw	a4,0(a5)
  while (!NPU_IS_HALTED()) {
  b4:	00478693          	addi	a3,a5,4
  NPU_CLEAR_IRQ();
  b8:	8b05                	andi	a4,a4,1
  ba:	00876713          	ori	a4,a4,8
  be:	c398                	sw	a4,0(a5)
  NPU_HALT();
  c0:	0007a023          	sw	zero,0(a5)
  while (!NPU_IS_HALTED()) {
  c4:	429c                	lw	a5,0(a3)
  c6:	8b85                	andi	a5,a5,1
  c8:	dff5                	beqz	a5,c4 <main+0x3a>
  npu_wait_halted();

  // 2. Initialize CPU interrupts and UART driver
  init_interrupts();
  ca:	2249                	jal	24c <init_interrupts>
  uart_init();
  cc:	31b000ef          	jal	be6 <uart_init>
  reg_NPU_irq(npu_irq_handler, 1);
  d0:	06c00513          	li	a0,108
  d4:	4691                	li	a3,4
  d6:	4641                	li	a2,16
  d8:	4585                	li	a1,1
  da:	2391                	jal	61e <reg_irq_handler>
  for (uint32_t i = 0; i < total_words; ++i) {
  dc:	40302737          	lui	a4,0x40302
  e0:	88070713          	addi	a4,a4,-1920 # 40301880 <_stack_top+0x302f1880>
  reg_NPU_irq(npu_irq_handler, 1);
  e4:	403007b7          	lui	a5,0x40300
    sp[i] = 0u;
  e8:	0007a023          	sw	zero,0(a5) # 40300000 <_stack_top+0x302f0000>
  for (uint32_t i = 0; i < total_words; ++i) {
  ec:	0791                	addi	a5,a5,4
  ee:	fee79de3          	bne	a5,a4,e8 <main+0x5e>
  while (!NPU_IS_HALTED()) {
  f2:	400009b7          	lui	s3,0x40000
  f6:	80c18413          	addi	s0,gp,-2036 # 1000004c <rx_image>
  fa:	b1c18493          	addi	s1,gp,-1252 # 1000035c <plic_irq_handlers>
  fe:	0991                	addi	s3,s3,4 # 40000004 <_stack_top+0x2fff0004>
 100:	10000a37          	lui	s4,0x10000
  NPU_HALT();
 104:	40000ab7          	lui	s5,0x40000
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 108:	02000b93          	li	s7,32
  for (uint32_t tile = 0; tile < MNIST_TILES; ++tile) {
 10c:	31800913          	li	s2,792
    npu_wait_halted();
    load_image_to_npu(rx_image);

    // Reset PC to 0 and run inference
    npu_done_flag = 0;
    NPU_RESET();
 110:	4b09                	li	s6,2
  reg_NPU_irq(npu_irq_handler, 1);
 112:	8c22                	mv	s8,s0
    buf[i] = (uint8_t)uart_getc();
 114:	37f000ef          	jal	c92 <uart_getc>
 118:	00ac0023          	sb	a0,0(s8)
  for (uint32_t i = 0; i < MNIST_PIXELS; ++i) {
 11c:	0c05                	addi	s8,s8,1
 11e:	ff849be3          	bne	s1,s8,114 <main+0x8a>
  NPU_HALT();
 122:	000aa023          	sw	zero,0(s5) # 40000000 <_stack_top+0x2fff0000>
  while (!NPU_IS_HALTED()) {
 126:	0009a783          	lw	a5,0(s3)
 12a:	8b85                	andi	a5,a5,1
 12c:	dfed                	beqz	a5,126 <main+0x9c>
 12e:	403008b7          	lui	a7,0x40300
 132:	4821                	li	a6,8
    for (uint32_t half = 0; half < WORDS_PER_VEC; ++half) {
 134:	ff880593          	addi	a1,a6,-8
      uint32_t packed = 0u;
 138:	8546                	mv	a0,a7
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 13a:	00b406b3          	add	a3,s0,a1
  while (!NPU_IS_HALTED()) {
 13e:	4701                	li	a4,0
      uint32_t packed = 0u;
 140:	4601                	li	a2,0
        uint8_t val = px[half * 4u + lane];
 142:	0006c783          	lbu	a5,0(a3)
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 146:	0685                	addi	a3,a3,1
        packed |= ((uint32_t)val << (8u * lane));
 148:	8385                	srli	a5,a5,0x1
 14a:	00e797b3          	sll	a5,a5,a4
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 14e:	0721                	addi	a4,a4,8
        packed |= ((uint32_t)val << (8u * lane));
 150:	8e5d                	or	a2,a2,a5
      for (uint32_t lane = 0; lane < 4u; ++lane) {
 152:	ff7718e3          	bne	a4,s7,142 <main+0xb8>
      sp[word_base + half] = packed;
 156:	c110                	sw	a2,0(a0)
    for (uint32_t half = 0; half < WORDS_PER_VEC; ++half) {
 158:	0591                	addi	a1,a1,4
 15a:	0511                	addi	a0,a0,4
 15c:	fd059fe3          	bne	a1,a6,13a <main+0xb0>
  for (uint32_t tile = 0; tile < MNIST_TILES; ++tile) {
 160:	00858813          	addi	a6,a1,8
 164:	04088893          	addi	a7,a7,64 # 40300040 <_stack_top+0x302f0040>
 168:	fd2816e3          	bne	a6,s2,134 <main+0xaa>
    npu_done_flag = 0;
 16c:	040a2023          	sw	zero,64(s4) # 10000040 <npu_done_flag>
    NPU_RESET();
 170:	016aa023          	sw	s6,0(s5)
  NPU_HALT();
 174:	000aa023          	sw	zero,0(s5)
  while (!NPU_IS_HALTED()) {
 178:	0009a783          	lw	a5,0(s3)
 17c:	8b85                	andi	a5,a5,1
 17e:	dfed                	beqz	a5,178 <main+0xee>
    npu_wait_halted();
    NPU_START();
 180:	4785                	li	a5,1
 182:	00faa023          	sw	a5,0(s5)

    // Wait for TRG_INT interrupt from NPU
    while (!npu_done_flag) {
 186:	040a2783          	lw	a5,64(s4)
 18a:	dff5                	beqz	a5,186 <main+0xfc>
      // Wait for completion
    }
    npu_done_flag = 0;
 18c:	040a2023          	sw	zero,64(s4)
  NPU_HALT();
 190:	000aa023          	sw	zero,0(s5)
  while (!NPU_IS_HALTED()) {
 194:	0009a783          	lw	a5,0(s3)
 198:	8b85                	andi	a5,a5,1
 19a:	dfed                	beqz	a5,194 <main+0x10a>
  uint32_t w0 = sp[t0_word_base + 0u]; // digits 0..3
 19c:	403026b7          	lui	a3,0x40302
 1a0:	9806ad03          	lw	s10,-1664(a3) # 40301980 <_stack_top+0x302f1980>
  uint32_t w1 = sp[t0_word_base + 1u]; // digits 4..7
 1a4:	9846ac83          	lw	s9,-1660(a3)
  uint32_t w2 = sp[t1_word_base + 0u]; // digits 8..9 (+ 2 pad bytes)
 1a8:	9c06ac03          	lw	s8,-1600(a3)
 1ac:	4d81                	li	s11,0
    uart_putc(format_output_byte((uint8_t)(w0 >> (8u * lane))));
 1ae:	01bd57b3          	srl	a5,s10,s11
             : (uint8_t)(s << 1); // Map 0..127 -> 0..254 for full bar height
 1b2:	01879713          	slli	a4,a5,0x18
 1b6:	8761                	srai	a4,a4,0x18
 1b8:	0786                	slli	a5,a5,0x1
 1ba:	4501                	li	a0,0
 1bc:	00074463          	bltz	a4,1c4 <main+0x13a>
 1c0:	0ff7f513          	zext.b	a0,a5
  for (uint32_t lane = 0; lane < 4u; ++lane) {
 1c4:	0da1                	addi	s11,s11,8
    uart_putc(format_output_byte((uint8_t)(w0 >> (8u * lane))));
 1c6:	255000ef          	jal	c1a <uart_putc>
  for (uint32_t lane = 0; lane < 4u; ++lane) {
 1ca:	ff7d92e3          	bne	s11,s7,1ae <main+0x124>
 1ce:	4d01                	li	s10,0
    uart_putc(format_output_byte((uint8_t)(w1 >> (8u * lane))));
 1d0:	01acd7b3          	srl	a5,s9,s10
             : (uint8_t)(s << 1); // Map 0..127 -> 0..254 for full bar height
 1d4:	01879713          	slli	a4,a5,0x18
 1d8:	8761                	srai	a4,a4,0x18
 1da:	0786                	slli	a5,a5,0x1
 1dc:	4501                	li	a0,0
 1de:	00074463          	bltz	a4,1e6 <main+0x15c>
 1e2:	0ff7f513          	zext.b	a0,a5
  for (uint32_t lane = 0; lane < 4u; ++lane) {
 1e6:	0d21                	addi	s10,s10,8
    uart_putc(format_output_byte((uint8_t)(w1 >> (8u * lane))));
 1e8:	233000ef          	jal	c1a <uart_putc>
  for (uint32_t lane = 0; lane < 4u; ++lane) {
 1ec:	ff7d12e3          	bne	s10,s7,1d0 <main+0x146>
             : (uint8_t)(s << 1); // Map 0..127 -> 0..254 for full bar height
 1f0:	018c1793          	slli	a5,s8,0x18
 1f4:	87e1                	srai	a5,a5,0x18
 1f6:	4501                	li	a0,0
 1f8:	0007c663          	bltz	a5,204 <main+0x17a>
 1fc:	001c1513          	slli	a0,s8,0x1
 200:	0ff57513          	zext.b	a0,a0
    uart_putc(format_output_byte((uint8_t)(w2 >> (8u * lane))));
 204:	217000ef          	jal	c1a <uart_putc>
 208:	008c5c13          	srli	s8,s8,0x8
             : (uint8_t)(s << 1); // Map 0..127 -> 0..254 for full bar height
 20c:	018c1793          	slli	a5,s8,0x18
 210:	87e1                	srai	a5,a5,0x18
 212:	4501                	li	a0,0
 214:	0007c563          	bltz	a5,21e <main+0x194>
 218:	0c06                	slli	s8,s8,0x1
 21a:	0ffc7513          	zext.b	a0,s8
    uart_putc(format_output_byte((uint8_t)(w2 >> (8u * lane))));
 21e:	1fd000ef          	jal	c1a <uart_putc>
  for (uint32_t lane = 0; lane < 2u; ++lane) {
 222:	bdc5                	j	112 <main+0x88>

00000224 <set_input>:
#include "../include/gpio.h"

void set_input(int gpio_num) { *GPIO_T |= (1 << gpio_num); }
 224:	20003737          	lui	a4,0x20003
 228:	4354                	lw	a3,4(a4)
 22a:	4785                	li	a5,1
 22c:	00a797b3          	sll	a5,a5,a0
 230:	8fd5                	or	a5,a5,a3
 232:	c35c                	sw	a5,4(a4)
 234:	8082                	ret

00000236 <set_output>:
void set_output(int gpio_num) { *GPIO_T &= ~(1 << gpio_num); }
 236:	20003737          	lui	a4,0x20003
 23a:	4354                	lw	a3,4(a4)
 23c:	4785                	li	a5,1
 23e:	00a797b3          	sll	a5,a5,a0
 242:	fff7c793          	not	a5,a5
 246:	8ff5                	and	a5,a5,a3
 248:	c35c                	sw	a5,4(a4)
 24a:	8082                	ret

0000024c <init_interrupts>:
int plic_idx_sort[8] = {0, 1, 2, 3, 4, 5, 6, 7};
void (*timer_irq_handler)(void) = NULL;

void init_interrupts(void) {
  // A. Point mtvec to our handler (Direct mode: lowest 2 bits are 00)
  write_csr(mtvec, (unsigned long)trap_handler);
 24c:	2e400793          	li	a5,740
 250:	30579073          	csrw	mtvec,a5

  // B. Enable Machine External Interrupts in the 'mie' register
  set_csr(mie, MIE_MEIE);
 254:	6785                	lui	a5,0x1
 256:	80078793          	addi	a5,a5,-2048 # 800 <sift_up+0x24>
 25a:	3047a7f3          	csrrs	a5,mie,a5

  // C. Enable Global Machine Interrupts in the 'mstatus' register
  set_csr(mstatus, MSTATUS_MIE);
 25e:	300467f3          	csrrsi	a5,mstatus,8
}
 262:	8082                	ret

00000264 <plic_irq_handler>:
      // Hang indefinitely for debugger attachment
    }
  }
}

void plic_irq_handler(void) {
 264:	7179                	addi	sp,sp,-48

  uint32_t pending = *PLIC_IRQ_PEND;
 266:	200007b7          	lui	a5,0x20000
void plic_irq_handler(void) {
 26a:	c85a                	sw	s6,16(sp)
 26c:	c65e                	sw	s7,12(sp)
 26e:	10000b37          	lui	s6,0x10000
  uint32_t pending = *PLIC_IRQ_PEND;
 272:	0047ab83          	lw	s7,4(a5) # 20000004 <_stack_top+0xfff0004>

  for (int i = 0; i < 8; i++) {
 276:	000b0b13          	mv	s6,s6
void plic_irq_handler(void) {
 27a:	d04a                	sw	s2,32(sp)
 27c:	ca56                	sw	s5,20(sp)
          plic_irq_priorities[current_idx] != -1) {
        plic_irq_handlers[current_idx]();

        // THIS ASSUMES THE HANDLER CLEARS THE STATE CAUSING THE INTERRUPT,
        // OTHERWISE THE IRQ WILL TRIGGER AGAIN
        *PLIC_CLAIM_REG = 1 << current_idx;
 27e:	20000ab7          	lui	s5,0x20000
void plic_irq_handler(void) {
 282:	d226                	sw	s1,36(sp)
 284:	ce4e                	sw	s3,28(sp)
 286:	cc52                	sw	s4,24(sp)
 288:	c462                	sw	s8,8(sp)
 28a:	d606                	sw	ra,44(sp)
 28c:	d422                	sw	s0,40(sp)
 28e:	84da                	mv	s1,s6
 290:	020b0a13          	addi	s4,s6,32 # 10000020 <plic_irq_priorities>
      if (plic_irq_handlers[current_idx] &&
 294:	b1c18913          	addi	s2,gp,-1252 # 1000035c <plic_irq_handlers>
        *PLIC_CLAIM_REG = 1 << current_idx;
 298:	0aa1                	addi	s5,s5,8 # 20000008 <_stack_top+0xfff0008>
    if ((pending & (1 << current_idx)) != 0) {
 29a:	4985                	li	s3,1
      if (plic_irq_handlers[current_idx] &&
 29c:	5c7d                	li	s8,-1
    int current_idx = plic_idx_sort[i];
 29e:	409c                	lw	a5,0(s1)
    if ((pending & (1 << current_idx)) != 0) {
 2a0:	00f99433          	sll	s0,s3,a5
      if (plic_irq_handlers[current_idx] &&
 2a4:	00279713          	slli	a4,a5,0x2
    if ((pending & (1 << current_idx)) != 0) {
 2a8:	017477b3          	and	a5,s0,s7
      if (plic_irq_handlers[current_idx] &&
 2ac:	00e906b3          	add	a3,s2,a4
    if ((pending & (1 << current_idx)) != 0) {
 2b0:	cb91                	beqz	a5,2c4 <plic_irq_handler+0x60>
      if (plic_irq_handlers[current_idx] &&
 2b2:	429c                	lw	a5,0(a3)
          plic_irq_priorities[current_idx] != -1) {
 2b4:	975a                	add	a4,a4,s6
      if (plic_irq_handlers[current_idx] &&
 2b6:	c799                	beqz	a5,2c4 <plic_irq_handler+0x60>
 2b8:	5318                	lw	a4,32(a4)
 2ba:	01870563          	beq	a4,s8,2c4 <plic_irq_handler+0x60>
        plic_irq_handlers[current_idx]();
 2be:	9782                	jalr	a5
        *PLIC_CLAIM_REG = 1 << current_idx;
 2c0:	008aa023          	sw	s0,0(s5)
  for (int i = 0; i < 8; i++) {
 2c4:	0491                	addi	s1,s1,4
 2c6:	fd449ce3          	bne	s1,s4,29e <plic_irq_handler+0x3a>
      }
    }
  }
}
 2ca:	50b2                	lw	ra,44(sp)
 2cc:	5422                	lw	s0,40(sp)
 2ce:	5492                	lw	s1,36(sp)
 2d0:	5902                	lw	s2,32(sp)
 2d2:	49f2                	lw	s3,28(sp)
 2d4:	4a62                	lw	s4,24(sp)
 2d6:	4ad2                	lw	s5,20(sp)
 2d8:	4b42                	lw	s6,16(sp)
 2da:	4bb2                	lw	s7,12(sp)
 2dc:	4c22                	lw	s8,8(sp)
 2de:	6145                	addi	sp,sp,48
 2e0:	8082                	ret
 2e2:	0001                	nop

000002e4 <trap_handler>:
void __attribute__((interrupt("machine"), aligned(4))) trap_handler(void) {
 2e4:	7171                	addi	sp,sp,-176
 2e6:	d706                	sw	ra,172(sp)
 2e8:	d516                	sw	t0,168(sp)
 2ea:	003022f3          	frcsr	t0
 2ee:	d316                	sw	t0,164(sp)
 2f0:	d11a                	sw	t1,160(sp)
 2f2:	cf1e                	sw	t2,156(sp)
 2f4:	cd22                	sw	s0,152(sp)
 2f6:	cb26                	sw	s1,148(sp)
 2f8:	c92a                	sw	a0,144(sp)
 2fa:	c72e                	sw	a1,140(sp)
 2fc:	c532                	sw	a2,136(sp)
 2fe:	c336                	sw	a3,132(sp)
 300:	c13a                	sw	a4,128(sp)
 302:	debe                	sw	a5,124(sp)
 304:	dcc2                	sw	a6,120(sp)
 306:	dac6                	sw	a7,116(sp)
 308:	d8ca                	sw	s2,112(sp)
 30a:	d6ce                	sw	s3,108(sp)
 30c:	d4f2                	sw	t3,104(sp)
 30e:	d2f6                	sw	t4,100(sp)
 310:	d0fa                	sw	t5,96(sp)
 312:	cefe                	sw	t6,92(sp)
 314:	e682                	fsw	ft0,76(sp)
 316:	e486                	fsw	ft1,72(sp)
 318:	e28a                	fsw	ft2,68(sp)
 31a:	e08e                	fsw	ft3,64(sp)
 31c:	fe12                	fsw	ft4,60(sp)
 31e:	fc16                	fsw	ft5,56(sp)
 320:	fa1a                	fsw	ft6,52(sp)
 322:	f81e                	fsw	ft7,48(sp)
 324:	f62a                	fsw	fa0,44(sp)
 326:	f42e                	fsw	fa1,40(sp)
 328:	f232                	fsw	fa2,36(sp)
 32a:	f036                	fsw	fa3,32(sp)
 32c:	ee3a                	fsw	fa4,28(sp)
 32e:	ec3e                	fsw	fa5,24(sp)
 330:	ea42                	fsw	fa6,20(sp)
 332:	e846                	fsw	fa7,16(sp)
 334:	e672                	fsw	ft8,12(sp)
 336:	e476                	fsw	ft9,8(sp)
 338:	e27a                	fsw	ft10,4(sp)
 33a:	e07e                	fsw	ft11,0(sp)
  unsigned long cause = read_csr(mcause);
 33c:	34202473          	csrr	s0,mcause
  if ((long)cause < 0) {
 340:	06045963          	bgez	s0,3b2 <trap_handler+0xce>
    unsigned long exception_code = cause & ~(1UL << (sizeof(long) * 8 - 1));
 344:	00141793          	slli	a5,s0,0x1
 348:	8385                	srli	a5,a5,0x1
    if (exception_code == IRQ_M_EXT) {
 34a:	472d                	li	a4,11
 34c:	0ce78f63          	beq	a5,a4,42a <trap_handler+0x146>
    } else if (exception_code == IRQ_M_TIMER) {
 350:	471d                	li	a4,7
 352:	0ce78e63          	beq	a5,a4,42e <trap_handler+0x14a>
}
 356:	50ba                	lw	ra,172(sp)
 358:	529a                	lw	t0,164(sp)
 35a:	00329073          	fscsr	t0
 35e:	446a                	lw	s0,152(sp)
 360:	52aa                	lw	t0,168(sp)
 362:	530a                	lw	t1,160(sp)
 364:	43fa                	lw	t2,156(sp)
 366:	44da                	lw	s1,148(sp)
 368:	454a                	lw	a0,144(sp)
 36a:	45ba                	lw	a1,140(sp)
 36c:	462a                	lw	a2,136(sp)
 36e:	469a                	lw	a3,132(sp)
 370:	470a                	lw	a4,128(sp)
 372:	57f6                	lw	a5,124(sp)
 374:	5866                	lw	a6,120(sp)
 376:	58d6                	lw	a7,116(sp)
 378:	5946                	lw	s2,112(sp)
 37a:	59b6                	lw	s3,108(sp)
 37c:	5e26                	lw	t3,104(sp)
 37e:	5e96                	lw	t4,100(sp)
 380:	5f06                	lw	t5,96(sp)
 382:	4ff6                	lw	t6,92(sp)
 384:	6036                	flw	ft0,76(sp)
 386:	60a6                	flw	ft1,72(sp)
 388:	6116                	flw	ft2,68(sp)
 38a:	6186                	flw	ft3,64(sp)
 38c:	7272                	flw	ft4,60(sp)
 38e:	72e2                	flw	ft5,56(sp)
 390:	7352                	flw	ft6,52(sp)
 392:	73c2                	flw	ft7,48(sp)
 394:	7532                	flw	fa0,44(sp)
 396:	75a2                	flw	fa1,40(sp)
 398:	7612                	flw	fa2,36(sp)
 39a:	7682                	flw	fa3,32(sp)
 39c:	6772                	flw	fa4,28(sp)
 39e:	67e2                	flw	fa5,24(sp)
 3a0:	6852                	flw	fa6,20(sp)
 3a2:	68c2                	flw	fa7,16(sp)
 3a4:	6e32                	flw	ft8,12(sp)
 3a6:	6ea2                	flw	ft9,8(sp)
 3a8:	6f12                	flw	ft10,4(sp)
 3aa:	6f82                	flw	ft11,0(sp)
 3ac:	614d                	addi	sp,sp,176
 3ae:	30200073          	mret
    uart_polled_puts("\r\n\r\n=== CPU EXCEPTION / CRASH DETECTED ===\r\n");
 3b2:	6505                	lui	a0,0x1
 3b4:	da450513          	addi	a0,a0,-604 # da4 <uart_print_hex+0x9a>
 3b8:	12f000ef          	jal	ce6 <uart_polled_puts>
    uart_print_hex("mcause: 0x", (uint32_t)cause);
 3bc:	6505                	lui	a0,0x1
 3be:	85a2                	mv	a1,s0
 3c0:	dd450513          	addi	a0,a0,-556 # dd4 <uart_print_hex+0xca>
 3c4:	147000ef          	jal	d0a <uart_print_hex>
    uart_print_hex("mepc  : 0x", (uint32_t)read_csr(mepc));
 3c8:	341025f3          	csrr	a1,mepc
 3cc:	6505                	lui	a0,0x1
 3ce:	de050513          	addi	a0,a0,-544 # de0 <uart_print_hex+0xd6>
 3d2:	139000ef          	jal	d0a <uart_print_hex>
    uart_print_hex("mtval : 0x", (uint32_t)read_csr(mtval));
 3d6:	343025f3          	csrr	a1,mtval
 3da:	6505                	lui	a0,0x1
 3dc:	dec50513          	addi	a0,a0,-532 # dec <uart_print_hex+0xe2>
 3e0:	12b000ef          	jal	d0a <uart_print_hex>
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 3e4:	6505                	lui	a0,0x1
    while (stack_ptr < stack_top_ptr) {
 3e6:	100104b7          	lui	s1,0x10010
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 3ea:	df850513          	addi	a0,a0,-520 # df8 <uart_print_hex+0xee>
    while (stack_ptr < stack_top_ptr) {
 3ee:	00048493          	mv	s1,s1
    uart_polled_puts("--- Stack Backtrace Search ---\r\n");
 3f2:	0f5000ef          	jal	ce6 <uart_polled_puts>
    while (stack_ptr < stack_top_ptr) {
 3f6:	02917463          	bgeu	sp,s1,41e <trap_handler+0x13a>
 3fa:	6785                	lui	a5,0x1
        uart_print_hex("  from instruction addr: 0x", val);
 3fc:	e1c78993          	addi	s3,a5,-484 # e1c <uart_print_hex+0x112>
 400:	840a                	mv	s0,sp
      if (val >= 0x00000000 && val < 0x00004000) {
 402:	6911                	lui	s2,0x4
 404:	a021                	j	40c <trap_handler+0x128>
    while (stack_ptr < stack_top_ptr) {
 406:	0411                	addi	s0,s0,4
 408:	00947b63          	bgeu	s0,s1,41e <trap_handler+0x13a>
      uint32_t val = *stack_ptr;
 40c:	400c                	lw	a1,0(s0)
      if (val >= 0x00000000 && val < 0x00004000) {
 40e:	ff25fce3          	bgeu	a1,s2,406 <trap_handler+0x122>
        uart_print_hex("  from instruction addr: 0x", val);
 412:	854e                	mv	a0,s3
    while (stack_ptr < stack_top_ptr) {
 414:	0411                	addi	s0,s0,4
        uart_print_hex("  from instruction addr: 0x", val);
 416:	0f5000ef          	jal	d0a <uart_print_hex>
    while (stack_ptr < stack_top_ptr) {
 41a:	fe9469e3          	bltu	s0,s1,40c <trap_handler+0x128>
    uart_polled_puts("System halted.\r\n");
 41e:	6505                	lui	a0,0x1
 420:	e3850513          	addi	a0,a0,-456 # e38 <uart_print_hex+0x12e>
 424:	0c3000ef          	jal	ce6 <uart_polled_puts>
    while (1) {
 428:	a001                	j	428 <trap_handler+0x144>
      plic_irq_handler();
 42a:	3d2d                	jal	264 <plic_irq_handler>
 42c:	b72d                	j	356 <trap_handler+0x72>
      if (timer_irq_handler) {
 42e:	100007b7          	lui	a5,0x10000
 432:	0447a783          	lw	a5,68(a5) # 10000044 <timer_irq_handler>
 436:	f20780e3          	beqz	a5,356 <trap_handler+0x72>
        timer_irq_handler();
 43a:	9782                	jalr	a5
 43c:	bf29                	j	356 <trap_handler+0x72>

0000043e <resort_by_prior>:
  *PLIC_IRQ_ACTV |= actv_mask;

  resort_by_prior();
}

void resort_by_prior() {
 43e:	1141                	addi	sp,sp,-16

  for (int i = 0; i < 8; i++) {
    plic_idx_sort[i] = i;
 440:	100007b7          	lui	a5,0x10000
 444:	00078793          	mv	a5,a5
void resort_by_prior() {
 448:	c622                	sw	s0,12(sp)
 44a:	c426                	sw	s1,8(sp)
 44c:	c24a                	sw	s2,4(sp)
 44e:	c04e                	sw	s3,0(sp)
    plic_idx_sort[i] = i;
 450:	4709                	li	a4,2
 452:	c798                	sw	a4,8(a5)
 454:	470d                	li	a4,3
 456:	c7d8                	sw	a4,12(a5)
 458:	4711                	li	a4,4
 45a:	cb98                	sw	a4,16(a5)
 45c:	4715                	li	a4,5
 45e:	cbd8                	sw	a4,20(a5)
 460:	4719                	li	a4,6
 462:	cf98                	sw	a4,24(a5)
  }

  // 19-Comparator Sorting Network for N=8
  // Layer 1
  CS(0, 1);
 464:	0207a283          	lw	t0,32(a5) # 10000020 <plic_irq_priorities>
    plic_idx_sort[i] = i;
 468:	471d                	li	a4,7
  CS(0, 1);
 46a:	53c4                	lw	s1,36(a5)
    plic_idx_sort[i] = i;
 46c:	cfd8                	sw	a4,28(a5)
 46e:	4705                	li	a4,1
 470:	0007a023          	sw	zero,0(a5)
 474:	c3d8                	sw	a4,4(a5)
  CS(0, 1);
 476:	8eba                	mv	t4,a4
 478:	4401                	li	s0,0
 47a:	0092da63          	bge	t0,s1,48e <resort_by_prior+0x50>
 47e:	8696                	mv	a3,t0
 480:	c398                	sw	a4,0(a5)
 482:	82a6                	mv	t0,s1
 484:	0007a223          	sw	zero,4(a5)
 488:	84b6                	mv	s1,a3
 48a:	843a                	mv	s0,a4
 48c:	4e81                	li	t4,0
  CS(2, 3);
 48e:	578c                	lw	a1,40(a5)
 490:	57d8                	lw	a4,44(a5)
 492:	4f0d                	li	t5,3
 494:	4809                	li	a6,2
 496:	00e5db63          	bge	a1,a4,4ac <resort_by_prior+0x6e>
 49a:	86ae                	mv	a3,a1
 49c:	01e7a423          	sw	t5,8(a5)
 4a0:	0107a623          	sw	a6,12(a5)
 4a4:	85ba                	mv	a1,a4
 4a6:	8f42                	mv	t5,a6
 4a8:	8736                	mv	a4,a3
 4aa:	480d                	li	a6,3
  CS(4, 5);
 4ac:	5b94                	lw	a3,48(a5)
 4ae:	5bd0                	lw	a2,52(a5)
 4b0:	4e15                	li	t3,5
 4b2:	4311                	li	t1,4
 4b4:	00c6db63          	bge	a3,a2,4ca <resort_by_prior+0x8c>
 4b8:	8536                	mv	a0,a3
 4ba:	01c7a823          	sw	t3,16(a5)
 4be:	0067aa23          	sw	t1,20(a5)
 4c2:	86b2                	mv	a3,a2
 4c4:	8e1a                	mv	t3,t1
 4c6:	862a                	mv	a2,a0
 4c8:	4315                	li	t1,5
  CS(6, 7);
 4ca:	5f88                	lw	a0,56(a5)
 4cc:	03c7af83          	lw	t6,60(a5)
 4d0:	439d                	li	t2,7
 4d2:	4899                	li	a7,6
 4d4:	01f55b63          	bge	a0,t6,4ea <resort_by_prior+0xac>
 4d8:	892a                	mv	s2,a0
 4da:	0077ac23          	sw	t2,24(a5)
 4de:	0117ae23          	sw	a7,28(a5)
 4e2:	857e                	mv	a0,t6
 4e4:	83c6                	mv	t2,a7
 4e6:	8fca                	mv	t6,s2
 4e8:	489d                	li	a7,7
  // Layer 2
  CS(0, 2);
 4ea:	00b2db63          	bge	t0,a1,500 <resort_by_prior+0xc2>
 4ee:	89ae                	mv	s3,a1
 4f0:	8942                	mv	s2,a6
 4f2:	0107a023          	sw	a6,0(a5)
 4f6:	c780                	sw	s0,8(a5)
 4f8:	8596                	mv	a1,t0
 4fa:	8822                	mv	a6,s0
 4fc:	82ce                	mv	t0,s3
 4fe:	844a                	mv	s0,s2
  CS(1, 3);
 500:	00e4dc63          	bge	s1,a4,518 <resort_by_prior+0xda>
 504:	89a6                	mv	s3,s1
 506:	8976                	mv	s2,t4
 508:	01d7a623          	sw	t4,12(a5)
 50c:	01e7a223          	sw	t5,4(a5)
 510:	84ba                	mv	s1,a4
 512:	8efa                	mv	t4,t5
 514:	874e                	mv	a4,s3
 516:	8f4a                	mv	t5,s2
  CS(4, 6);
 518:	00a6dc63          	bge	a3,a0,530 <resort_by_prior+0xf2>
 51c:	89aa                	mv	s3,a0
 51e:	8946                	mv	s2,a7
 520:	0117a823          	sw	a7,16(a5)
 524:	0067ac23          	sw	t1,24(a5)
 528:	8536                	mv	a0,a3
 52a:	889a                	mv	a7,t1
 52c:	86ce                	mv	a3,s3
 52e:	834a                	mv	t1,s2
  CS(5, 7);
 530:	01f65c63          	bge	a2,t6,548 <resort_by_prior+0x10a>
 534:	89b2                	mv	s3,a2
 536:	8972                	mv	s2,t3
 538:	01c7ae23          	sw	t3,28(a5)
 53c:	0077aa23          	sw	t2,20(a5)
 540:	867e                	mv	a2,t6
 542:	8e1e                	mv	t3,t2
 544:	8fce                	mv	t6,s3
 546:	83ca                	mv	t2,s2
  // Layer 3
  CS(1, 2);
 548:	00b4dc63          	bge	s1,a1,560 <resort_by_prior+0x122>
 54c:	89a6                	mv	s3,s1
 54e:	8976                	mv	s2,t4
 550:	01d7a423          	sw	t4,8(a5)
 554:	0107a223          	sw	a6,4(a5)
 558:	84ae                	mv	s1,a1
 55a:	8ec2                	mv	t4,a6
 55c:	85ce                	mv	a1,s3
 55e:	884a                	mv	a6,s2
  CS(5, 6);
 560:	00a65c63          	bge	a2,a0,578 <resort_by_prior+0x13a>
 564:	89b2                	mv	s3,a2
 566:	8972                	mv	s2,t3
 568:	01c7ac23          	sw	t3,24(a5)
 56c:	0117aa23          	sw	a7,20(a5)
 570:	862a                	mv	a2,a0
 572:	8e46                	mv	t3,a7
 574:	854e                	mv	a0,s3
 576:	88ca                	mv	a7,s2
  CS(0, 4);
 578:	00d2d763          	bge	t0,a3,586 <resort_by_prior+0x148>
 57c:	0067a023          	sw	t1,0(a5)
 580:	cb80                	sw	s0,16(a5)
 582:	8696                	mv	a3,t0
 584:	8322                	mv	t1,s0
  CS(3, 7);
 586:	01f75863          	bge	a4,t6,596 <resort_by_prior+0x158>
 58a:	01e7ae23          	sw	t5,28(a5)
 58e:	0077a623          	sw	t2,12(a5)
 592:	877e                	mv	a4,t6
 594:	8f1e                	mv	t5,t2
  // Layer 4
  CS(1, 5);
 596:	00c4dc63          	bge	s1,a2,5ae <resort_by_prior+0x170>
 59a:	82a6                	mv	t0,s1
 59c:	8ff6                	mv	t6,t4
 59e:	01d7aa23          	sw	t4,20(a5)
 5a2:	01c7a223          	sw	t3,4(a5)
 5a6:	84b2                	mv	s1,a2
 5a8:	8ef2                	mv	t4,t3
 5aa:	8616                	mv	a2,t0
 5ac:	8e7e                	mv	t3,t6
  CS(2, 6);
 5ae:	00a5dc63          	bge	a1,a0,5c6 <resort_by_prior+0x188>
 5b2:	82aa                	mv	t0,a0
 5b4:	8fc6                	mv	t6,a7
 5b6:	0117a423          	sw	a7,8(a5)
 5ba:	0107ac23          	sw	a6,24(a5)
 5be:	852e                	mv	a0,a1
 5c0:	88c2                	mv	a7,a6
 5c2:	8596                	mv	a1,t0
 5c4:	887e                	mv	a6,t6
  // Layer 5
  CS(1, 4);
 5c6:	00d4d863          	bge	s1,a3,5d6 <resort_by_prior+0x198>
 5ca:	0067a223          	sw	t1,4(a5)
 5ce:	01d7a823          	sw	t4,16(a5)
 5d2:	86a6                	mv	a3,s1
 5d4:	8376                	mv	t1,t4
  CS(3, 6);
 5d6:	00a75863          	bge	a4,a0,5e6 <resort_by_prior+0x1a8>
 5da:	01e7ac23          	sw	t5,24(a5)
 5de:	0117a623          	sw	a7,12(a5)
 5e2:	872a                	mv	a4,a0
 5e4:	8f46                	mv	t5,a7
  // Layer 6
  CS(2, 4);
 5e6:	00d5d863          	bge	a1,a3,5f6 <resort_by_prior+0x1b8>
 5ea:	0067a423          	sw	t1,8(a5)
 5ee:	0107a823          	sw	a6,16(a5)
 5f2:	86ae                	mv	a3,a1
 5f4:	8342                	mv	t1,a6
  CS(3, 5);
 5f6:	00c75863          	bge	a4,a2,606 <resort_by_prior+0x1c8>
 5fa:	01e7aa23          	sw	t5,20(a5)
 5fe:	01c7a623          	sw	t3,12(a5)
 602:	8732                	mv	a4,a2
 604:	8f72                	mv	t5,t3
  // Layer 7
  CS(3, 4);
 606:	00d75663          	bge	a4,a3,612 <resort_by_prior+0x1d4>
 60a:	0067a623          	sw	t1,12(a5)
 60e:	01e7a823          	sw	t5,16(a5)
}
 612:	4432                	lw	s0,12(sp)
 614:	44a2                	lw	s1,8(sp)
 616:	4912                	lw	s2,4(sp)
 618:	4982                	lw	s3,0(sp)
 61a:	0141                	addi	sp,sp,16
 61c:	8082                	ret

0000061e <reg_irq_handler>:
  *PLIC_IRQ_ACTV |= actv_mask;
 61e:	200008b7          	lui	a7,0x20000
 622:	0008a803          	lw	a6,0(a7) # 20000000 <_stack_top+0xfff0000>
  plic_irq_priorities[arr_idx] = priority;
 626:	100007b7          	lui	a5,0x10000
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 62a:	068a                	slli	a3,a3,0x2
 62c:	b1c18713          	addi	a4,gp,-1252 # 1000035c <plic_irq_handlers>
  plic_irq_priorities[arr_idx] = priority;
 630:	00078793          	mv	a5,a5
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 634:	9736                	add	a4,a4,a3
  plic_irq_priorities[arr_idx] = priority;
 636:	97b6                	add	a5,a5,a3
  plic_irq_handlers[arr_idx] = _plic_irq_handler;
 638:	c308                	sw	a0,0(a4)
  plic_irq_priorities[arr_idx] = priority;
 63a:	d38c                	sw	a1,32(a5)
  *PLIC_IRQ_ACTV |= actv_mask;
 63c:	00c86833          	or	a6,a6,a2
 640:	0108a023          	sw	a6,0(a7)
  resort_by_prior();
 644:	bbed                	j	43e <resort_by_prior>

00000646 <reg_timer_irq>:

void reg_timer_irq(void (*_timer_irq_handler)(void)) {
  timer_irq_handler = _timer_irq_handler;
 646:	100007b7          	lui	a5,0x10000
 64a:	04a7a223          	sw	a0,68(a5) # 10000044 <timer_irq_handler>
}
 64e:	8082                	ret
 650:	0001                	nop

00000652 <init_ring_buffer>:
#include "../include/ring_buff.h"

void init_ring_buffer(ring_buffer_t *rb) {
  // No malloc needed! The memory is already allocated as part of the struct.
  rb->head = 0;
 652:	10050023          	sb	zero,256(a0)
  rb->tail = 0;
 656:	100500a3          	sb	zero,257(a0)
}
 65a:	8082                	ret

0000065c <reset_ring_buffer>:

void reset_ring_buffer(ring_buffer_t *rb) {
 65c:	10050023          	sb	zero,256(a0)
 660:	100500a3          	sb	zero,257(a0)
 664:	8082                	ret

00000666 <insert_rb>:
}

bool insert_rb(ring_buffer_t *rb, char c) {
  // Calculate what the next head position will be.
  // uint8_t naturally wraps from 255 back to 0.
  uint8_t next_head = (uint8_t)(rb->head + 1);
 666:	10054703          	lbu	a4,256(a0)

  // If the next head hits the tail, the buffer is full.
  // Note: This design sacrifices 1 byte of capacity, holding a max of 255
  // items.
  if (next_head == rb->tail) {
 66a:	10154683          	lbu	a3,257(a0)
  uint8_t next_head = (uint8_t)(rb->head + 1);
 66e:	00170793          	addi	a5,a4,1 # 20003001 <_stack_top+0xfff3001>
 672:	0ff7f793          	zext.b	a5,a5
  if (next_head == rb->tail) {
 676:	00f68963          	beq	a3,a5,688 <insert_rb+0x22>
    return false;
  }

  rb->buffer[rb->head] = c;
 67a:	972a                	add	a4,a4,a0
 67c:	00b70023          	sb	a1,0(a4)
  rb->head = next_head;
 680:	10f50023          	sb	a5,256(a0)

  return true;
 684:	4505                	li	a0,1
 686:	8082                	ret
    return false;
 688:	4501                	li	a0,0
}
 68a:	8082                	ret

0000068c <pop_rb>:

bool pop_rb(ring_buffer_t *rb, char *c) {
  // If head and tail are at the same position, the buffer is empty.
  if (rb->head == rb->tail) {
 68c:	10154703          	lbu	a4,257(a0)
 690:	10054683          	lbu	a3,256(a0)
bool pop_rb(ring_buffer_t *rb, char *c) {
 694:	87aa                	mv	a5,a0
  if (rb->head == rb->tail) {
 696:	00e68e63          	beq	a3,a4,6b2 <pop_rb+0x26>
    return false;
  }

  *c = rb->buffer[rb->tail];
 69a:	972a                	add	a4,a4,a0
 69c:	00074703          	lbu	a4,0(a4)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0

  return true;
 6a0:	4505                	li	a0,1
  *c = rb->buffer[rb->tail];
 6a2:	00e58023          	sb	a4,0(a1)
  rb->tail = (uint8_t)(rb->tail + 1); // Naturally wraps back to 0
 6a6:	1017c703          	lbu	a4,257(a5)
 6aa:	972a                	add	a4,a4,a0
 6ac:	10e780a3          	sb	a4,257(a5)
  return true;
 6b0:	8082                	ret
    return false;
 6b2:	4501                	li	a0,0
}
 6b4:	8082                	ret

000006b6 <init_timers>:
#include "../include/timer.h"
#include <stdint.h>

void init_timers() {
 6b6:	1141                	addi	sp,sp,-16
 6b8:	c606                	sw	ra,12(sp)

  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 6ba:	20000737          	lui	a4,0x20000
 6be:	56fd                	li	a3,-1
 6c0:	c714                	sw	a3,8(a4)
  *TIMER_COMP_PART2 = 0xFFFFFFFF;

  reg_timer_irq(master_timer_isr);
 6c2:	6505                	lui	a0,0x1
  *TIMER_COMP_PART2 = 0xFFFFFFFF;
 6c4:	c754                	sw	a3,12(a4)
  reg_timer_irq(master_timer_isr);
 6c6:	8f650513          	addi	a0,a0,-1802 # 8f6 <master_timer_isr>
 6ca:	3fb5                	jal	646 <reg_timer_irq>

  set_csr(mie, MIE_MTIE);
 6cc:	08000793          	li	a5,128
 6d0:	3047a7f3          	csrrs	a5,mie,a5
}
 6d4:	40b2                	lw	ra,12(sp)
 6d6:	0141                	addi	sp,sp,16
 6d8:	8082                	ret

000006da <read_time>:

uint64_t read_time() {
  uint32_t lo = *TIMER_COMP_PART1;
 6da:	200007b7          	lui	a5,0x20000
 6de:	4788                	lw	a0,8(a5)

  uint32_t hi = *TIMER_COMP_PART2;
 6e0:	200007b7          	lui	a5,0x20000

  return (((uint64_t)hi) << 32) | lo;
}
 6e4:	47cc                	lw	a1,12(a5)
 6e6:	8082                	ret

000006e8 <set_compare>:

void set_compare(uint64_t comp) {
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 6e8:	200007b7          	lui	a5,0x20000
 6ec:	56fd                	li	a3,-1
 6ee:	c794                	sw	a3,8(a5)

  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 6f0:	c7cc                	sw	a1,12(a5)

  *TIMER_COMP_PART1 = (uint32_t)comp;
 6f2:	c788                	sw	a0,8(a5)
}
 6f4:	8082                	ret

000006f6 <swap_in_heap>:

void swap_in_heap(int a_i, int b_i) {
  irq_timer_t *temp = timer_heap[a_i];
 6f6:	b4018793          	addi	a5,gp,-1216 # 10000380 <timer_heap>
  timer_heap[a_i] = timer_heap[b_i];
 6fa:	058a                	slli	a1,a1,0x2
 6fc:	95be                	add	a1,a1,a5
  irq_timer_t *temp = timer_heap[a_i];
 6fe:	050a                	slli	a0,a0,0x2
  timer_heap[a_i] = timer_heap[b_i];
 700:	4194                	lw	a3,0(a1)
  irq_timer_t *temp = timer_heap[a_i];
 702:	97aa                	add	a5,a5,a0
 704:	4398                	lw	a4,0(a5)
  timer_heap[a_i] = timer_heap[b_i];
 706:	c394                	sw	a3,0(a5)
  timer_heap[b_i] = temp;
 708:	c198                	sw	a4,0(a1)
}
 70a:	8082                	ret

0000070c <min_heapify>:

// first call should be, num_timers, 0
void min_heapify(int sz, int i) {
  int smallest = i;
  int left = 2 * i + 1;
 70c:	00159793          	slli	a5,a1,0x1
 710:	00178693          	addi	a3,a5,1 # 20000001 <_stack_top+0xfff0001>
  int right = 2 * i + 2;

  if (left < sz &&
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 714:	b4018813          	addi	a6,gp,-1216 # 10000380 <timer_heap>
  int right = 2 * i + 2;
 718:	0789                	addi	a5,a5,2
  if (left < sz &&
 71a:	06a6de63          	bge	a3,a0,796 <min_heapify+0x8a>
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 71e:	00269713          	slli	a4,a3,0x2
 722:	00259613          	slli	a2,a1,0x2
 726:	9742                	add	a4,a4,a6
 728:	00c80333          	add	t1,a6,a2
 72c:	00072883          	lw	a7,0(a4) # 20000000 <_stack_top+0xfff0000>
 730:	00032e03          	lw	t3,0(t1)
 734:	0048a703          	lw	a4,4(a7)
  if (left < sz &&
 738:	004e2303          	lw	t1,4(t3)
      timer_heap[left]->expires_at < timer_heap[smallest]->expires_at) {
 73c:	0008a883          	lw	a7,0(a7)
  if (left < sz &&
 740:	00676863          	bltu	a4,t1,750 <min_heapify+0x44>
 744:	04e31963          	bne	t1,a4,796 <min_heapify+0x8a>
 748:	000e2303          	lw	t1,0(t3)
 74c:	0468f563          	bgeu	a7,t1,796 <min_heapify+0x8a>
    smallest = left;
  }

  if (right < sz &&
 750:	00a7dd63          	bge	a5,a0,76a <min_heapify+0x5e>
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 754:	00279313          	slli	t1,a5,0x2
 758:	9342                	add	t1,t1,a6
 75a:	00032e03          	lw	t3,0(t1)
  if (right < sz &&
 75e:	004e2303          	lw	t1,4(t3)
 762:	00e36563          	bltu	t1,a4,76c <min_heapify+0x60>
 766:	06e30563          	beq	t1,a4,7d0 <min_heapify+0xc4>
 76a:	87b6                	mv	a5,a3
    smallest = right;
  }

  if (smallest != i) {
 76c:	06b78163          	beq	a5,a1,7ce <min_heapify+0xc2>
  timer_heap[a_i] = timer_heap[b_i];
 770:	00279713          	slli	a4,a5,0x2
 774:	9742                	add	a4,a4,a6
  irq_timer_t *temp = timer_heap[a_i];
 776:	00c806b3          	add	a3,a6,a2
  timer_heap[a_i] = timer_heap[b_i];
 77a:	00072883          	lw	a7,0(a4)
  irq_timer_t *temp = timer_heap[a_i];
 77e:	4290                	lw	a2,0(a3)
    swap_in_heap(i, smallest);
    min_heapify(sz, smallest);
 780:	85be                	mv	a1,a5
  timer_heap[a_i] = timer_heap[b_i];
 782:	0116a023          	sw	a7,0(a3)
  int left = 2 * i + 1;
 786:	00159793          	slli	a5,a1,0x1
 78a:	00178693          	addi	a3,a5,1
  timer_heap[b_i] = temp;
 78e:	c310                	sw	a2,0(a4)
  int right = 2 * i + 2;
 790:	0789                	addi	a5,a5,2
  if (left < sz &&
 792:	f8a6c6e3          	blt	a3,a0,71e <min_heapify+0x12>
  if (right < sz &&
 796:	00a7c363          	blt	a5,a0,79c <min_heapify+0x90>
 79a:	8082                	ret
      timer_heap[right]->expires_at < timer_heap[smallest]->expires_at) {
 79c:	00259613          	slli	a2,a1,0x2
 7a0:	00279713          	slli	a4,a5,0x2
 7a4:	00c806b3          	add	a3,a6,a2
 7a8:	9742                	add	a4,a4,a6
 7aa:	0006a303          	lw	t1,0(a3)
 7ae:	00072883          	lw	a7,0(a4)
  if (right < sz &&
 7b2:	00432683          	lw	a3,4(t1)
 7b6:	0048a703          	lw	a4,4(a7)
 7ba:	fad769e3          	bltu	a4,a3,76c <min_heapify+0x60>
 7be:	00e69863          	bne	a3,a4,7ce <min_heapify+0xc2>
 7c2:	00032683          	lw	a3,0(t1)
 7c6:	0008a703          	lw	a4,0(a7)
 7ca:	fad761e3          	bltu	a4,a3,76c <min_heapify+0x60>
  }
}
 7ce:	8082                	ret
  if (right < sz &&
 7d0:	000e2703          	lw	a4,0(t3)
 7d4:	f9176ce3          	bltu	a4,a7,76c <min_heapify+0x60>
 7d8:	87b6                	mv	a5,a3
 7da:	bf49                	j	76c <min_heapify+0x60>

000007dc <sift_up>:

void sift_up(int i) {
  int parent = (i - 1) / 2;
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 7dc:	04a05f63          	blez	a0,83a <sift_up+0x5e>
 7e0:	b4018613          	addi	a2,gp,-1216 # 10000380 <timer_heap>
 7e4:	00251793          	slli	a5,a0,0x2
 7e8:	97b2                	add	a5,a5,a2
 7ea:	0007a303          	lw	t1,0(a5)
  int parent = (i - 1) / 2;
 7ee:	fff50713          	addi	a4,a0,-1
 7f2:	8705                	srai	a4,a4,0x1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 7f4:	00032e83          	lw	t4,0(t1)
 7f8:	00432e03          	lw	t3,4(t1)
 7fc:	a809                	j	80e <sift_up+0x32>
  timer_heap[a_i] = timer_heap[b_i];
 7fe:	c10c                	sw	a1,0(a0)
  timer_heap[b_i] = temp;
 800:	0067a023          	sw	t1,0(a5)
    swap_in_heap(i, parent);

    // Move up the tree
    i = parent;
    parent = (i - 1) / 2;
 804:	96c2                	add	a3,a3,a6
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 806:	853a                	mv	a0,a4
 808:	cb0d                	beqz	a4,83a <sift_up+0x5e>
 80a:	4016d713          	srai	a4,a3,0x1
 80e:	00271793          	slli	a5,a4,0x2
 812:	00f606b3          	add	a3,a2,a5
 816:	428c                	lw	a1,0(a3)
  timer_heap[a_i] = timer_heap[b_i];
 818:	050a                	slli	a0,a0,0x2
    parent = (i - 1) / 2;
 81a:	fff70813          	addi	a6,a4,-1
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 81e:	0045a883          	lw	a7,4(a1)
  timer_heap[b_i] = temp;
 822:	87b6                	mv	a5,a3
  timer_heap[a_i] = timer_heap[b_i];
 824:	9532                	add	a0,a0,a2
    parent = (i - 1) / 2;
 826:	01f85693          	srli	a3,a6,0x1f
  while (i > 0 && timer_heap[i]->expires_at < timer_heap[parent]->expires_at) {
 82a:	fd1e6ae3          	bltu	t3,a7,7fe <sift_up+0x22>
 82e:	01c89663          	bne	a7,t3,83a <sift_up+0x5e>
 832:	0005a883          	lw	a7,0(a1)
 836:	fd1ee4e3          	bltu	t4,a7,7fe <sift_up+0x22>
  }
}
 83a:	8082                	ret

0000083c <_deactivate_timer.part.0>:
  // 1. Mark as inactive so the pool slot can be reused
  timer->active = false;

  // 2. Find the timer in the heap (O(N) search, but MAX_TIMERS is small)
  int heap_idx = -1;
  for (int i = 0; i < num_timers; i++) {
 83c:	10000837          	lui	a6,0x10000
 840:	04882683          	lw	a3,72(a6) # 10000048 <num_timers>
  timer->active = false;
 844:	00050a23          	sb	zero,20(a0)
  for (int i = 0; i < num_timers; i++) {
 848:	06d05063          	blez	a3,8a8 <_deactivate_timer.part.0+0x6c>
 84c:	b4018613          	addi	a2,gp,-1216 # 10000380 <timer_heap>
 850:	87b2                	mv	a5,a2
 852:	4581                	li	a1,0
 854:	a021                	j	85c <_deactivate_timer.part.0+0x20>
 856:	0585                	addi	a1,a1,1
 858:	04d58863          	beq	a1,a3,8a8 <_deactivate_timer.part.0+0x6c>
    if (timer_heap[i] == timer) {
 85c:	4398                	lw	a4,0(a5)
  for (int i = 0; i < num_timers; i++) {
 85e:	0791                	addi	a5,a5,4
    if (timer_heap[i] == timer) {
 860:	fee51be3          	bne	a0,a4,856 <_deactivate_timer.part.0+0x1a>
  if (heap_idx == -1) {
    return false; // Timer was active but not in heap (state error)
  }

  // 3. Replace the removed timer with the last timer in the heap
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 864:	fff68513          	addi	a0,a3,-1
 868:	00251793          	slli	a5,a0,0x2
 86c:	97b2                	add	a5,a5,a2
 86e:	4398                	lw	a4,0(a5)
bool _deactivate_timer(irq_timer_t *timer) {
 870:	1141                	addi	sp,sp,-16
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 872:	00259793          	slli	a5,a1,0x2
bool _deactivate_timer(irq_timer_t *timer) {
 876:	c606                	sw	ra,12(sp)
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 878:	97b2                	add	a5,a5,a2
  num_timers--;
 87a:	04a82423          	sw	a0,72(a6)
  timer_heap[heap_idx] = timer_heap[num_timers - 1];
 87e:	c398                	sw	a4,0(a5)

  // 4. Restore the heap property
  if (heap_idx < num_timers) {
 880:	02a5d663          	bge	a1,a0,8ac <_deactivate_timer.part.0+0x70>
    int parent = (heap_idx - 1) / 2;

    // If the new node is smaller than its parent, it needs to bubble up
    if (heap_idx > 0 &&
 884:	c5ad                	beqz	a1,8ee <_deactivate_timer.part.0+0xb2>
    int parent = (heap_idx - 1) / 2;
 886:	fff58793          	addi	a5,a1,-1
 88a:	8785                	srai	a5,a5,0x1
        timer_heap[heap_idx]->expires_at < timer_heap[parent]->expires_at) {
 88c:	078a                	slli	a5,a5,0x2
 88e:	963e                	add	a2,a2,a5
 890:	4210                	lw	a2,0(a2)
    if (heap_idx > 0 &&
 892:	435c                	lw	a5,4(a4)
 894:	4254                	lw	a3,4(a2)
 896:	04d7e963          	bltu	a5,a3,8e8 <_deactivate_timer.part.0+0xac>
 89a:	04f68363          	beq	a3,a5,8e0 <_deactivate_timer.part.0+0xa4>
      sift_up(heap_idx);
    }
    // Otherwise, it might need to bubble down
    else {
      min_heapify(num_timers, heap_idx);
 89e:	35bd                	jal	70c <min_heapify>
      set_compare(0xFFFFFFFFFFFFFFFFULL);
    }
  }

  return true;
}
 8a0:	40b2                	lw	ra,12(sp)
  return true;
 8a2:	4505                	li	a0,1
}
 8a4:	0141                	addi	sp,sp,16
 8a6:	8082                	ret
    return false;
 8a8:	4501                	li	a0,0
}
 8aa:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 8ac:	ed99                	bnez	a1,8ca <_deactivate_timer.part.0+0x8e>
    if (num_timers > 0) {
 8ae:	cd19                	beqz	a0,8cc <_deactivate_timer.part.0+0x90>
      set_compare(timer_heap[0]->expires_at);
 8b0:	4218                	lw	a4,0(a2)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 8b2:	200007b7          	lui	a5,0x20000
 8b6:	55fd                	li	a1,-1
      set_compare(timer_heap[0]->expires_at);
 8b8:	4350                	lw	a2,4(a4)
 8ba:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 8bc:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 8be:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 8c0:	c794                	sw	a3,8(a5)
}
 8c2:	40b2                	lw	ra,12(sp)
  return true;
 8c4:	4505                	li	a0,1
}
 8c6:	0141                	addi	sp,sp,16
 8c8:	8082                	ret
  if (heap_idx == 0 || num_timers == 0) {
 8ca:	fd65                	bnez	a0,8c2 <_deactivate_timer.part.0+0x86>
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 8cc:	200007b7          	lui	a5,0x20000
 8d0:	577d                	li	a4,-1
 8d2:	c798                	sw	a4,8(a5)
}
 8d4:	40b2                	lw	ra,12(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 8d6:	c7d8                	sw	a4,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 8d8:	c798                	sw	a4,8(a5)
  return true;
 8da:	4505                	li	a0,1
}
 8dc:	0141                	addi	sp,sp,16
 8de:	8082                	ret
    if (heap_idx > 0 &&
 8e0:	4214                	lw	a3,0(a2)
 8e2:	431c                	lw	a5,0(a4)
 8e4:	fad7fde3          	bgeu	a5,a3,89e <_deactivate_timer.part.0+0x62>
      sift_up(heap_idx);
 8e8:	852e                	mv	a0,a1
 8ea:	3dcd                	jal	7dc <sift_up>
  if (heap_idx == 0 || num_timers == 0) {
 8ec:	bfd9                	j	8c2 <_deactivate_timer.part.0+0x86>
      min_heapify(num_timers, heap_idx);
 8ee:	3d39                	jal	70c <min_heapify>
  if (heap_idx == 0 || num_timers == 0) {
 8f0:	b4018613          	addi	a2,gp,-1216 # 10000380 <timer_heap>
 8f4:	bf75                	j	8b0 <_deactivate_timer.part.0+0x74>

000008f6 <master_timer_isr>:

void master_timer_isr() {
 8f6:	1101                	addi	sp,sp,-32
 8f8:	c452                	sw	s4,8(sp)
  // Loop to handle cases where multiple timers expire at the same time,
  // or if a callback execution delays us past the next timer's expiration.
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 8fa:	10000a37          	lui	s4,0x10000
 8fe:	048a2783          	lw	a5,72(s4) # 10000048 <num_timers>
void master_timer_isr() {
 902:	ce06                	sw	ra,28(sp)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 904:	04f05f63          	blez	a5,962 <master_timer_isr+0x6c>
 908:	ca26                	sw	s1,20(sp)
 90a:	c84a                	sw	s2,16(sp)
 90c:	c64e                	sw	s3,12(sp)
 90e:	200009b7          	lui	s3,0x20000
 912:	20000937          	lui	s2,0x20000
 916:	cc22                	sw	s0,24(sp)
 918:	c256                	sw	s5,4(sp)
 91a:	b4018493          	addi	s1,gp,-1216 # 10000380 <timer_heap>
 91e:	09a1                	addi	s3,s3,8 # 20000008 <_stack_top+0xfff0008>
 920:	0931                	addi	s2,s2,12 # 2000000c <_stack_top+0xfff000c>
 922:	4080                	lw	s0,0(s1)
  uint32_t lo = *TIMER_COMP_PART1;
 924:	0009a683          	lw	a3,0(s3)
  uint32_t hi = *TIMER_COMP_PART2;
 928:	00092783          	lw	a5,0(s2)
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 92c:	4058                	lw	a4,4(s0)
 92e:	06e7e263          	bltu	a5,a4,992 <master_timer_isr+0x9c>
 932:	04f70d63          	beq	a4,a5,98c <master_timer_isr+0x96>

    // 1. Get the timer at the top of the heap
    irq_timer_t *top_timer = timer_heap[0];

    // 2. Run the callback function
    if (top_timer->callback_function != NULL) {
 936:	481c                	lw	a5,16(s0)
 938:	c391                	beqz	a5,93c <master_timer_isr+0x46>
      // Cast the void* to a function pointer and execute it
      void (*callback)(void) = (void (*)(void))top_timer->callback_function;
      callback();
 93a:	9782                	jalr	a5
    }

    // 3. Handle periodic vs absolute
    if (top_timer->period > 0) {
 93c:	441c                	lw	a5,8(s0)
 93e:	4454                	lw	a3,12(s0)
 940:	00d7e733          	or	a4,a5,a3
 944:	e31d                	bnez	a4,96a <master_timer_isr+0x74>
  if (timer == NULL || !timer->active) {
 946:	01444783          	lbu	a5,20(s0)
 94a:	c399                	beqz	a5,950 <master_timer_isr+0x5a>
  timer->active = false;
 94c:	8522                	mv	a0,s0
 94e:	35fd                	jal	83c <_deactivate_timer.part.0>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 950:	048a2a83          	lw	s5,72(s4)
 954:	fd5047e3          	bgtz	s5,922 <master_timer_isr+0x2c>
 958:	4462                	lw	s0,24(sp)
 95a:	44d2                	lw	s1,20(sp)
 95c:	4942                	lw	s2,16(sp)
 95e:	49b2                	lw	s3,12(sp)
 960:	4a92                	lw	s5,4(sp)
  }

  if (num_timers > 0) {
    set_compare(timer_heap[0]->expires_at);
  }
}
 962:	40f2                	lw	ra,28(sp)
 964:	4a22                	lw	s4,8(sp)
 966:	6105                	addi	sp,sp,32
 968:	8082                	ret
      top_timer->expires_at += top_timer->period;
 96a:	4018                	lw	a4,0(s0)
 96c:	4050                	lw	a2,4(s0)
      min_heapify(num_timers, 0);
 96e:	048a2a83          	lw	s5,72(s4)
      top_timer->expires_at += top_timer->period;
 972:	97ba                	add	a5,a5,a4
 974:	00e7b733          	sltu	a4,a5,a4
 978:	96b2                	add	a3,a3,a2
 97a:	9736                	add	a4,a4,a3
 97c:	c01c                	sw	a5,0(s0)
 97e:	c058                	sw	a4,4(s0)
      min_heapify(num_timers, 0);
 980:	8556                	mv	a0,s5
 982:	4581                	li	a1,0
 984:	3361                	jal	70c <min_heapify>
  while (num_timers > 0 && timer_heap[0]->expires_at <= read_time()) {
 986:	f9504ee3          	bgtz	s5,922 <master_timer_isr+0x2c>
 98a:	b7f9                	j	958 <master_timer_isr+0x62>
 98c:	401c                	lw	a5,0(s0)
 98e:	faf6f4e3          	bgeu	a3,a5,936 <master_timer_isr+0x40>
    set_compare(timer_heap[0]->expires_at);
 992:	4098                	lw	a4,0(s1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 994:	200007b7          	lui	a5,0x20000
 998:	55fd                	li	a1,-1
    set_compare(timer_heap[0]->expires_at);
 99a:	4350                	lw	a2,4(a4)
 99c:	4314                	lw	a3,0(a4)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 99e:	c78c                	sw	a1,8(a5)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 9a0:	c7d0                	sw	a2,12(a5)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 9a2:	c794                	sw	a3,8(a5)
 9a4:	bf55                	j	958 <master_timer_isr+0x62>

000009a6 <register_isr_periodic>:
  if (num_timers == MAX_TIMERS) {
 9a6:	10000fb7          	lui	t6,0x10000
 9aa:	048fa883          	lw	a7,72(t6) # 10000048 <num_timers>
 9ae:	04000793          	li	a5,64
 9b2:	0af88e63          	beq	a7,a5,a6e <register_isr_periodic+0xc8>
    if (timer_pool[i].active == false) {
 9b6:	b4018813          	addi	a6,gp,-1216 # 10000380 <timer_heap>
 9ba:	11484783          	lbu	a5,276(a6)
irq_timer_handler register_isr_periodic(uint64_t period, void *cb) {
 9be:	1101                	addi	sp,sp,-32
 9c0:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 9c2:	cbc5                	beqz	a5,a72 <register_isr_periodic+0xcc>
 9c4:	12c80793          	addi	a5,a6,300
  int i = 0;
 9c8:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 9ca:	0007c683          	lbu	a3,0(a5) # 20000000 <_stack_top+0xfff0000>
 9ce:	07e1                	addi	a5,a5,24
      i++;
 9d0:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 9d2:	fee5                	bnez	a3,9ca <register_isr_periodic+0x24>
  timer_heap[num_timers - 1] = &timer_pool[i];
 9d4:	00171793          	slli	a5,a4,0x1
 9d8:	00e78333          	add	t1,a5,a4
 9dc:	030e                	slli	t1,t1,0x3
 9de:	10080693          	addi	a3,a6,256
 9e2:	969a                	add	a3,a3,t1
  uint32_t lo = *TIMER_COMP_PART1;
 9e4:	20000e37          	lui	t3,0x20000
  timer_pool[i].expires_at = read_time() + period;
 9e8:	97ba                	add	a5,a5,a4
  uint32_t lo = *TIMER_COMP_PART1;
 9ea:	008e2703          	lw	a4,8(t3) # 20000008 <_stack_top+0xfff0008>
 9ee:	832a                	mv	t1,a0
  uint32_t hi = *TIMER_COMP_PART2;
 9f0:	00ce2503          	lw	a0,12(t3)
  timer_pool[i].expires_at = read_time() + period;
 9f4:	006702b3          	add	t0,a4,t1
 9f8:	00e2b733          	sltu	a4,t0,a4
 9fc:	952e                	add	a0,a0,a1
 9fe:	078e                	slli	a5,a5,0x3
 a00:	97c2                	add	a5,a5,a6
 a02:	972a                	add	a4,a4,a0
  timer_pool[i].active = true;
 a04:	4385                	li	t2,1
  timer_heap[num_timers - 1] = &timer_pool[i];
 a06:	00289f13          	slli	t5,a7,0x2
  timer_pool[i].expires_at = read_time() + period;
 a0a:	10e7a223          	sw	a4,260(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 a0e:	9f42                	add	t5,t5,a6
  num_timers++;
 a10:	00788733          	add	a4,a7,t2
  sift_up(num_timers - 1);
 a14:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + period;
 a16:	1057a023          	sw	t0,256(a5)
  timer_pool[i].period = period;
 a1a:	1067a423          	sw	t1,264(a5)
 a1e:	10b7a623          	sw	a1,268(a5)
  timer_pool[i].callback_function = cb;
 a22:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 a26:	10778a23          	sb	t2,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 a2a:	00df2023          	sw	a3,0(t5)
 a2e:	c636                	sw	a3,12(sp)
  num_timers++;
 a30:	04efa423          	sw	a4,72(t6)
  sift_up(num_timers - 1);
 a34:	3365                	jal	7dc <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 a36:	b401a783          	lw	a5,-1216(gp) # 10000380 <timer_heap>
 a3a:	46b2                	lw	a3,12(sp)
 a3c:	20000eb7          	lui	t4,0x20000
 a40:	20000e37          	lui	t3,0x20000
 a44:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 a46:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 a48:	00d78663          	beq	a5,a3,a54 <register_isr_periodic+0xae>
}
 a4c:	40f2                	lw	ra,28(sp)
  return new_handler;
 a4e:	8536                	mv	a0,a3
}
 a50:	6105                	addi	sp,sp,32
 a52:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 a54:	42d8                	lw	a4,4(a3)
 a56:	429c                	lw	a5,0(a3)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 a58:	567d                	li	a2,-1
 a5a:	00ce2023          	sw	a2,0(t3)
}
 a5e:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 a60:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 a64:	00fe2023          	sw	a5,0(t3)
  return new_handler;
 a68:	8536                	mv	a0,a3
}
 a6a:	6105                	addi	sp,sp,32
 a6c:	8082                	ret
    return (irq_timer_handler){};
 a6e:	4501                	li	a0,0
}
 a70:	8082                	ret
    if (timer_pool[i].active == false) {
 a72:	10080693          	addi	a3,a6,256
  int i = 0;
 a76:	4701                	li	a4,0
 a78:	b7b5                	j	9e4 <register_isr_periodic+0x3e>

00000a7a <register_isr_abs>:
  if (num_timers == MAX_TIMERS) {
 a7a:	10000f37          	lui	t5,0x10000
 a7e:	048f2883          	lw	a7,72(t5) # 10000048 <num_timers>
 a82:	04000793          	li	a5,64
 a86:	0cf88063          	beq	a7,a5,b46 <register_isr_abs+0xcc>
    if (timer_pool[i].active == false) {
 a8a:	b4018813          	addi	a6,gp,-1216 # 10000380 <timer_heap>
 a8e:	11484783          	lbu	a5,276(a6)
bool register_isr_abs(uint64_t offset, void *cb) {
 a92:	1101                	addi	sp,sp,-32
 a94:	ce06                	sw	ra,28(sp)
    if (timer_pool[i].active == false) {
 a96:	cbd5                	beqz	a5,b4a <register_isr_abs+0xd0>
 a98:	12c80793          	addi	a5,a6,300
  int i = 0;
 a9c:	4701                	li	a4,0
    if (timer_pool[i].active == false) {
 a9e:	0007c683          	lbu	a3,0(a5)
 aa2:	07e1                	addi	a5,a5,24
      i++;
 aa4:	0705                	addi	a4,a4,1
    if (timer_pool[i].active == false) {
 aa6:	fee5                	bnez	a3,a9e <register_isr_abs+0x24>
  timer_heap[num_timers - 1] = &timer_pool[i];
 aa8:	00171793          	slli	a5,a4,0x1
 aac:	00e786b3          	add	a3,a5,a4
 ab0:	068e                	slli	a3,a3,0x3
 ab2:	10080313          	addi	t1,a6,256
 ab6:	9336                	add	t1,t1,a3
  uint32_t lo = *TIMER_COMP_PART1;
 ab8:	20000e37          	lui	t3,0x20000
 abc:	008e2683          	lw	a3,8(t3) # 20000008 <_stack_top+0xfff0008>
  uint32_t hi = *TIMER_COMP_PART2;
 ac0:	00ce2f83          	lw	t6,12(t3)
  timer_pool[i].expires_at = read_time() + offset;
 ac4:	97ba                	add	a5,a5,a4
 ac6:	00a68733          	add	a4,a3,a0
  timer_pool[i].active = true;
 aca:	4285                	li	t0,1
  timer_pool[i].expires_at = read_time() + offset;
 acc:	00bf8533          	add	a0,t6,a1
 ad0:	00d736b3          	sltu	a3,a4,a3
  timer_heap[num_timers - 1] = &timer_pool[i];
 ad4:	00289593          	slli	a1,a7,0x2
  timer_pool[i].expires_at = read_time() + offset;
 ad8:	078e                	slli	a5,a5,0x3
 ada:	97c2                	add	a5,a5,a6
 adc:	96aa                	add	a3,a3,a0
  timer_heap[num_timers - 1] = &timer_pool[i];
 ade:	95c2                	add	a1,a1,a6
  num_timers++;
 ae0:	00588fb3          	add	t6,a7,t0
  sift_up(num_timers - 1);
 ae4:	8546                	mv	a0,a7
  timer_pool[i].expires_at = read_time() + offset;
 ae6:	10d7a223          	sw	a3,260(a5)
 aea:	10e7a023          	sw	a4,256(a5)
  timer_pool[i].period = 0;
 aee:	1007a423          	sw	zero,264(a5)
 af2:	1007a623          	sw	zero,268(a5)
  timer_pool[i].callback_function = cb;
 af6:	10c7a823          	sw	a2,272(a5)
  timer_pool[i].active = true;
 afa:	10578a23          	sb	t0,276(a5)
  timer_heap[num_timers - 1] = &timer_pool[i];
 afe:	0065a023          	sw	t1,0(a1)
 b02:	c61a                	sw	t1,12(sp)
  num_timers++;
 b04:	05ff2423          	sw	t6,72(t5)
  sift_up(num_timers - 1);
 b08:	39d1                	jal	7dc <sift_up>
  if (timer_heap[0] == &timer_pool[i]) {
 b0a:	b401a783          	lw	a5,-1216(gp) # 10000380 <timer_heap>
 b0e:	4332                	lw	t1,12(sp)
 b10:	20000eb7          	lui	t4,0x20000
 b14:	20000e37          	lui	t3,0x20000
 b18:	0eb1                	addi	t4,t4,12 # 2000000c <_stack_top+0xfff000c>
 b1a:	0e21                	addi	t3,t3,8 # 20000008 <_stack_top+0xfff0008>
 b1c:	00678663          	beq	a5,t1,b28 <register_isr_abs+0xae>
}
 b20:	40f2                	lw	ra,28(sp)
  return true;
 b22:	4505                	li	a0,1
}
 b24:	6105                	addi	sp,sp,32
 b26:	8082                	ret
    set_compare(timer_heap[0]->expires_at);
 b28:	00432703          	lw	a4,4(t1)
 b2c:	00032783          	lw	a5,0(t1)
  *TIMER_COMP_PART1 = 0xFFFFFFFF;
 b30:	56fd                	li	a3,-1
 b32:	00de2023          	sw	a3,0(t3)
}
 b36:	40f2                	lw	ra,28(sp)
  *TIMER_COMP_PART2 = (uint32_t)(comp >> 32);
 b38:	00eea023          	sw	a4,0(t4)
  *TIMER_COMP_PART1 = (uint32_t)comp;
 b3c:	00fe2023          	sw	a5,0(t3)
  return true;
 b40:	4505                	li	a0,1
}
 b42:	6105                	addi	sp,sp,32
 b44:	8082                	ret
    return false;
 b46:	4501                	li	a0,0
}
 b48:	8082                	ret
    if (timer_pool[i].active == false) {
 b4a:	10080313          	addi	t1,a6,256
  int i = 0;
 b4e:	4701                	li	a4,0
 b50:	b7a5                	j	ab8 <register_isr_abs+0x3e>

00000b52 <deactivate_timer>:
  if (timer == NULL || !timer->active) {
 b52:	c509                	beqz	a0,b5c <deactivate_timer+0xa>
 b54:	01454783          	lbu	a5,20(a0)
 b58:	c391                	beqz	a5,b5c <deactivate_timer+0xa>
  timer->active = false;
 b5a:	b1cd                	j	83c <_deactivate_timer.part.0>
}
 b5c:	4501                	li	a0,0
 b5e:	8082                	ret

00000b60 <_deactivate_timer>:
  if (timer == NULL || !timer->active) {
 b60:	c509                	beqz	a0,b6a <_deactivate_timer+0xa>
 b62:	01454783          	lbu	a5,20(a0)
 b66:	c391                	beqz	a5,b6a <_deactivate_timer+0xa>
  timer->active = false;
 b68:	b9d1                	j	83c <_deactivate_timer.part.0>
}
 b6a:	4501                	li	a0,0
 b6c:	8082                	ret

00000b6e <uart_isr>:
ring_buffer_t rx_buffer;
ring_buffer_t tx_buffer;

// Define the Interrupt Service Routine
void uart_isr(void) {
  uint32_t irq_status = *UART_IRQ_STATUS;
 b6e:	200027b7          	lui	a5,0x20002
 b72:	07d1                	addi	a5,a5,20 # 20002014 <_stack_top+0xfff2014>
 b74:	439c                	lw	a5,0(a5)
void uart_isr(void) {
 b76:	7179                	addi	sp,sp,-48
 b78:	d606                	sw	ra,44(sp)

  // Handle Incoming Data
  if (irq_status & IRQ_RX_AVAIL) {
 b7a:	0017f713          	andi	a4,a5,1
 b7e:	e705                	bnez	a4,ba6 <uart_isr+0x38>
    char c = (char)(*UART_RX_FIFO);
    insert_rb(&rx_buffer, c); // Push to RX buffer
  }

  // Handle Outgoing Data
  if ((irq_status & IRQ_TX_EMPTY) && (*UART_IRQ_EN & IRQ_TX_EMPTY)) {
 b80:	0027f713          	andi	a4,a5,2
 b84:	c711                	beqz	a4,b90 <uart_isr+0x22>
 b86:	20002737          	lui	a4,0x20002
 b8a:	4b14                	lw	a3,16(a4)
 b8c:	8a89                	andi	a3,a3,2
 b8e:	e69d                	bnez	a3,bbc <uart_isr+0x4e>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
    }
  }

  // Handle Hardware Errors
  if (irq_status & (IRQ_RX_OVERRUN | IRQ_FRAME_ERROR)) {
 b90:	8bb1                	andi	a5,a5,12
 b92:	c799                	beqz	a5,ba0 <uart_isr+0x32>
    *UART_CTRL |= CTRL_CLR_ERRORS; // Clear the hardware error states
 b94:	200027b7          	lui	a5,0x20002
 b98:	47d8                	lw	a4,12(a5)
 b9a:	00476713          	ori	a4,a4,4
 b9e:	c7d8                	sw	a4,12(a5)
  }
}
 ba0:	50b2                	lw	ra,44(sp)
 ba2:	6145                	addi	sp,sp,48
 ba4:	8082                	ret
    char c = (char)(*UART_RX_FIFO);
 ba6:	200026b7          	lui	a3,0x20002
 baa:	428c                	lw	a1,0(a3)
    insert_rb(&rx_buffer, c); // Push to RX buffer
 bac:	24018513          	addi	a0,gp,576 # 10000a80 <rx_buffer>
 bb0:	0ff5f593          	zext.b	a1,a1
 bb4:	c63e                	sw	a5,12(sp)
 bb6:	3c45                	jal	666 <insert_rb>
 bb8:	47b2                	lw	a5,12(sp)
 bba:	b7d9                	j	b80 <uart_isr+0x12>
    if (pop_rb(&tx_buffer, &c)) {
 bbc:	34418513          	addi	a0,gp,836 # 10000b84 <tx_buffer>
 bc0:	01f10593          	addi	a1,sp,31
 bc4:	c63e                	sw	a5,12(sp)
 bc6:	34d9                	jal	68c <pop_rb>
 bc8:	20002737          	lui	a4,0x20002
 bcc:	47b2                	lw	a5,12(sp)
 bce:	0741                	addi	a4,a4,16 # 20002010 <_stack_top+0xfff2010>
 bd0:	c519                	beqz	a0,bde <uart_isr+0x70>
      *UART_TX_FIFO = (uint32_t)c;
 bd2:	01f14683          	lbu	a3,31(sp)
 bd6:	20002737          	lui	a4,0x20002
 bda:	c354                	sw	a3,4(a4)
 bdc:	bf55                	j	b90 <uart_isr+0x22>
      *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 bde:	4314                	lw	a3,0(a4)
 be0:	9af5                	andi	a3,a3,-3
 be2:	c314                	sw	a3,0(a4)
 be4:	b775                	j	b90 <uart_isr+0x22>

00000be6 <uart_init>:

// Initialization function (Call this in main!)
void uart_init(void) {
 be6:	1141                	addi	sp,sp,-16
  init_ring_buffer(&rx_buffer);
 be8:	24018513          	addi	a0,gp,576 # 10000a80 <rx_buffer>
void uart_init(void) {
 bec:	c606                	sw	ra,12(sp)
  init_ring_buffer(&rx_buffer);
 bee:	3495                	jal	652 <init_ring_buffer>
  init_ring_buffer(&tx_buffer);
 bf0:	24018513          	addi	a0,gp,576 # 10000a80 <rx_buffer>
 bf4:	10450513          	addi	a0,a0,260
 bf8:	3ca9                	jal	652 <init_ring_buffer>

  // Register ISR with the MINA PLIC at priority 1
  reg_UART_irq(uart_isr, 1);
 bfa:	4605                	li	a2,1
 bfc:	6505                	lui	a0,0x1
 bfe:	85b2                	mv	a1,a2
 c00:	b6e50513          	addi	a0,a0,-1170 # b6e <uart_isr>
 c04:	4681                	li	a3,0
 c06:	3c21                	jal	61e <reg_irq_handler>

  // Enable the RX interrupt permanently so we never miss incoming data
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 c08:	200027b7          	lui	a5,0x20002
 c0c:	4b98                	lw	a4,16(a5)
}
 c0e:	40b2                	lw	ra,12(sp)
  *UART_IRQ_EN |= IRQ_RX_AVAIL;
 c10:	00176713          	ori	a4,a4,1
 c14:	cb98                	sw	a4,16(a5)
}
 c16:	0141                	addi	sp,sp,16
 c18:	8082                	ret

00000c1a <uart_putc>:

void uart_putc(char c) {
  // 1. Temporarily disable TX interrupts to check state safely
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c1a:	200027b7          	lui	a5,0x20002
 c1e:	4b94                	lw	a3,16(a5)

  // 2. If the software buffer is empty AND the hardware TX FIFO is empty,
  // bypass the software buffer to kickstart the hardware transmission.
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c20:	24018713          	addi	a4,gp,576 # 10000a80 <rx_buffer>
 c24:	20474583          	lbu	a1,516(a4) # 20002204 <_stack_top+0xfff2204>
 c28:	20574603          	lbu	a2,517(a4)
  *UART_IRQ_EN &= ~IRQ_TX_EMPTY;
 c2c:	ffd6f713          	andi	a4,a3,-3
 c30:	cb98                	sw	a4,16(a5)
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c32:	04c58263          	beq	a1,a2,c76 <uart_putc+0x5c>
void uart_putc(char c) {
 c36:	1141                	addi	sp,sp,-16
 c38:	c422                	sw	s0,8(sp)
 c3a:	c04a                	sw	s2,0(sp)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
  } else {
    // Try to insert while TX IRQ is masked; if the 256-byte buffer is full,
    // re-enable IRQ_TX_EMPTY while waiting so uart_isr() can drain it!
    while (!insert_rb(&tx_buffer, c)) {
      *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c3c:	20002437          	lui	s0,0x20002
void uart_putc(char c) {
 c40:	c226                	sw	s1,4(sp)
 c42:	c606                	sw	ra,12(sp)
 c44:	84aa                	mv	s1,a0
 c46:	34418913          	addi	s2,gp,836 # 10000b84 <tx_buffer>
      *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c4a:	0441                	addi	s0,s0,16 # 20002010 <_stack_top+0xfff2010>
 c4c:	a029                	j	c56 <uart_putc+0x3c>
 c4e:	401c                	lw	a5,0(s0)
 c50:	0027e793          	ori	a5,a5,2
 c54:	c01c                	sw	a5,0(s0)
    while (!insert_rb(&tx_buffer, c)) {
 c56:	85a6                	mv	a1,s1
 c58:	854a                	mv	a0,s2
 c5a:	3431                	jal	666 <insert_rb>
 c5c:	d96d                	beqz	a0,c4e <uart_putc+0x34>
    }
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c5e:	200027b7          	lui	a5,0x20002
 c62:	4b98                	lw	a4,16(a5)
  }
}
 c64:	40b2                	lw	ra,12(sp)
 c66:	4422                	lw	s0,8(sp)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c68:	00276713          	ori	a4,a4,2
 c6c:	cb98                	sw	a4,16(a5)
}
 c6e:	4492                	lw	s1,4(sp)
 c70:	4902                	lw	s2,0(sp)
 c72:	0141                	addi	sp,sp,16
 c74:	8082                	ret
  if (tx_buffer.head == tx_buffer.tail && (*UART_STATUS & STATUS_TX_EMPTY)) {
 c76:	20002737          	lui	a4,0x20002
 c7a:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 c7c:	4318                	lw	a4,0(a4)
 c7e:	8b11                	andi	a4,a4,4
 c80:	db5d                	beqz	a4,c36 <uart_putc+0x1c>
    *UART_TX_FIFO = (uint32_t)c;
 c82:	20002737          	lui	a4,0x20002
 c86:	c348                	sw	a0,4(a4)
    *UART_IRQ_EN |= IRQ_TX_EMPTY;
 c88:	4b98                	lw	a4,16(a5)
 c8a:	00276713          	ori	a4,a4,2
 c8e:	cb98                	sw	a4,16(a5)
 c90:	8082                	ret

00000c92 <uart_getc>:

char uart_getc(void) {
 c92:	1101                	addi	sp,sp,-32
 c94:	cc22                	sw	s0,24(sp)
 c96:	ce06                	sw	ra,28(sp)
 c98:	24018413          	addi	s0,gp,576 # 10000a80 <rx_buffer>
  char c;
  // Block only when the software buffer is completely empty
  while (!pop_rb(&rx_buffer, &c)) {
 c9c:	00f10593          	addi	a1,sp,15
 ca0:	8522                	mv	a0,s0
 ca2:	32ed                	jal	68c <pop_rb>
 ca4:	dd65                	beqz	a0,c9c <uart_getc+0xa>
    // Busy wait until the ISR receives new data
  }
  return c;
}
 ca6:	40f2                	lw	ra,28(sp)
 ca8:	4462                	lw	s0,24(sp)
 caa:	00f14503          	lbu	a0,15(sp)
 cae:	6105                	addi	sp,sp,32
 cb0:	8082                	ret

00000cb2 <uart_puts>:

void uart_puts(const char *str) {
 cb2:	1141                	addi	sp,sp,-16
 cb4:	c422                	sw	s0,8(sp)
 cb6:	c606                	sw	ra,12(sp)
 cb8:	842a                	mv	s0,a0
  while (*str != '\0') {
 cba:	00054503          	lbu	a0,0(a0)
 cbe:	c511                	beqz	a0,cca <uart_puts+0x18>
    uart_putc(*str);
 cc0:	3fa9                	jal	c1a <uart_putc>
  while (*str != '\0') {
 cc2:	00144503          	lbu	a0,1(s0)
    str++;
 cc6:	0405                	addi	s0,s0,1
  while (*str != '\0') {
 cc8:	fd65                	bnez	a0,cc0 <uart_puts+0xe>
  }
}
 cca:	40b2                	lw	ra,12(sp)
 ccc:	4422                	lw	s0,8(sp)
 cce:	0141                	addi	sp,sp,16
 cd0:	8082                	ret

00000cd2 <uart_polled_putc>:

void uart_polled_putc(char c) {
  // Wait directly on the hardware status register until TX FIFO is empty
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 cd2:	20002737          	lui	a4,0x20002
 cd6:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 cd8:	431c                	lw	a5,0(a4)
 cda:	8b91                	andi	a5,a5,4
 cdc:	dff5                	beqz	a5,cd8 <uart_polled_putc+0x6>
    ;
  *UART_TX_FIFO = (uint32_t)c;
 cde:	200027b7          	lui	a5,0x20002
 ce2:	c3c8                	sw	a0,4(a5)
}
 ce4:	8082                	ret

00000ce6 <uart_polled_puts>:

void uart_polled_puts(const char *str) {
  while (*str != '\0') {
 ce6:	00054683          	lbu	a3,0(a0)
 cea:	ce99                	beqz	a3,d08 <uart_polled_puts+0x22>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 cec:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 cf0:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 cf4:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 cf6:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 cf8:	431c                	lw	a5,0(a4)
 cfa:	8b91                	andi	a5,a5,4
 cfc:	dff5                	beqz	a5,cf8 <uart_polled_puts+0x12>
  *UART_TX_FIFO = (uint32_t)c;
 cfe:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 d00:	00154683          	lbu	a3,1(a0)
    uart_polled_putc(*str);
    str++;
 d04:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 d06:	faed                	bnez	a3,cf8 <uart_polled_puts+0x12>
  }
}
 d08:	8082                	ret

00000d0a <uart_print_hex>:
  while (*str != '\0') {
 d0a:	00054683          	lbu	a3,0(a0)

void uart_print_hex(const char *prefix, uint32_t val) {
 d0e:	1141                	addi	sp,sp,-16
  while (*str != '\0') {
 d10:	ce99                	beqz	a3,d2e <uart_print_hex+0x24>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d12:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 d16:	20002637          	lui	a2,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d1a:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 d1c:	0611                	addi	a2,a2,4 # 20002004 <_stack_top+0xfff2004>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d1e:	431c                	lw	a5,0(a4)
 d20:	8b91                	andi	a5,a5,4
 d22:	dff5                	beqz	a5,d1e <uart_print_hex+0x14>
  *UART_TX_FIFO = (uint32_t)c;
 d24:	c214                	sw	a3,0(a2)
  while (*str != '\0') {
 d26:	00154683          	lbu	a3,1(a0)
    str++;
 d2a:	0505                	addi	a0,a0,1
  while (*str != '\0') {
 d2c:	faed                	bnez	a3,d1e <uart_print_hex+0x14>
  uart_polled_puts(prefix);
  char buf[9];
  buf[8] = '\0';
 d2e:	00010623          	sb	zero,12(sp)
  for (int i = 7; i >= 0; i--) {
 d32:	005c                	addi	a5,sp,4
 d34:	ffc10513          	addi	a0,sp,-4
    uint32_t nibble = val & 0xF;
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 d38:	4625                	li	a2,9
    uint32_t nibble = val & 0xF;
 d3a:	00f5f713          	andi	a4,a1,15
    buf[i] = (nibble < 10) ? ('0' + nibble) : ('a' + nibble - 10);
 d3e:	05770693          	addi	a3,a4,87
 d42:	00e66463          	bltu	a2,a4,d4a <uart_print_hex+0x40>
 d46:	03070693          	addi	a3,a4,48
 d4a:	00d783a3          	sb	a3,7(a5) # 20002007 <_stack_top+0xfff2007>
  for (int i = 7; i >= 0; i--) {
 d4e:	17fd                	addi	a5,a5,-1
    val >>= 4;
 d50:	8191                	srli	a1,a1,0x4
  for (int i = 7; i >= 0; i--) {
 d52:	fef514e3          	bne	a0,a5,d3a <uart_print_hex+0x30>
  while (*str != '\0') {
 d56:	00414683          	lbu	a3,4(sp)
 d5a:	c285                	beqz	a3,d7a <uart_print_hex+0x70>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d5c:	20002737          	lui	a4,0x20002
  *UART_TX_FIFO = (uint32_t)c;
 d60:	200025b7          	lui	a1,0x20002
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d64:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
  *UART_TX_FIFO = (uint32_t)c;
 d66:	0591                	addi	a1,a1,4 # 20002004 <_stack_top+0xfff2004>
  while (*str != '\0') {
 d68:	0050                	addi	a2,sp,4
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d6a:	431c                	lw	a5,0(a4)
 d6c:	8b91                	andi	a5,a5,4
 d6e:	dff5                	beqz	a5,d6a <uart_print_hex+0x60>
  *UART_TX_FIFO = (uint32_t)c;
 d70:	c194                	sw	a3,0(a1)
  while (*str != '\0') {
 d72:	00164683          	lbu	a3,1(a2)
    str++;
 d76:	0605                	addi	a2,a2,1
  while (*str != '\0') {
 d78:	faed                	bnez	a3,d6a <uart_print_hex+0x60>
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d7a:	20002737          	lui	a4,0x20002
 d7e:	0721                	addi	a4,a4,8 # 20002008 <_stack_top+0xfff2008>
 d80:	431c                	lw	a5,0(a4)
 d82:	8b91                	andi	a5,a5,4
 d84:	dff5                	beqz	a5,d80 <uart_print_hex+0x76>
  *UART_TX_FIFO = (uint32_t)c;
 d86:	200027b7          	lui	a5,0x20002
 d8a:	46b5                	li	a3,13
 d8c:	c3d4                	sw	a3,4(a5)
  while (!(*UART_STATUS & STATUS_TX_EMPTY))
 d8e:	00878713          	addi	a4,a5,8 # 20002008 <_stack_top+0xfff2008>
 d92:	431c                	lw	a5,0(a4)
 d94:	8b91                	andi	a5,a5,4
 d96:	dff5                	beqz	a5,d92 <uart_print_hex+0x88>
  *UART_TX_FIFO = (uint32_t)c;
 d98:	200027b7          	lui	a5,0x20002
 d9c:	4729                	li	a4,10
 d9e:	c3d8                	sw	a4,4(a5)
  }
  uart_polled_puts(buf);
  uart_polled_puts("\r\n");
}
 da0:	0141                	addi	sp,sp,16
 da2:	8082                	ret
