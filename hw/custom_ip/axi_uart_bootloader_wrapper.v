`timescale 1ns / 1ps

// -----------------------------------------------------------------------------
// Verilog wrapper for the VHDL axi_uart_bootloader entity.
//
// The wrapped VHDL source may remain compiled as VHDL-2008, while the design
// above this wrapper can be Verilog/SystemVerilog or otherwise avoid directly
// depending on VHDL-2008 syntax.
// -----------------------------------------------------------------------------

module axi_uart_bootloader_wrapper #(
    parameter integer CLK_FREQ        = 100_000_000,
    parameter integer BAUD_RATE       = 115200,
    parameter integer AXI_ADDR_WIDTH  = 32,
    parameter integer FIFO_DEPTH      = 16,
    parameter integer BRAM_ADDR_WIDTH = 14,
    parameter integer NPU_HOST_ADDR_WIDTH = 16
)(
    // Clock / reset
    input  wire                          s_axi_aclk,
    input  wire                          s_axi_aresetn,

    // 0 = normal AXI UART
    // 1 = direct UART-to-BRAM bootloader
    input  wire                          boot_mode,

    // Physical UART
    input  wire                          uart_rx,
    output wire                          uart_tx,

    // Interrupt
    output wire                          uart_irq,

    // AXI4-Lite write address
    input  wire [AXI_ADDR_WIDTH-1:0]     s_axi_awaddr,
    input  wire                          s_axi_awvalid,
    output wire                          s_axi_awready,

    // AXI4-Lite write data
    input  wire [31:0]                   s_axi_wdata,
    input  wire [3:0]                    s_axi_wstrb,
    input  wire                          s_axi_wvalid,
    output wire                          s_axi_wready,

    // AXI4-Lite write response
    output wire [1:0]                    s_axi_bresp,
    output wire                          s_axi_bvalid,
    input  wire                          s_axi_bready,

    // AXI4-Lite read address
    input  wire [AXI_ADDR_WIDTH-1:0]     s_axi_araddr,
    input  wire                          s_axi_arvalid,
    output wire                          s_axi_arready,

    // AXI4-Lite read data
    output wire [31:0]                   s_axi_rdata,
    output wire [1:0]                    s_axi_rresp,
    output wire                          s_axi_rvalid,
    input  wire                          s_axi_rready,

    // Native BRAM write port
    output wire                          bram_en,
    output wire [3:0]                    bram_we,
    output wire [BRAM_ADDR_WIDTH-1:0]    bram_addr,
    output wire [31:0]                   bram_din,
    output wire npu_boot_active,
    input wire npu_ready,
    output wire npu_instr_we,
    output wire [9:0] npu_instr_addr,
    output wire [35:0] npu_instr_din,
    output wire npu_weight_we,
    output wire [NPU_HOST_ADDR_WIDTH-1:0] npu_weight_addr,
    output wire [31:0] npu_weight_din,
    output wire npu_scratchpad_we,
    output wire [NPU_HOST_ADDR_WIDTH-1:0] npu_scratchpad_addr,
    output wire [31:0] npu_scratchpad_din
);

    axi_uart_bootloader #(
        .CLK_FREQ        (CLK_FREQ),
        .BAUD_RATE       (BAUD_RATE),
        .AXI_ADDR_WIDTH  (AXI_ADDR_WIDTH),
        .FIFO_DEPTH      (FIFO_DEPTH),
        .BRAM_ADDR_WIDTH (BRAM_ADDR_WIDTH),
        .NPU_HOST_ADDR_WIDTH (NPU_HOST_ADDR_WIDTH)
    ) u_axi_uart_bootloader (
        .s_axi_aclk      (s_axi_aclk),
        .s_axi_aresetn   (s_axi_aresetn),

        .boot_mode       (boot_mode),

        .uart_rx         (uart_rx),
        .uart_tx         (uart_tx),

        .uart_irq        (uart_irq),

        .s_axi_awaddr    (s_axi_awaddr),
        .s_axi_awvalid   (s_axi_awvalid),
        .s_axi_awready   (s_axi_awready),

        .s_axi_wdata     (s_axi_wdata),
        .s_axi_wstrb     (s_axi_wstrb),
        .s_axi_wvalid    (s_axi_wvalid),
        .s_axi_wready    (s_axi_wready),

        .s_axi_bresp     (s_axi_bresp),
        .s_axi_bvalid    (s_axi_bvalid),
        .s_axi_bready    (s_axi_bready),

        .s_axi_araddr    (s_axi_araddr),
        .s_axi_arvalid   (s_axi_arvalid),
        .s_axi_arready   (s_axi_arready),

        .s_axi_rdata     (s_axi_rdata),
        .s_axi_rresp     (s_axi_rresp),
        .s_axi_rvalid    (s_axi_rvalid),
        .s_axi_rready    (s_axi_rready),

        .bram_en         (bram_en),
        .bram_we         (bram_we),
        .bram_addr       (bram_addr),
        .bram_din        (bram_din),
        .npu_boot_active (npu_boot_active),
        .npu_ready (npu_ready),
        .npu_instr_we (npu_instr_we),
        .npu_instr_addr (npu_instr_addr),
        .npu_instr_din (npu_instr_din),
        .npu_weight_we (npu_weight_we),
        .npu_weight_addr (npu_weight_addr),
        .npu_weight_din (npu_weight_din),
        .npu_scratchpad_we (npu_scratchpad_we),
        .npu_scratchpad_addr (npu_scratchpad_addr),
        .npu_scratchpad_din (npu_scratchpad_din)
    );

endmodule
