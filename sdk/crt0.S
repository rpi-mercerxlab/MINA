.section .text.init
.global _start

_start:
    /* 1. Disable interrupts globally (good practice before setup) */
    csrw mstatus, zero
    
    /* 2. Set up the Global Pointer */
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    /* 3. Set up the Stack Pointer */
    la sp, _stack_top

    /* 4. Copy .data from SHARED_RAM to CPU_RAM */
    la a0, _data_load_start /* Source address */
    la a1, _sdata           /* Destination address */
    la a2, _edata           /* End of destination */
    bgeu a1, a2, end_copy_data /* Skip if no data */

    /* Enable FPU by setting mstatus.FS (bits 14:13) to 01 (Initial) or 11 (Dirty) */
    li t0, (3 << 13)
    csrs mstatus, t0
    csrwi fcsr, 0       /* Clear floating-point rounding mode and exception flags */
copy_data_loop:
    lw t0, 0(a0)            /* Load word from SHARED_RAM */
    sw t0, 0(a1)            /* Store word to CPU_RAM */
    addi a0, a0, 4          /* Increment source pointer */
    addi a1, a1, 4          /* Increment destination pointer */
    bltu a1, a2, copy_data_loop
end_copy_data:

    /* 5. Zero out the .bss section in CPU_RAM */
    la a0, _sbss
    la a1, _ebss
    bgeu a0, a1, end_clear_bss /* Skip if no bss */
clear_bss_loop:
    sw zero, 0(a0)
    addi a0, a0, 4
    bltu a0, a1, clear_bss_loop
end_clear_bss:

    /* 6. Jump to main C function */
    call main

    /* 7. Catch return from main (should not happen in bare-metal) */
inf_loop:
    j inf_loop
