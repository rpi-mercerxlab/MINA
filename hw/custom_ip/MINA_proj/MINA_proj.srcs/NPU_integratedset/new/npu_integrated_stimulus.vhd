library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity tb_design_1_wrapper is
end tb_design_1_wrapper;

architecture Behavioral of tb_design_1_wrapper is

    --------------------------------------------------------------------------
    -- DUT declaration
    --------------------------------------------------------------------------
    component design_1_wrapper
        port (
            GPIO_0_tri_io  : inout std_logic_vector(3 downto 0);
            IOBUF_scl      : inout std_logic_vector(0 downto 0);
            IOBUF_sda      : inout std_logic_vector(0 downto 0);
            SPI_0_0_io0_io : inout std_logic;
            SPI_0_0_io1_io : inout std_logic;
            SPI_0_0_sck_io : inout std_logic;
            SPI_0_0_ss_io  : inout std_logic_vector(0 downto 0);
            cpu_rst        : in    std_logic;
            in_clk         : in    std_logic;
            sys_rst        : in    std_logic;
            uart_rx_0      : in    std_logic;
            uart_tx_0      : out   std_logic
        );
    end component;

    --------------------------------------------------------------------------
    -- Clock / UART constants
    --------------------------------------------------------------------------
    constant CLK_PERIOD : time := 10 ns;       -- 100 MHz

    --NOTE FOR SIMULATION SPEED:
    -- At 115200 baud (8680556 ps/bit), uploading 786 firmware words + 16 weight
    -- words + 6 NPU instructions (808 packets * 11 bytes * 10 bits = 88,880 bits)
    -- takes ~771.5 ms of simulated time!
    -- Tip: If you temporarily set BAUD_RATE = 10_000_000 in design_1, change
    -- BIT_PERIOD to 100 ns to cut simulation time by 86x.
    constant BIT_PERIOD : time := 8680556 ps;

    constant UART_ACK        : std_logic_vector(7 downto 0) := x"06";
    constant UART_NACK       : std_logic_vector(7 downto 0) := x"15";

    constant SYNC_BYTE       : std_logic_vector(7 downto 0) := x"55";
    constant CMD_WRITE       : std_logic_vector(7 downto 0) := x"01";
    constant CMD_NPU_INSTR   : std_logic_vector(7 downto 0) := x"02";
    constant CMD_NPU_WEIGHT  : std_logic_vector(7 downto 0) := x"03";
    constant CMD_NPU_SCRATCH : std_logic_vector(7 downto 0) := x"04";

    --------------------------------------------------------------------------
    -- Embedded Payloads (CPU Firmware + NPU Weights + NPU Instructions)
    --------------------------------------------------------------------------
    constant NUM_FW_WORDS : natural := 786;
    type word32_array_t is array (natural range <>) of std_logic_vector(31 downto 0);
    type word36_array_t is array (natural range <>) of std_logic_vector(35 downto 0);

    -- 1. NPU Weight Matrix (8x8 Identity Matrix scaled by 16 = 0x10 on diagonal,
    --    so that quant_mult = 256 (0x100) and shift_amt = 0 yield 1:1 output)
    constant NPU_WEIGHT_WORDS : word32_array_t(0 to 15) := (
        0  => x"00000010", 1  => x"00000000", -- Row 0: col 0 = 16
        2  => x"00001000", 3  => x"00000000", -- Row 1: col 1 = 16
        4  => x"00100000", 5  => x"00000000", -- Row 2: col 2 = 16
        6  => x"10000000", 7  => x"00000000", -- Row 3: col 3 = 16
        8  => x"00000000", 9  => x"00000010", -- Row 4: col 4 = 16
        10 => x"00000000", 11 => x"00001000", -- Row 5: col 5 = 16
        12 => x"00000000", 13 => x"00100000", -- Row 6: col 6 = 16
        14 => x"00000000", 15 => x"10000000"  -- Row 7: col 7 = 16
    );

    -- 2. NPU Instruction Stream (36-bit instructions, stride = 8 bytes)
    --    Fixed Halt-and-Handshake Program (6 instructions):
    --    Clears accumulators, drives A(0x40)*B(0x00), drains to C(0x80) with
    --    quant_mult=0x100, sets interrupt addr 0x80, triggers IRQ, and waits
    --    at PC 5 until the CPU ISR halts, reads/writes scratchpad, and resets.
    constant NUM_NPU_INSTRS : natural := 6;
    constant NPU_INSTR_WORDS : word36_array_t(0 to NUM_NPU_INSTRS - 1) := (
        0 => x"010000000", -- clear                    (clear PE accumulators)
        1 => x"000100000", -- drive 00, 0x40, 0x00     (A=0x40, B=0x00)
        2 => x"020800100", -- drain 0x80, 00, 0, 0x100 (C=0x80, mult=256, shift=0)
        3 => x"040800000", -- set_int_addr 0x80        (int_addr <= 0x80)
        4 => x"030000000", -- trigger_int              (assert NPU IRQ to PLIC)
        5 => x"050140000"  -- j 0x05                   (spin at PC 5 until CPU halts/resets)
    );

    -- 3. CPU Firmware Image (3,144 bytes = 786 32-bit words from firmware.bin)
    constant FIRMWARE_WORDS : word32_array_t(0 to NUM_FW_WORDS - 1) := (
          0 => x"30001073", -- byte addr 0x0000
          1 => x"10001197", -- byte addr 0x0004
          2 => x"83C18193", -- byte addr 0x0008
          3 => x"10010117", -- byte addr 0x000C
          4 => x"FF410113", -- byte addr 0x0010
          5 => x"00001517", -- byte addr 0x0014
          6 => x"BF450513", -- byte addr 0x0018
          7 => x"10000597", -- byte addr 0x001C
          8 => x"FE458593", -- byte addr 0x0020
          9 => x"10000617", -- byte addr 0x0024
         10 => x"01C60613", -- byte addr 0x0028
         11 => x"00C5FA63", -- byte addr 0x002C
         12 => x"00052283", -- byte addr 0x0030
         13 => x"0055A023", -- byte addr 0x0034
         14 => x"05910511", -- byte addr 0x0038
         15 => x"FEC5EAE3", -- byte addr 0x003C
         16 => x"10000517", -- byte addr 0x0040
         17 => x"00050513", -- byte addr 0x0044
         18 => x"10001597", -- byte addr 0x0048
         19 => x"93058593", -- byte addr 0x004C
         20 => x"00B57763", -- byte addr 0x0050
         21 => x"00052023", -- byte addr 0x0054
         22 => x"6DE30511", -- byte addr 0x0058
         23 => x"22F9FEB5", -- byte addr 0x005C
         24 => x"0E37A001", -- byte addr 0x0060
         25 => x"43031000", -- byte addr 0x0064
         26 => x"0837044E", -- byte addr 0x0068
         27 => x"08B74030", -- byte addr 0x006C
         28 => x"07934030", -- byte addr 0x0070
         29 => x"08130083", -- byte addr 0x0074
         30 => x"88932008", -- byte addr 0x0078
         31 => x"86932408", -- byte addr 0x007C
         32 => x"F6130087", -- byte addr 0x0080
         33 => x"871307F7", -- byte addr 0x0084
         34 => x"85130207", -- byte addr 0x0088
         35 => x"F6930287", -- byte addr 0x008C
         36 => x"062207F6", -- byte addr 0x0090
         37 => x"FF878F13", -- byte addr 0x0094
         38 => x"01078593", -- byte addr 0x0098
         39 => x"771306C2", -- byte addr 0x009C
         40 => x"751307F7", -- byte addr 0x00A0
         41 => x"8ED107F5", -- byte addr 0x00A4
         42 => x"8E930542", -- byte addr 0x00A8
         43 => x"86130187", -- byte addr 0x00AC
         44 => x"7F130307", -- byte addr 0x00B0
         45 => x"F59307FF", -- byte addr 0x00B4
         46 => x"072207F5", -- byte addr 0x00B8
         47 => x"01E6E6B3", -- byte addr 0x00BC
         48 => x"05E28F49", -- byte addr 0x00C0
         49 => x"07FEF513", -- byte addr 0x00C4
         50 => x"07F67613", -- byte addr 0x00C8
         51 => x"8F498DD5", -- byte addr 0x00CC
         52 => x"01861693", -- byte addr 0x00D0
         53 => x"00B82023", -- byte addr 0x00D4
         54 => x"22238F55", -- byte addr 0x00D8
         55 => x"082100E8", -- byte addr 0x00DC
         56 => x"1EE30785", -- byte addr 0x00E0
         57 => x"0793F918", -- byte addr 0x00E4
         58 => x"F7930403", -- byte addr 0x00E8
         59 => x"022307F7", -- byte addr 0x00EC
         60 => x"808204FE", -- byte addr 0x00F0
         61 => x"06B77179", -- byte addr 0x00F4
         62 => x"D6064000", -- byte addr 0x00F8
         63 => x"D226D422", -- byte addr 0x00FC
         64 => x"CE4ED04A", -- byte addr 0x0100
         65 => x"CA56CC52", -- byte addr 0x0104
         66 => x"C65EC85A", -- byte addr 0x0108
         67 => x"C266C462", -- byte addr 0x010C
         68 => x"0006A023", -- byte addr 0x0110
         69 => x"00468713", -- byte addr 0x0114
         70 => x"8B85431C", -- byte addr 0x0118
         71 => x"429CDFF5", -- byte addr 0x011C
         72 => x"40300B37", -- byte addr 0x0120
         73 => x"CCCCD4B7", -- byte addr 0x0124
         74 => x"E7938B85", -- byte addr 0x0128
         75 => x"8BB70087", -- byte addr 0x012C
         76 => x"C29C51EB", -- byte addr 0x0130
         77 => x"408B0B13", -- byte addr 0x0134
         78 => x"CCD48493", -- byte addr 0x0138
         79 => x"51FB8B93", -- byte addr 0x013C
         80 => x"0A934C25", -- byte addr 0x0140
         81 => x"0A13FF8B", -- byte addr 0x0144
         82 => x"A9830630", -- byte addr 0x0148
         83 => x"4C81000A", -- byte addr 0x014C
         84 => x"02000913", -- byte addr 0x0150
         85 => x"0199D433", -- byte addr 0x0154
         86 => x"0FF47413", -- byte addr 0x0158
         87 => x"02000513", -- byte addr 0x015C
         88 => x"0A8A7F63", -- byte addr 0x0160
         89 => x"03743533", -- byte addr 0x0164
         90 => x"05138115", -- byte addr 0x0168
         91 => x"00EF0305", -- byte addr 0x016C
         92 => x"35331F30", -- byte addr 0x0170
         93 => x"810D0294", -- byte addr 0x0174
         94 => x"02953733", -- byte addr 0x0178
         95 => x"1793830D", -- byte addr 0x017C
         96 => x"97BA0027", -- byte addr 0x0180
         97 => x"8D1D0786", -- byte addr 0x0184
         98 => x"03050513", -- byte addr 0x0188
         99 => x"0FF57513", -- byte addr 0x018C
        100 => x"1D1000EF", -- byte addr 0x0190
        101 => x"02943733", -- byte addr 0x0194
        102 => x"830D0CA1", -- byte addr 0x0198
        103 => x"00271793", -- byte addr 0x019C
        104 => x"078697BA", -- byte addr 0x01A0
        105 => x"40F40533", -- byte addr 0x01A4
        106 => x"03050513", -- byte addr 0x01A8
        107 => x"0FF57513", -- byte addr 0x01AC
        108 => x"1B1000EF", -- byte addr 0x01B0
        109 => x"02000513", -- byte addr 0x01B4
        110 => x"1A9000EF", -- byte addr 0x01B8
        111 => x"F92C9CE3", -- byte addr 0x01BC
        112 => x"14E30A91", -- byte addr 0x01C0
        113 => x"4535F95B", -- byte addr 0x01C4
        114 => x"199000EF", -- byte addr 0x01C8
        115 => x"00EF4529", -- byte addr 0x01CC
        116 => x"07B71930", -- byte addr 0x01D0
        117 => x"0B214030", -- byte addr 0x01D4
        118 => x"44878793", -- byte addr 0x01D8
        119 => x"F6FB13E3", -- byte addr 0x01DC
        120 => x"00EF4535", -- byte addr 0x01E0
        121 => x"452917F0", -- byte addr 0x01E4
        122 => x"179000EF", -- byte addr 0x01E8
        123 => x"06B73D9D", -- byte addr 0x01EC
        124 => x"47894000", -- byte addr 0x01F0
        125 => x"8713C29C", -- byte addr 0x01F4
        126 => x"431C0046", -- byte addr 0x01F8
        127 => x"DFF58B85", -- byte addr 0x01FC
        128 => x"542250B2", -- byte addr 0x0200
        129 => x"C29C4785", -- byte addr 0x0204
        130 => x"59025492", -- byte addr 0x0208
        131 => x"4A6249F2", -- byte addr 0x020C
        132 => x"4B424AD2", -- byte addr 0x0210
        133 => x"4C224BB2", -- byte addr 0x0214
        134 => x"61454C92", -- byte addr 0x0218
        135 => x"00EF8082", -- byte addr 0x021C
        136 => x"05131430", -- byte addr 0x0220
        137 => x"75E30200", -- byte addr 0x0224
        138 => x"B7A1F68C", -- byte addr 0x0228
        139 => x"C6061141", -- byte addr 0x022C
        140 => x"28A9C422", -- byte addr 0x0230
        141 => x"0F9000EF", -- byte addr 0x0234
        142 => x"0F400513", -- byte addr 0x0238
        143 => x"46414691", -- byte addr 0x023C
        144 => x"2E154585", -- byte addr 0x0240
        145 => x"40000437", -- byte addr 0x0244
        146 => x"C01C4789", -- byte addr 0x0248
        147 => x"8B85405C", -- byte addr 0x024C
        148 => x"3D01DFF5", -- byte addr 0x0250
        149 => x"C01C4785", -- byte addr 0x0254
        150 => x"10500073", -- byte addr 0x0258
        151 => x"10500073", -- byte addr 0x025C
        152 => x"3737BFE5", -- byte addr 0x0260
        153 => x"43542000", -- byte addr 0x0264
        154 => x"97B34785", -- byte addr 0x0268
        155 => x"8FD500A7", -- byte addr 0x026C
        156 => x"8082C35C", -- byte addr 0x0270
        157 => x"20003737", -- byte addr 0x0274
        158 => x"47854354", -- byte addr 0x0278
        159 => x"00A797B3", -- byte addr 0x027C
        160 => x"FFF7C793", -- byte addr 0x0280
        161 => x"C35C8FF5", -- byte addr 0x0284
        162 => x"00008082", -- byte addr 0x0288
        163 => x"32400793", -- byte addr 0x028C
        164 => x"30579073", -- byte addr 0x0290
        165 => x"87936785", -- byte addr 0x0294
        166 => x"A7F38007", -- byte addr 0x0298
        167 => x"67F33047", -- byte addr 0x029C
        168 => x"80823004", -- byte addr 0x02A0
        169 => x"07B77179", -- byte addr 0x02A4
        170 => x"C85A2000", -- byte addr 0x02A8
        171 => x"0B37C65E", -- byte addr 0x02AC
        172 => x"AB831000", -- byte addr 0x02B0
        173 => x"0B130047", -- byte addr 0x02B4
        174 => x"D04A000B", -- byte addr 0x02B8
        175 => x"0AB7CA56", -- byte addr 0x02BC
        176 => x"D2262000", -- byte addr 0x02C0
        177 => x"CC52CE4E", -- byte addr 0x02C4
        178 => x"D606C462", -- byte addr 0x02C8
        179 => x"84DAD422", -- byte addr 0x02CC
        180 => x"020B0A13", -- byte addr 0x02D0
        181 => x"81018913", -- byte addr 0x02D4
        182 => x"49850AA1", -- byte addr 0x02D8
        183 => x"409C5C7D", -- byte addr 0x02DC
        184 => x"00F99433", -- byte addr 0x02E0
        185 => x"00279713", -- byte addr 0x02E4
        186 => x"017477B3", -- byte addr 0x02E8
        187 => x"00E906B3", -- byte addr 0x02EC
        188 => x"429CCB91", -- byte addr 0x02F0
        189 => x"C799975A", -- byte addr 0x02F4
        190 => x"05635318", -- byte addr 0x02F8
        191 => x"97820187", -- byte addr 0x02FC
        192 => x"008AA023", -- byte addr 0x0300
        193 => x"9CE30491", -- byte addr 0x0304
        194 => x"50B2FD44", -- byte addr 0x0308
        195 => x"54925422", -- byte addr 0x030C
        196 => x"49F25902", -- byte addr 0x0310
        197 => x"4AD24A62", -- byte addr 0x0314
        198 => x"4BB24B42", -- byte addr 0x0318
        199 => x"61454C22", -- byte addr 0x031C
        200 => x"00018082", -- byte addr 0x0320
        201 => x"DE067139", -- byte addr 0x0324
        202 => x"DA1ADC16", -- byte addr 0x0328
        203 => x"D62AD81E", -- byte addr 0x032C
        204 => x"D232D42E", -- byte addr 0x0330
        205 => x"CE3AD036", -- byte addr 0x0334
        206 => x"CA42CC3E", -- byte addr 0x0338
        207 => x"C672C846", -- byte addr 0x033C
        208 => x"C27AC476", -- byte addr 0x0340
        209 => x"27F3C07E", -- byte addr 0x0344
        210 => x"C5633420", -- byte addr 0x0348
        211 => x"50F20207", -- byte addr 0x034C
        212 => x"535252E2", -- byte addr 0x0350
        213 => x"553253C2", -- byte addr 0x0354
        214 => x"561255A2", -- byte addr 0x0358
        215 => x"47725682", -- byte addr 0x035C
        216 => x"485247E2", -- byte addr 0x0360
        217 => x"4E3248C2", -- byte addr 0x0364
        218 => x"4F124EA2", -- byte addr 0x0368
        219 => x"61214F82", -- byte addr 0x036C
        220 => x"30200073", -- byte addr 0x0370
        221 => x"83850786", -- byte addr 0x0374
        222 => x"8C63472D", -- byte addr 0x0378
        223 => x"471D00E7", -- byte addr 0x037C
        224 => x"FCE797E3", -- byte addr 0x0380
        225 => x"100007B7", -- byte addr 0x0384
        226 => x"0487A783", -- byte addr 0x0388
        227 => x"9782D3E9", -- byte addr 0x038C
        228 => x"3F09BF7D", -- byte addr 0x0390
        229 => x"1141BF6D", -- byte addr 0x0394
        230 => x"100007B7", -- byte addr 0x0398
        231 => x"00078793", -- byte addr 0x039C
        232 => x"C426C622", -- byte addr 0x03A0
        233 => x"C04EC24A", -- byte addr 0x03A4
        234 => x"C7984709", -- byte addr 0x03A8
        235 => x"C7D8470D", -- byte addr 0x03AC
        236 => x"CB984711", -- byte addr 0x03B0
        237 => x"CBD84715", -- byte addr 0x03B4
        238 => x"CF984719", -- byte addr 0x03B8
        239 => x"0207A283", -- byte addr 0x03BC
        240 => x"53C4471D", -- byte addr 0x03C0
        241 => x"4705CFD8", -- byte addr 0x03C4
        242 => x"0007A023", -- byte addr 0x03C8
        243 => x"8EBAC3D8", -- byte addr 0x03CC
        244 => x"DA634401", -- byte addr 0x03D0
        245 => x"86960092", -- byte addr 0x03D4
        246 => x"82A6C398", -- byte addr 0x03D8
        247 => x"0007A223", -- byte addr 0x03DC
        248 => x"843A84B6", -- byte addr 0x03E0
        249 => x"578C4E81", -- byte addr 0x03E4
        250 => x"4F0D57D8", -- byte addr 0x03E8
        251 => x"DB634809", -- byte addr 0x03EC
        252 => x"86AE00E5", -- byte addr 0x03F0
        253 => x"01E7A423", -- byte addr 0x03F4
        254 => x"0107A623", -- byte addr 0x03F8
        255 => x"8F4285BA", -- byte addr 0x03FC
        256 => x"480D8736", -- byte addr 0x0400
        257 => x"5BD05B94", -- byte addr 0x0404
        258 => x"43114E15", -- byte addr 0x0408
        259 => x"00C6DB63", -- byte addr 0x040C
        260 => x"A8238536", -- byte addr 0x0410
        261 => x"AA2301C7", -- byte addr 0x0414
        262 => x"86B20067", -- byte addr 0x0418
        263 => x"862A8E1A", -- byte addr 0x041C
        264 => x"5F884315", -- byte addr 0x0420
        265 => x"03C7AF83", -- byte addr 0x0424
        266 => x"4899439D", -- byte addr 0x0428
        267 => x"01F55B63", -- byte addr 0x042C
        268 => x"AC23892A", -- byte addr 0x0430
        269 => x"AE230077", -- byte addr 0x0434
        270 => x"857E0117", -- byte addr 0x0438
        271 => x"8FCA83C6", -- byte addr 0x043C
        272 => x"DB63489D", -- byte addr 0x0440
        273 => x"89AE00B2", -- byte addr 0x0444
        274 => x"A0238942", -- byte addr 0x0448
        275 => x"C7800107", -- byte addr 0x044C
        276 => x"88228596", -- byte addr 0x0450
        277 => x"844A82CE", -- byte addr 0x0454
        278 => x"00E4DC63", -- byte addr 0x0458
        279 => x"897689A6", -- byte addr 0x045C
        280 => x"01D7A623", -- byte addr 0x0460
        281 => x"01E7A223", -- byte addr 0x0464
        282 => x"8EFA84BA", -- byte addr 0x0468
        283 => x"8F4A874E", -- byte addr 0x046C
        284 => x"00A6DC63", -- byte addr 0x0470
        285 => x"894689AA", -- byte addr 0x0474
        286 => x"0117A823", -- byte addr 0x0478
        287 => x"0067AC23", -- byte addr 0x047C
        288 => x"889A8536", -- byte addr 0x0480
        289 => x"834A86CE", -- byte addr 0x0484
        290 => x"01F65C63", -- byte addr 0x0488
        291 => x"897289B2", -- byte addr 0x048C
        292 => x"01C7AE23", -- byte addr 0x0490
        293 => x"0077AA23", -- byte addr 0x0494
        294 => x"8E1E867E", -- byte addr 0x0498
        295 => x"83CA8FCE", -- byte addr 0x049C
        296 => x"00B4DC63", -- byte addr 0x04A0
        297 => x"897689A6", -- byte addr 0x04A4
        298 => x"01D7A423", -- byte addr 0x04A8
        299 => x"0107A223", -- byte addr 0x04AC
        300 => x"8EC284AE", -- byte addr 0x04B0
        301 => x"884A85CE", -- byte addr 0x04B4
        302 => x"00A65C63", -- byte addr 0x04B8
        303 => x"897289B2", -- byte addr 0x04BC
        304 => x"01C7AC23", -- byte addr 0x04C0
        305 => x"0117AA23", -- byte addr 0x04C4
        306 => x"8E46862A", -- byte addr 0x04C8
        307 => x"88CA854E", -- byte addr 0x04CC
        308 => x"00D2D763", -- byte addr 0x04D0
        309 => x"0067A023", -- byte addr 0x04D4
        310 => x"8696CB80", -- byte addr 0x04D8
        311 => x"58638322", -- byte addr 0x04DC
        312 => x"AE2301F7", -- byte addr 0x04E0
        313 => x"A62301E7", -- byte addr 0x04E4
        314 => x"877E0077", -- byte addr 0x04E8
        315 => x"DC638F1E", -- byte addr 0x04EC
        316 => x"82A600C4", -- byte addr 0x04F0
        317 => x"AA238FF6", -- byte addr 0x04F4
        318 => x"A22301D7", -- byte addr 0x04F8
        319 => x"84B201C7", -- byte addr 0x04FC
        320 => x"86168EF2", -- byte addr 0x0500
        321 => x"DC638E7E", -- byte addr 0x0504
        322 => x"82AA00A5", -- byte addr 0x0508
        323 => x"A4238FC6", -- byte addr 0x050C
        324 => x"AC230117", -- byte addr 0x0510
        325 => x"852E0107", -- byte addr 0x0514
        326 => x"859688C2", -- byte addr 0x0518
        327 => x"D863887E", -- byte addr 0x051C
        328 => x"A22300D4", -- byte addr 0x0520
        329 => x"A8230067", -- byte addr 0x0524
        330 => x"86A601D7", -- byte addr 0x0528
        331 => x"58638376", -- byte addr 0x052C
        332 => x"AC2300A7", -- byte addr 0x0530
        333 => x"A62301E7", -- byte addr 0x0534
        334 => x"872A0117", -- byte addr 0x0538
        335 => x"D8638F46", -- byte addr 0x053C
        336 => x"A42300D5", -- byte addr 0x0540
        337 => x"A8230067", -- byte addr 0x0544
        338 => x"86AE0107", -- byte addr 0x0548
        339 => x"58638342", -- byte addr 0x054C
        340 => x"AA2300C7", -- byte addr 0x0550
        341 => x"A62301E7", -- byte addr 0x0554
        342 => x"873201C7", -- byte addr 0x0558
        343 => x"56638F72", -- byte addr 0x055C
        344 => x"A62300D7", -- byte addr 0x0560
        345 => x"A8230067", -- byte addr 0x0564
        346 => x"443201E7", -- byte addr 0x0568
        347 => x"491244A2", -- byte addr 0x056C
        348 => x"01414982", -- byte addr 0x0570
        349 => x"08B78082", -- byte addr 0x0574
        350 => x"A8032000", -- byte addr 0x0578
        351 => x"07B70008", -- byte addr 0x057C
        352 => x"068A1000", -- byte addr 0x0580
        353 => x"81018713", -- byte addr 0x0584
        354 => x"00078793", -- byte addr 0x0588
        355 => x"97B69736", -- byte addr 0x058C
        356 => x"D38CC308", -- byte addr 0x0590
        357 => x"00C86833", -- byte addr 0x0594
        358 => x"0108A023", -- byte addr 0x0598
        359 => x"07B7BBED", -- byte addr 0x059C
        360 => x"A4231000", -- byte addr 0x05A0
        361 => x"808204A7", -- byte addr 0x05A4
        362 => x"10050023", -- byte addr 0x05A8
        363 => x"100500A3", -- byte addr 0x05AC
        364 => x"00238082", -- byte addr 0x05B0
        365 => x"00A31005", -- byte addr 0x05B4
        366 => x"80821005", -- byte addr 0x05B8
        367 => x"10054703", -- byte addr 0x05BC
        368 => x"10154683", -- byte addr 0x05C0
        369 => x"00170793", -- byte addr 0x05C4
        370 => x"0FF7F793", -- byte addr 0x05C8
        371 => x"00F68963", -- byte addr 0x05CC
        372 => x"0023972A", -- byte addr 0x05D0
        373 => x"002300B7", -- byte addr 0x05D4
        374 => x"450510F5", -- byte addr 0x05D8
        375 => x"45018082", -- byte addr 0x05DC
        376 => x"47038082", -- byte addr 0x05E0
        377 => x"46831015", -- byte addr 0x05E4
        378 => x"87AA1005", -- byte addr 0x05E8
        379 => x"00E68E63", -- byte addr 0x05EC
        380 => x"4703972A", -- byte addr 0x05F0
        381 => x"45050007", -- byte addr 0x05F4
        382 => x"00E58023", -- byte addr 0x05F8
        383 => x"1017C703", -- byte addr 0x05FC
        384 => x"80A3972A", -- byte addr 0x0600
        385 => x"808210E7", -- byte addr 0x0604
        386 => x"80824501", -- byte addr 0x0608
        387 => x"C6061141", -- byte addr 0x060C
        388 => x"20000737", -- byte addr 0x0610
        389 => x"C71456FD", -- byte addr 0x0614
        390 => x"C7546505", -- byte addr 0x0618
        391 => x"84850513", -- byte addr 0x061C
        392 => x"07933FBD", -- byte addr 0x0620
        393 => x"A7F30800", -- byte addr 0x0624
        394 => x"40B23047", -- byte addr 0x0628
        395 => x"80820141", -- byte addr 0x062C
        396 => x"200007B7", -- byte addr 0x0630
        397 => x"07B74788", -- byte addr 0x0634
        398 => x"47CC2000", -- byte addr 0x0638
        399 => x"07B78082", -- byte addr 0x063C
        400 => x"56FD2000", -- byte addr 0x0640
        401 => x"C7CCC794", -- byte addr 0x0644
        402 => x"8082C788", -- byte addr 0x0648
        403 => x"83018793", -- byte addr 0x064C
        404 => x"95BE058A", -- byte addr 0x0650
        405 => x"4194050A", -- byte addr 0x0654
        406 => x"439897AA", -- byte addr 0x0658
        407 => x"C198C394", -- byte addr 0x065C
        408 => x"97938082", -- byte addr 0x0660
        409 => x"86930015", -- byte addr 0x0664
        410 => x"88130017", -- byte addr 0x0668
        411 => x"07898301", -- byte addr 0x066C
        412 => x"06A6DE63", -- byte addr 0x0670
        413 => x"00269713", -- byte addr 0x0674
        414 => x"00259613", -- byte addr 0x0678
        415 => x"03339742", -- byte addr 0x067C
        416 => x"288300C8", -- byte addr 0x0680
        417 => x"2E030007", -- byte addr 0x0684
        418 => x"A7030003", -- byte addr 0x0688
        419 => x"23030048", -- byte addr 0x068C
        420 => x"A883004E", -- byte addr 0x0690
        421 => x"68630008", -- byte addr 0x0694
        422 => x"19630067", -- byte addr 0x0698
        423 => x"230304E3", -- byte addr 0x069C
        424 => x"F563000E", -- byte addr 0x06A0
        425 => x"DD630468", -- byte addr 0x06A4
        426 => x"931300A7", -- byte addr 0x06A8
        427 => x"93420027", -- byte addr 0x06AC
        428 => x"00032E03", -- byte addr 0x06B0
        429 => x"004E2303", -- byte addr 0x06B4
        430 => x"00E36563", -- byte addr 0x06B8
        431 => x"06E30563", -- byte addr 0x06BC
        432 => x"816387B6", -- byte addr 0x06C0
        433 => x"971306B7", -- byte addr 0x06C4
        434 => x"97420027", -- byte addr 0x06C8
        435 => x"00C806B3", -- byte addr 0x06CC
        436 => x"00072883", -- byte addr 0x06D0
        437 => x"85BE4290", -- byte addr 0x06D4
        438 => x"0116A023", -- byte addr 0x06D8
        439 => x"00159793", -- byte addr 0x06DC
        440 => x"00178693", -- byte addr 0x06E0
        441 => x"0789C310", -- byte addr 0x06E4
        442 => x"F8A6C6E3", -- byte addr 0x06E8
        443 => x"00A7C363", -- byte addr 0x06EC
        444 => x"96138082", -- byte addr 0x06F0
        445 => x"97130025", -- byte addr 0x06F4
        446 => x"06B30027", -- byte addr 0x06F8
        447 => x"974200C8", -- byte addr 0x06FC
        448 => x"0006A303", -- byte addr 0x0700
        449 => x"00072883", -- byte addr 0x0704
        450 => x"00432683", -- byte addr 0x0708
        451 => x"0048A703", -- byte addr 0x070C
        452 => x"FAD769E3", -- byte addr 0x0710
        453 => x"00E69863", -- byte addr 0x0714
        454 => x"00032683", -- byte addr 0x0718
        455 => x"0008A703", -- byte addr 0x071C
        456 => x"FAD761E3", -- byte addr 0x0720
        457 => x"27038082", -- byte addr 0x0724
        458 => x"6CE3000E", -- byte addr 0x0728
        459 => x"87B6F917", -- byte addr 0x072C
        460 => x"5F63BF49", -- byte addr 0x0730
        461 => x"861304A0", -- byte addr 0x0734
        462 => x"17938301", -- byte addr 0x0738
        463 => x"97B20025", -- byte addr 0x073C
        464 => x"0007A303", -- byte addr 0x0740
        465 => x"FFF50713", -- byte addr 0x0744
        466 => x"2E838705", -- byte addr 0x0748
        467 => x"2E030003", -- byte addr 0x074C
        468 => x"A8090043", -- byte addr 0x0750
        469 => x"A023C10C", -- byte addr 0x0754
        470 => x"96C20067", -- byte addr 0x0758
        471 => x"CB0D853A", -- byte addr 0x075C
        472 => x"4016D713", -- byte addr 0x0760
        473 => x"00271793", -- byte addr 0x0764
        474 => x"00F606B3", -- byte addr 0x0768
        475 => x"050A428C", -- byte addr 0x076C
        476 => x"FFF70813", -- byte addr 0x0770
        477 => x"0045A883", -- byte addr 0x0774
        478 => x"953287B6", -- byte addr 0x0778
        479 => x"01F85693", -- byte addr 0x077C
        480 => x"FD1E6AE3", -- byte addr 0x0780
        481 => x"01C89663", -- byte addr 0x0784
        482 => x"0005A883", -- byte addr 0x0788
        483 => x"FD1EE4E3", -- byte addr 0x078C
        484 => x"A6838082", -- byte addr 0x0790
        485 => x"0A2380C1", -- byte addr 0x0794
        486 => x"50630005", -- byte addr 0x0798
        487 => x"861306D0", -- byte addr 0x079C
        488 => x"87B28301", -- byte addr 0x07A0
        489 => x"A0214581", -- byte addr 0x07A4
        490 => x"88630585", -- byte addr 0x07A8
        491 => x"439804D5", -- byte addr 0x07AC
        492 => x"1BE30791", -- byte addr 0x07B0
        493 => x"8513FEE5", -- byte addr 0x07B4
        494 => x"1793FFF6", -- byte addr 0x07B8
        495 => x"97B20025", -- byte addr 0x07BC
        496 => x"11414398", -- byte addr 0x07C0
        497 => x"00259793", -- byte addr 0x07C4
        498 => x"97B2C606", -- byte addr 0x07C8
        499 => x"80A1A623", -- byte addr 0x07CC
        500 => x"D663C398", -- byte addr 0x07D0
        501 => x"C5AD02A5", -- byte addr 0x07D4
        502 => x"FFF58793", -- byte addr 0x07D8
        503 => x"078A8785", -- byte addr 0x07DC
        504 => x"4210963E", -- byte addr 0x07E0
        505 => x"4254435C", -- byte addr 0x07E4
        506 => x"04D7E963", -- byte addr 0x07E8
        507 => x"04F68363", -- byte addr 0x07EC
        508 => x"40B23D8D", -- byte addr 0x07F0
        509 => x"01414505", -- byte addr 0x07F4
        510 => x"45018082", -- byte addr 0x07F8
        511 => x"ED998082", -- byte addr 0x07FC
        512 => x"4218CD19", -- byte addr 0x0800
        513 => x"200007B7", -- byte addr 0x0804
        514 => x"435055FD", -- byte addr 0x0808
        515 => x"C78C4314", -- byte addr 0x080C
        516 => x"C794C7D0", -- byte addr 0x0810
        517 => x"450540B2", -- byte addr 0x0814
        518 => x"80820141", -- byte addr 0x0818
        519 => x"07B7FD65", -- byte addr 0x081C
        520 => x"577D2000", -- byte addr 0x0820
        521 => x"40B2C798", -- byte addr 0x0824
        522 => x"C798C7D8", -- byte addr 0x0828
        523 => x"01414505", -- byte addr 0x082C
        524 => x"42148082", -- byte addr 0x0830
        525 => x"FDE3431C", -- byte addr 0x0834
        526 => x"852EFAD7", -- byte addr 0x0838
        527 => x"BFD93DDD", -- byte addr 0x083C
        528 => x"8613350D", -- byte addr 0x0840
        529 => x"BF758301", -- byte addr 0x0844
        530 => x"C4521101", -- byte addr 0x0848
        531 => x"80C1A783", -- byte addr 0x084C
        532 => x"5F63CE06", -- byte addr 0x0850
        533 => x"CA2604F0", -- byte addr 0x0854
        534 => x"C64EC84A", -- byte addr 0x0858
        535 => x"200009B7", -- byte addr 0x085C
        536 => x"20000937", -- byte addr 0x0860
        537 => x"C256CC22", -- byte addr 0x0864
        538 => x"83018493", -- byte addr 0x0868
        539 => x"093109A1", -- byte addr 0x086C
        540 => x"A6834080", -- byte addr 0x0870
        541 => x"27830009", -- byte addr 0x0874
        542 => x"40580009", -- byte addr 0x0878
        543 => x"06E7E263", -- byte addr 0x087C
        544 => x"04F70D63", -- byte addr 0x0880
        545 => x"C391481C", -- byte addr 0x0884
        546 => x"441C9782", -- byte addr 0x0888
        547 => x"E7334454", -- byte addr 0x088C
        548 => x"E31D00D7", -- byte addr 0x0890
        549 => x"01444783", -- byte addr 0x0894
        550 => x"8522C399", -- byte addr 0x0898
        551 => x"AA833DDD", -- byte addr 0x089C
        552 => x"47E380C1", -- byte addr 0x08A0
        553 => x"4462FD50", -- byte addr 0x08A4
        554 => x"494244D2", -- byte addr 0x08A8
        555 => x"4A9249B2", -- byte addr 0x08AC
        556 => x"4A2240F2", -- byte addr 0x08B0
        557 => x"80826105", -- byte addr 0x08B4
        558 => x"40504018", -- byte addr 0x08B8
        559 => x"80C1AA83", -- byte addr 0x08BC
        560 => x"B73397BA", -- byte addr 0x08C0
        561 => x"96B200E7", -- byte addr 0x08C4
        562 => x"C01C9736", -- byte addr 0x08C8
        563 => x"8556C058", -- byte addr 0x08CC
        564 => x"3B414581", -- byte addr 0x08D0
        565 => x"F9504EE3", -- byte addr 0x08D4
        566 => x"401CB7F9", -- byte addr 0x08D8
        567 => x"FAF6F4E3", -- byte addr 0x08DC
        568 => x"07B74098", -- byte addr 0x08E0
        569 => x"55FD2000", -- byte addr 0x08E4
        570 => x"43144350", -- byte addr 0x08E8
        571 => x"C7D0C78C", -- byte addr 0x08EC
        572 => x"BF55C794", -- byte addr 0x08F0
        573 => x"80C1A883", -- byte addr 0x08F4
        574 => x"04000793", -- byte addr 0x08F8
        575 => x"0AF88E63", -- byte addr 0x08FC
        576 => x"83018813", -- byte addr 0x0900
        577 => x"11484783", -- byte addr 0x0904
        578 => x"CE061101", -- byte addr 0x0908
        579 => x"0793CBC5", -- byte addr 0x090C
        580 => x"470112C8", -- byte addr 0x0910
        581 => x"0007C683", -- byte addr 0x0914
        582 => x"070507E1", -- byte addr 0x0918
        583 => x"1793FEE5", -- byte addr 0x091C
        584 => x"83330017", -- byte addr 0x0920
        585 => x"030E00E7", -- byte addr 0x0924
        586 => x"10080693", -- byte addr 0x0928
        587 => x"0E37969A", -- byte addr 0x092C
        588 => x"97BA2000", -- byte addr 0x0930
        589 => x"008E2703", -- byte addr 0x0934
        590 => x"2503832A", -- byte addr 0x0938
        591 => x"02B300CE", -- byte addr 0x093C
        592 => x"B7330067", -- byte addr 0x0940
        593 => x"952E00E2", -- byte addr 0x0944
        594 => x"97C2078E", -- byte addr 0x0948
        595 => x"4385972A", -- byte addr 0x094C
        596 => x"00289F13", -- byte addr 0x0950
        597 => x"10E7A223", -- byte addr 0x0954
        598 => x"87339F42", -- byte addr 0x0958
        599 => x"85460078", -- byte addr 0x095C
        600 => x"1057A023", -- byte addr 0x0960
        601 => x"1067A423", -- byte addr 0x0964
        602 => x"10B7A623", -- byte addr 0x0968
        603 => x"10C7A823", -- byte addr 0x096C
        604 => x"10778A23", -- byte addr 0x0970
        605 => x"00DF2023", -- byte addr 0x0974
        606 => x"A623C636", -- byte addr 0x0978
        607 => x"3B5580E1", -- byte addr 0x097C
        608 => x"8301A783", -- byte addr 0x0980
        609 => x"0EB746B2", -- byte addr 0x0984
        610 => x"0E372000", -- byte addr 0x0988
        611 => x"0EB12000", -- byte addr 0x098C
        612 => x"86630E21", -- byte addr 0x0990
        613 => x"40F200D7", -- byte addr 0x0994
        614 => x"61058536", -- byte addr 0x0998
        615 => x"42D88082", -- byte addr 0x099C
        616 => x"567D429C", -- byte addr 0x09A0
        617 => x"00CE2023", -- byte addr 0x09A4
        618 => x"A02340F2", -- byte addr 0x09A8
        619 => x"202300EE", -- byte addr 0x09AC
        620 => x"853600FE", -- byte addr 0x09B0
        621 => x"80826105", -- byte addr 0x09B4
        622 => x"80824501", -- byte addr 0x09B8
        623 => x"10080693", -- byte addr 0x09BC
        624 => x"B7B54701", -- byte addr 0x09C0
        625 => x"80C1A883", -- byte addr 0x09C4
        626 => x"04000793", -- byte addr 0x09C8
        627 => x"0CF88063", -- byte addr 0x09CC
        628 => x"83018813", -- byte addr 0x09D0
        629 => x"11484783", -- byte addr 0x09D4
        630 => x"CE061101", -- byte addr 0x09D8
        631 => x"0793CBD5", -- byte addr 0x09DC
        632 => x"470112C8", -- byte addr 0x09E0
        633 => x"0007C683", -- byte addr 0x09E4
        634 => x"070507E1", -- byte addr 0x09E8
        635 => x"1793FEE5", -- byte addr 0x09EC
        636 => x"86B30017", -- byte addr 0x09F0
        637 => x"068E00E7", -- byte addr 0x09F4
        638 => x"10080313", -- byte addr 0x09F8
        639 => x"0E379336", -- byte addr 0x09FC
        640 => x"26832000", -- byte addr 0x0A00
        641 => x"2F83008E", -- byte addr 0x0A04
        642 => x"97BA00CE", -- byte addr 0x0A08
        643 => x"00A68733", -- byte addr 0x0A0C
        644 => x"85334285", -- byte addr 0x0A10
        645 => x"36B300BF", -- byte addr 0x0A14
        646 => x"959300D7", -- byte addr 0x0A18
        647 => x"078E0028", -- byte addr 0x0A1C
        648 => x"96AA97C2", -- byte addr 0x0A20
        649 => x"8FB395C2", -- byte addr 0x0A24
        650 => x"85460058", -- byte addr 0x0A28
        651 => x"10D7A223", -- byte addr 0x0A2C
        652 => x"10E7A023", -- byte addr 0x0A30
        653 => x"1007A423", -- byte addr 0x0A34
        654 => x"1007A623", -- byte addr 0x0A38
        655 => x"10C7A823", -- byte addr 0x0A3C
        656 => x"10578A23", -- byte addr 0x0A40
        657 => x"0065A023", -- byte addr 0x0A44
        658 => x"A623C61A", -- byte addr 0x0A48
        659 => x"31D581F1", -- byte addr 0x0A4C
        660 => x"8301A783", -- byte addr 0x0A50
        661 => x"0EB74332", -- byte addr 0x0A54
        662 => x"0E372000", -- byte addr 0x0A58
        663 => x"0EB12000", -- byte addr 0x0A5C
        664 => x"86630E21", -- byte addr 0x0A60
        665 => x"40F20067", -- byte addr 0x0A64
        666 => x"61054505", -- byte addr 0x0A68
        667 => x"27038082", -- byte addr 0x0A6C
        668 => x"27830043", -- byte addr 0x0A70
        669 => x"56FD0003", -- byte addr 0x0A74
        670 => x"00DE2023", -- byte addr 0x0A78
        671 => x"A02340F2", -- byte addr 0x0A7C
        672 => x"202300EE", -- byte addr 0x0A80
        673 => x"450500FE", -- byte addr 0x0A84
        674 => x"80826105", -- byte addr 0x0A88
        675 => x"80824501", -- byte addr 0x0A8C
        676 => x"10080313", -- byte addr 0x0A90
        677 => x"B7A54701", -- byte addr 0x0A94
        678 => x"4783C509", -- byte addr 0x0A98
        679 => x"C3910145", -- byte addr 0x0A9C
        680 => x"4501B9CD", -- byte addr 0x0AA0
        681 => x"C5098082", -- byte addr 0x0AA4
        682 => x"01454783", -- byte addr 0x0AA8
        683 => x"B1D5C391", -- byte addr 0x0AAC
        684 => x"80824501", -- byte addr 0x0AB0
        685 => x"200027B7", -- byte addr 0x0AB4
        686 => x"439C07D1", -- byte addr 0x0AB8
        687 => x"D6067179", -- byte addr 0x0ABC
        688 => x"0017F713", -- byte addr 0x0AC0
        689 => x"F713E705", -- byte addr 0x0AC4
        690 => x"C7110027", -- byte addr 0x0AC8
        691 => x"20002737", -- byte addr 0x0ACC
        692 => x"8A894B14", -- byte addr 0x0AD0
        693 => x"8BB1E69D", -- byte addr 0x0AD4
        694 => x"27B7C799", -- byte addr 0x0AD8
        695 => x"47D82000", -- byte addr 0x0ADC
        696 => x"00476713", -- byte addr 0x0AE0
        697 => x"50B2C7D8", -- byte addr 0x0AE4
        698 => x"80826145", -- byte addr 0x0AE8
        699 => x"200026B7", -- byte addr 0x0AEC
        700 => x"8513428C", -- byte addr 0x0AF0
        701 => x"F593F301", -- byte addr 0x0AF4
        702 => x"C63E0FF5", -- byte addr 0x0AF8
        703 => x"47B234C1", -- byte addr 0x0AFC
        704 => x"8513B7D9", -- byte addr 0x0B00
        705 => x"05930341", -- byte addr 0x0B04
        706 => x"C63E01F1", -- byte addr 0x0B08
        707 => x"27373CD9", -- byte addr 0x0B0C
        708 => x"47B22000", -- byte addr 0x0B10
        709 => x"C5190741", -- byte addr 0x0B14
        710 => x"01F14683", -- byte addr 0x0B18
        711 => x"20002737", -- byte addr 0x0B1C
        712 => x"BF55C354", -- byte addr 0x0B20
        713 => x"9AF54314", -- byte addr 0x0B24
        714 => x"B775C314", -- byte addr 0x0B28
        715 => x"85131141", -- byte addr 0x0B2C
        716 => x"C606F301", -- byte addr 0x0B30
        717 => x"85133C95", -- byte addr 0x0B34
        718 => x"0513F301", -- byte addr 0x0B38
        719 => x"34AD1045", -- byte addr 0x0B3C
        720 => x"65054605", -- byte addr 0x0B40
        721 => x"051385B2", -- byte addr 0x0B44
        722 => x"4681AB45", -- byte addr 0x0B48
        723 => x"27B7342D", -- byte addr 0x0B4C
        724 => x"4B982000", -- byte addr 0x0B50
        725 => x"671340B2", -- byte addr 0x0B54
        726 => x"CB980017", -- byte addr 0x0B58
        727 => x"80820141", -- byte addr 0x0B5C
        728 => x"200027B7", -- byte addr 0x0B60
        729 => x"87134B94", -- byte addr 0x0B64
        730 => x"4583F301", -- byte addr 0x0B68
        731 => x"46032047", -- byte addr 0x0B6C
        732 => x"F7132057", -- byte addr 0x0B70
        733 => x"CB98FFD6", -- byte addr 0x0B74
        734 => x"02C58863", -- byte addr 0x0B78
        735 => x"C2261141", -- byte addr 0x0B7C
        736 => x"C606C422", -- byte addr 0x0B80
        737 => x"8493842A", -- byte addr 0x0B84
        738 => x"85A20341", -- byte addr 0x0B88
        739 => x"343D8526", -- byte addr 0x0B8C
        740 => x"27B7DD6D", -- byte addr 0x0B90
        741 => x"4B982000", -- byte addr 0x0B94
        742 => x"442240B2", -- byte addr 0x0B98
        743 => x"00276713", -- byte addr 0x0B9C
        744 => x"4492CB98", -- byte addr 0x0BA0
        745 => x"80820141", -- byte addr 0x0BA4
        746 => x"200027B7", -- byte addr 0x0BA8
        747 => x"439C07A1", -- byte addr 0x0BAC
        748 => x"D7E98B91", -- byte addr 0x0BB0
        749 => x"200027B7", -- byte addr 0x0BB4
        750 => x"27B7C3C8", -- byte addr 0x0BB8
        751 => x"4B982000", -- byte addr 0x0BBC
        752 => x"00276713", -- byte addr 0x0BC0
        753 => x"8082CB98", -- byte addr 0x0BC4
        754 => x"CC221101", -- byte addr 0x0BC8
        755 => x"8413CE06", -- byte addr 0x0BCC
        756 => x"0593F301", -- byte addr 0x0BD0
        757 => x"852200F1", -- byte addr 0x0BD4
        758 => x"DD653429", -- byte addr 0x0BD8
        759 => x"446240F2", -- byte addr 0x0BDC
        760 => x"00F14503", -- byte addr 0x0BE0
        761 => x"80826105", -- byte addr 0x0BE4
        762 => x"C4221141", -- byte addr 0x0BE8
        763 => x"842AC606", -- byte addr 0x0BEC
        764 => x"00054503", -- byte addr 0x0BF0
        765 => x"37ADC511", -- byte addr 0x0BF4
        766 => x"00144503", -- byte addr 0x0BF8
        767 => x"FD650405", -- byte addr 0x0BFC
        768 => x"442240B2", -- byte addr 0x0C00
        769 => x"80820141", -- byte addr 0x0C04
        770 => x"00000000", -- byte addr 0x0C08
        771 => x"00000001", -- byte addr 0x0C0C
        772 => x"00000002", -- byte addr 0x0C10
        773 => x"00000003", -- byte addr 0x0C14
        774 => x"00000004", -- byte addr 0x0C18
        775 => x"00000005", -- byte addr 0x0C1C
        776 => x"00000006", -- byte addr 0x0C20
        777 => x"00000007", -- byte addr 0x0C24
        778 => x"FFFFFFFF", -- byte addr 0x0C28
        779 => x"FFFFFFFF", -- byte addr 0x0C2C
        780 => x"FFFFFFFF", -- byte addr 0x0C30
        781 => x"FFFFFFFF", -- byte addr 0x0C34
        782 => x"FFFFFFFF", -- byte addr 0x0C38
        783 => x"FFFFFFFF", -- byte addr 0x0C3C
        784 => x"FFFFFFFF", -- byte addr 0x0C40
        785 => x"FFFFFFFF"  -- byte addr 0x0C44
    );

    --------------------------------------------------------------------------
    -- DUT & Testbench Control Signals
    --------------------------------------------------------------------------
    signal GPIO_0_tri_io    : std_logic_vector(3 downto 0) := (others => 'Z');
    signal IOBUF_scl        : std_logic_vector(0 downto 0) := (others => 'H');
    signal IOBUF_sda        : std_logic_vector(0 downto 0) := (others => 'H');
    signal SPI_0_0_io0_io   : std_logic := 'Z';
    signal SPI_0_0_io1_io   : std_logic := 'Z';
    signal SPI_0_0_sck_io   : std_logic := 'Z';
    signal SPI_0_0_ss_io    : std_logic_vector(0 downto 0) := (others => 'Z');

    signal cpu_rst          : std_logic := '0';
    signal in_clk           : std_logic := '0';
    signal sys_rst          : std_logic := '1';
    signal uart_rx_0        : std_logic := '1';
    signal uart_tx_0        : std_logic;

    -- Disables ACK listener and enables ASCII console monitor once CPU boots
    signal boot_phase_done  : std_logic := '0';

    --------------------------------------------------------------------------
    -- Send one UART byte (1 start bit, 8 data bits LSB-first, 1 stop bit)
    --------------------------------------------------------------------------
    procedure uart_send_byte (
        signal uart_line : out std_logic;
        constant data    : in  std_logic_vector(7 downto 0)
    ) is
    begin
        uart_line <= '0';
        wait for BIT_PERIOD;

        for i in 0 to 7 loop
            uart_line <= data(i);
            wait for BIT_PERIOD;
        end loop;

        uart_line <= '1';
        wait for BIT_PERIOD;
    end procedure;

    --------------------------------------------------------------------------
    -- Receive one UART byte
    --------------------------------------------------------------------------
    procedure uart_receive_byte (
        signal uart_line : in  std_logic;
        variable data    : out std_logic_vector(7 downto 0);
        constant timeout : in  time := 25 * BIT_PERIOD
    ) is
    begin
        if uart_line /= '0' then
            wait until uart_line = '0' for timeout;
        end if;

        assert uart_line = '0'
            report "UART RX timeout waiting for DUT response"
            severity failure;

        -- Sample center of first data bit (+1.5 bit periods from start edge)
        wait for BIT_PERIOD + (BIT_PERIOD / 2);

        for i in 0 to 7 loop
            data(i) := uart_line;
            wait for BIT_PERIOD;
        end loop;

        assert uart_line = '1'
            report "UART framing error: stop bit was not high"
            severity error;

        wait for BIT_PERIOD / 2;
    end procedure;

    --------------------------------------------------------------------------
    -- Send 32-bit Bootloader Packet (CMD_WRITE=0x01, CMD_NPU_WEIGHT=0x03,
    -- or CMD_NPU_SCRATCH=0x04)
    --------------------------------------------------------------------------
    procedure bootloader_write_32 (
        signal uart_line : out std_logic;
        constant cmd     : in  std_logic_vector(7 downto 0);
        constant address : in  std_logic_vector(31 downto 0);
        constant data    : in  std_logic_vector(31 downto 0)
    ) is
        variable checksum : std_logic_vector(7 downto 0);
    begin
        checksum := cmd
                    xor address(31 downto 24)
                    xor address(23 downto 16)
                    xor address(15 downto 8)
                    xor address(7 downto 0)
                    xor data(31 downto 24)
                    xor data(23 downto 16)
                    xor data(15 downto 8)
                    xor data(7 downto 0);

        uart_send_byte(uart_line, SYNC_BYTE);
        uart_send_byte(uart_line, cmd);

        uart_send_byte(uart_line, address(31 downto 24));
        uart_send_byte(uart_line, address(23 downto 16));
        uart_send_byte(uart_line, address(15 downto 8));
        uart_send_byte(uart_line, address(7 downto 0));

        uart_send_byte(uart_line, data(31 downto 24));
        uart_send_byte(uart_line, data(23 downto 16));
        uart_send_byte(uart_line, data(15 downto 8));
        uart_send_byte(uart_line, data(7 downto 0));

        uart_send_byte(uart_line, checksum);
    end procedure;

    --------------------------------------------------------------------------
    -- Send 36-bit NPU Instruction Packet (CMD_NPU_INSTR = 0x02)
    --
    -- Protocol (12 bytes total):
    --   0x55 | 0x02 | addr[31:0] (4B MSB-first) |
    --   0x0 & data[35:32] (1B) | data[31:0] (4B MSB-first) | checksum
    --------------------------------------------------------------------------
    procedure bootloader_write_npu_instr (
        signal uart_line : out std_logic;
        constant address : in  std_logic_vector(31 downto 0);
        constant data    : in  std_logic_vector(35 downto 0)
    ) is
        variable data_hi  : std_logic_vector(7 downto 0);
        variable checksum : std_logic_vector(7 downto 0);
    begin
        data_hi  := "0000" & data(35 downto 32);
        checksum := CMD_NPU_INSTR
                    xor address(31 downto 24)
                    xor address(23 downto 16)
                    xor address(15 downto 8)
                    xor address(7 downto 0)
                    xor data_hi
                    xor data(31 downto 24)
                    xor data(23 downto 16)
                    xor data(15 downto 8)
                    xor data(7 downto 0);

        uart_send_byte(uart_line, SYNC_BYTE);
        uart_send_byte(uart_line, CMD_NPU_INSTR);

        uart_send_byte(uart_line, address(31 downto 24));
        uart_send_byte(uart_line, address(23 downto 16));
        uart_send_byte(uart_line, address(15 downto 8));
        uart_send_byte(uart_line, address(7 downto 0));

        uart_send_byte(uart_line, data_hi);
        uart_send_byte(uart_line, data(31 downto 24));
        uart_send_byte(uart_line, data(23 downto 16));
        uart_send_byte(uart_line, data(15 downto 8));
        uart_send_byte(uart_line, data(7 downto 0));

        uart_send_byte(uart_line, checksum);
    end procedure;

    --------------------------------------------------------------------------
    -- Wait for bootloader ACK (0x06)
    --------------------------------------------------------------------------
    procedure expect_ack (
        signal uart_line     : in std_logic;
        constant packet_name : in string
    ) is
        variable response : std_logic_vector(7 downto 0);
    begin
        uart_receive_byte(uart_line, response);

        if response = UART_ACK then
            null; -- Quiet on success to avoid flooding log across 800+ packets
        elsif response = UART_NACK then
            assert false
                report packet_name & ": NACK (0x15) received from bootloader! " &
                       "(Check boot_mode, npu_ready, and address alignment)"
                severity failure;
        else
            assert false
                report packet_name & ": unexpected UART response (expected 0x06)"
                severity failure;
        end if;
    end procedure;

begin

    --------------------------------------------------------------------------
    -- DUT Instantiation
    --------------------------------------------------------------------------
    dut : design_1_wrapper
        port map (
            GPIO_0_tri_io  => GPIO_0_tri_io,
            IOBUF_scl      => IOBUF_scl,
            IOBUF_sda      => IOBUF_sda,
            SPI_0_0_io0_io => SPI_0_0_io0_io,
            SPI_0_0_io1_io => SPI_0_0_io1_io,
            SPI_0_0_sck_io => SPI_0_0_sck_io,
            SPI_0_0_ss_io  => SPI_0_0_ss_io,
            cpu_rst        => cpu_rst,
            in_clk         => in_clk,
            sys_rst        => sys_rst,
            uart_rx_0      => uart_rx_0,
            uart_tx_0      => uart_tx_0
        );

    --------------------------------------------------------------------------
    -- 100 MHz System Clock
    --------------------------------------------------------------------------
    clk_process : process
    begin
        in_clk <= '0';
        wait for CLK_PERIOD / 2;
        in_clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    --------------------------------------------------------------------------
    -- Main Stimulus Process:
    --   1. Hold CPU in reset (boot_mode = 1)
    --   2. Upload NPU Weights (CMD 0x03)
    --   3. Upload NPU Instructions (CMD 0x02)
    --   4. Upload CPU Firmware (CMD 0x01)
    --   5. Release CPU reset (boot_mode = 0) and monitor UART output
    --------------------------------------------------------------------------
    stimulus : process
        variable byte_addr : std_logic_vector(31 downto 0);
    begin
        report "============================================================" severity note;
        report "MINA INTEGRATED CPU + NPU UART BOOTLOADER & EXECUTION TEST" severity note;
        report "============================================================" severity note;

        uart_rx_0       <= '1';
        cpu_rst         <= '0'; -- Active-low CPU reset (holds bootloader in boot_mode = '1')
        sys_rst         <= '0'; -- Active-low system reset
        boot_phase_done <= '0';

        wait for 20 * CLK_PERIOD;
        sys_rst <= '1';
        report "System reset released; CPU held in reset (boot_mode active)" severity note;

        -- Wait for clk_wiz locked + NPU safe_halted (QUIESCE_CYCLES)
        wait for 5 us;

        ----------------------------------------------------------------------
        -- STEP 1: Upload NPU Weight Matrix (16 words = 64 bytes at 0x00000000)
        ----------------------------------------------------------------------
        report "Uploading 16 NPU Weight words (CMD 0x03)..." severity note;
        for i in 0 to NPU_WEIGHT_WORDS'length - 1 loop
            byte_addr := std_logic_vector(to_unsigned(i * 4, 32));
            bootloader_write_32(
                uart_rx_0,
                CMD_NPU_WEIGHT,
                byte_addr,
                NPU_WEIGHT_WORDS(i)
            );
            expect_ack(uart_tx_0, "NPU_WEIGHT(" & integer'image(i) & ")");
        end loop;
        report "NPU Weights upload complete (16/16 ACKed)." severity note;

        ----------------------------------------------------------------------
        -- STEP 2: Upload NPU Instructions (8-byte stride at 0x00000000)
        ----------------------------------------------------------------------
        report "Uploading " & integer'image(NUM_NPU_INSTRS) &
               " NPU Instructions (CMD 0x02, stride = 8 bytes)..." severity note;
        for i in 0 to NUM_NPU_INSTRS - 1 loop
            byte_addr := std_logic_vector(to_unsigned(i * 8, 32));
            bootloader_write_npu_instr(
                uart_rx_0,
                byte_addr,
                NPU_INSTR_WORDS(i)
            );
            expect_ack(uart_tx_0, "NPU_INSTR(" & integer'image(i) & ")");
        end loop;
        report "NPU Instructions upload complete (" &
               integer'image(NUM_NPU_INSTRS) & "/" &
               integer'image(NUM_NPU_INSTRS) & " ACKed)." severity note;

        ----------------------------------------------------------------------
        -- STEP 3: Upload CPU Firmware Image (786 words = 3,144 bytes)
        ----------------------------------------------------------------------
        report "Uploading " & integer'image(NUM_FW_WORDS) &
               " CPU Firmware words (CMD 0x01)..." severity note;
        for i in 0 to NUM_FW_WORDS - 1 loop
            byte_addr := std_logic_vector(to_unsigned(i * 4, 32));
            bootloader_write_32(
                uart_rx_0,
                CMD_WRITE,
                byte_addr,
                FIRMWARE_WORDS(i)
            );
            expect_ack(uart_tx_0, "CPU_FW(" & integer'image(i) & ")");

            if ((i + 1) mod 128 = 0) or (i = NUM_FW_WORDS - 1) then
                report "  CPU Firmware progress: " &
                       integer'image(i + 1) & " / " &
                       integer'image(NUM_FW_WORDS) & " words ACKed"
                    severity note;
            end if;
        end loop;

        report "============================================================" severity note;
        report "ALL NPU + CPU BOOTLOADER PACKETS ACKNOWLEDGED!" severity note;
        report "Releasing CPU reset (cpu_rst <= '1') to start firmware..." severity note;
        report "============================================================" severity note;

        wait for 10 us;
        boot_phase_done <= '1';
        cpu_rst         <= '1';

        -- Wait long enough for the CPU + NPU to execute and print at least
        -- two 8x8 matrices over UART (~272 chars * 86.8 us/char = ~24 ms/matrix)
        wait for 60 ms;

        report "============================================================" severity note;
        report "SIMULATION WINDOW COMPLETE" severity note;
        report "============================================================" severity note;
        assert false report "TEST COMPLETE" severity failure;
        wait;
    end process;

    --------------------------------------------------------------------------
    -- UART Console Monitor Process:
    -- Captures and prints every ASCII line emitted by the CPU after boot
    --------------------------------------------------------------------------
    uart_console_monitor : process
        variable rx_byte  : std_logic_vector(7 downto 0);
        variable char_val : integer;
        variable out_line : line;
        variable row_cnt  : natural := 0;
    begin
        wait until boot_phase_done = '1';

        loop
            -- Wait for start bit on uart_tx_0 (no fatal timeout while idle)
            wait until uart_tx_0 = '0';
            wait for BIT_PERIOD + (BIT_PERIOD / 2);

            for b in 0 to 7 loop
                rx_byte(b) := uart_tx_0;
                wait for BIT_PERIOD;
            end loop;

            wait for BIT_PERIOD / 2;

            char_val := to_integer(unsigned(rx_byte));
            if char_val = 10 then -- ''
                row_cnt := row_cnt + 1;
                report "[UART TX Row " & integer'image(row_cnt) & "] " & out_line.all
                    severity note;
                deallocate(out_line);
            elsif char_val = 13 then -- ''
                null;
            elsif char_val >= 32 and char_val <= 126 then
                write(out_line, character'val(char_val));
            end if;
        end loop;
    end process;

end Behavioral;