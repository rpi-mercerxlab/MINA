# ==========================================
# 1. User Application Configuration
# ==========================================
# Default application source file(s). 
# You can override this via command line or wrapper script: make APP_SRCS="my_app.c"
APP_SRCS ?= main.c
APP_HEADERS ?= ./includes/

# Name of the final executable
TARGET ?= firmware

# ==========================================
# 2. SDK / Hardware Support Configuration
# ==========================================
# The relative path to your directory containing drivers, startup.S, and linker script
SDK_DIR = ./

# Linker script located inside the SDK directory
LINKER_SCRIPT = $(SDK_DIR)/link.ld

# Base include directories
INCLUDES = -I$(SDK_DIR)/drivers/ -I$(APP_HEADERS)

# Add user include directory if provided by the bash wrapper script
ifneq ($(USER_INC_DIR),)
    INCLUDES += -I$(USER_INC_DIR)
endif

# ==========================================
# 3. Toolchain and Architecture
# ==========================================
CROSS_COMPILE ?= riscv64-unknown-elf-
CC      = $(CROSS_COMPILE)gcc
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy

MARCH = rv32imfc_zicsr
MABI  = ilp32f

# ==========================================
# 4. Source Files & Automatic Discovery
# ==========================================
# Auto-discover all drivers and startup code in the SDK directory
SDK_C_SRCS = $(wildcard $(SDK_DIR)/*.c) \
             $(wildcard $(SDK_DIR)/drivers/src/*.c)
SDK_ASM_SRCS = $(wildcard $(SDK_DIR)/*.S) $(wildcard $(SDK_DIR)/*.s)

# Add user source directory if provided by the bash wrapper script
ifneq ($(USER_SRC_DIR),)
    USER_ADDITIONAL_SRCS = $(wildcard $(USER_SRC_DIR)/*.c)
endif

# Combine SDK sources with the user's application code
C_SRCS   = $(APP_SRCS) $(USER_ADDITIONAL_SRCS) $(SDK_C_SRCS)
ASM_SRCS = $(SDK_ASM_SRCS)

# Map source files to output object files in the build directory
BUILD_DIR ?= build
OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(C_SRCS)) \
       $(patsubst %.S, $(BUILD_DIR)/%.o, $(filter %.S, $(ASM_SRCS))) \
       $(patsubst %.s, $(BUILD_DIR)/%.o, $(filter %.s, $(ASM_SRCS)))

# ==========================================
# 5. Compiler & Linker Flags
# ==========================================
CFLAGS = -march=$(MARCH) -mabi=$(MABI) -O2 -Wall -g $(INCLUDES)

LDFLAGS = -march=$(MARCH) -mabi=$(MABI) -T $(LINKER_SCRIPT) -nostartfiles -Wl,-Map=$(BUILD_DIR)/$(TARGET).map

# ==========================================
# 6. Build Targets
# ==========================================
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).bin $(BUILD_DIR)/$(TARGET).asm

# Link all objects into the final ELF
$(BUILD_DIR)/$(TARGET).elf: $(OBJS)
	@echo "Linking $@"
	$(CC) $(LDFLAGS) -o $@ $^

# Compile C files
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@echo "Compiling $<"
	$(CC) $(CFLAGS) -c $< -o $@

# Compile Assembly files (.S and .s)
$(BUILD_DIR)/%.o: %.S
	@mkdir -p $(dir $@)
	@echo "Assembling $<"
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(dir $@)
	@echo "Assembling $<"
	$(CC) $(CFLAGS) -c $< -o $@

# Create raw binary
$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	$(OBJCOPY) -O binary $< $@

# Create disassembly dump
$(BUILD_DIR)/$(TARGET).asm: $(BUILD_DIR)/$(TARGET).elf
	$(OBJDUMP) -S -d $< > $@

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
