############################################################################
#
# Copyright (C) 2020 Petro Shevchenko <shevchenko.p.i@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
############################################################################
.PHONY:	all clean clean-libs

include CM7/config.make

LIB						+= bsp
LIB 					+= PDMFilter_CM7_GCC_wc32
LIB						+= hal

LIB_PATH 				+= build/CM7

LD_SCRIPT_PATH 			:= $(PROJECT_PATH)/SW4STM32/STM32H747I_DISCO
LD_SCRIPT 				:= STM32H747XIHx_FLASH_CM7.ld

INCLUDE_PATH 			+= $(PROJECT_PATH)/CM7/Inc
VPATH 					+= $(PROJECT_PATH)/CM7/Src
VPATH 					+= $(PROJECT_PATH)/SW4STM32
VPATH 					+= $(PROJECT_PATH)/Common/Src

CMSIS_PATH				:= $(CUBE_PATH)/Drivers/CMSIS
INCLUDE_PATH			+= $(CMSIS_PATH)/Include
INCLUDE_PATH			+= $(CMSIS_PATH)/Device/ST/$(MCU_SERIES)/Include

HAL_PATH 				:= $(CUBE_PATH)/Drivers/STM32H7xx_HAL_Driver
INCLUDE_PATH			+= $(HAL_PATH)/Inc

BSP_PATH				:= $(CUBE_PATH)/Drivers/BSP
INCLUDE_PATH			+= $(BSP_PATH)/$(BOARD_NAME)
INCLUDE_PATH 			+= $(BSP_PATH)/Components/Common
INCLUDE_PATH 			+= $(CUBE_PATH)/Projects/$(BOARD_NAME)/Demonstrations/STemWin/Modules/audio_player/Addons/PDM/Inc
INCLUDE_PATH 			+= $(CUBE_PATH)/Utilities/Basic_GUI

SRC 					:= startup_stm32h747xx.s
SRC 					+= syscalls.c
SRC 					+= system_stm32h7xx.c
SRC 					+= audio_play.c
SRC 					+= audio_record.c
SRC 					+= camera.c
SRC 					+= joystick.c
SRC 					+= lcd.c
SRC 					+= main.c
SRC 					+= qspi.c
SRC 					+= sd.c
SRC 					+= sdram.c
SRC 					+= stm32h7xx_hal_msp.c
SRC 					+= stm32h7xx_it.c
SRC 					+= touchscreen.c

LIB						+= stdc++

OPTIMIZE_LEVEL			:= 2
DEBUG_LEVEL				:= gdb

DEFINE					:= USE_HAL_DRIVER
DEFINE					+= $(MCU_DEVICE)
DEFINE					+= $(MCU_CORE)
DEFINE 					+= USE_CAMERA_SENSOR_OV9655=1

CCFLAGS 				:= -mcpu=cortex-m7
CCFLAGS 				+= -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb
CCFLAGS 				+= -specs=nano.specs


CROSS_PREFIX			:= arm-none-eabi-

ROOT					:= $(shell pwd)

CC						:= $(CROSS_PREFIX)gcc
AS						:= $(CROSS_PREFIX)g++
LD						:= $(CROSS_PREFIX)g++
CPPC					:= $(CROSS_PREFIX)g++
AR						:= $(CROSS_PREFIX)ar
RANLIB					:= $(CROSS_PREFIX)ranlib
SIZE					:= $(CROSS_PREFIX)size
OBJCOPY					:= $(CROSS_PREFIX)objcopy
OBJDUMP					:= $(CROSS_PREFIX)objdump


INCLUDE_PATH			+= $(TOOL_PATH)/include
LIB_PATH				+= $(TOOL_PATH)/lib

LIBFLAGS				+= $(addprefix -L,$(LIB_PATH)) $(addprefix -l,$(LIB))

CCFLAGS					+= -Wall
CCFLAGS					+= $(addprefix -D,$(DEFINE)) $(addprefix -I,$(INCLUDE_PATH))
CCFLAGS					+= -ffunction-sections -fdata-sections

CONLYFLAGS				+= -std=gnu11

ASFLAGS					+= -Wall
ASFLAGS					+= $(addprefix -D,$(DEFINE)) $(addprefix -I,$(INCLUDE_PATH))

ifeq ($(VERSION),Debug)
CCFLAGS					+= -g$(DEBUG_LEVEL) -O0 -DDEBUG
ASFLAGS					+= -g$(DEBUG_LEVEL) -O0 -DDEBUG
endif

ifeq ($(VERSION),Release)
CCFLAGS					+= -O$(OPTIMIZE_LEVEL)
ASFLAGS					+= -O0
endif

CPPCFLAGS				+= $(CCFLAGS)
CPPCFLAGS				+= -Weffc++ -Wextra -Wpedantic -Wshadow -Wundef -Wno-missing-field-initializers
CPPCFLAGS				+= -std=c++11

BIN_PATH 				:= build/CM7
OBJ_PATH				:= $(BIN_PATH)/obj
IMAGE					:= $(BIN_PATH)/$(PROJECT_NAME)

LDFLAGS					:= -T$(LD_SCRIPT_PATH)/$(LD_SCRIPT)
LDFLAGS					+= -Wl,-Map,$(IMAGE).map,--cref -Wl,--gc-sections
LDFLAGS 				+= -Wl,--start-group -lc -lm -Wl,--end-group

OBJECTS					:= $(addprefix $(OBJ_PATH)/,$(patsubst %.c, %.o,$(filter %.c,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.cpp, %.o,$(filter %.cpp,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.cc, %.o,$(filter %.cc,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.s, %.o,$(filter %.s,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.S, %.o,$(filter %.S,$(SRC))))


all: bsp hal pdmfilter elf bin hex s19 size

bsp:
	make -f build/scripts/$(MCU_SERIES)/bsp.make all -j$(shell nproc || echo 2)

hal:
	make -f build/scripts/$(MCU_SERIES)/hal.make all -j$(shell nproc || echo 2)

pdmfilter:
	cp $(CUBE_PATH)/Projects/$(BOARD_NAME)/Demonstrations/STemWin/Modules/audio_player/Addons/PDM/Lib/libPDMFilter_CM7_GCC_wc32.a $(BIN_PATH)

elf:$(IMAGE).elf

lst:$(IMAGE).lst

bin:$(IMAGE).bin

hex:$(IMAGE).hex

s19:$(IMAGE).s19

size:$(IMAGE).elf
	@echo $@
	$(SIZE) $(IMAGE).elf

$(IMAGE).bin:$(IMAGE).elf
	@echo $@
	$(OBJCOPY) -R .RAM_D3 -O binary $< $@

$(IMAGE).hex:$(IMAGE).elf
	@echo $@
	$(OBJCOPY) -O ihex $< $@

$(IMAGE).s19:$(IMAGE).elf
	@echo $@
	$(OBJCOPY) -O srec $< $@

$(IMAGE).lst:$(IMAGE).elf
	@echo $@
	$(OBJDUMP) -h -S -z $<  > $@

$(IMAGE).elf:$(OBJECTS)
	@echo $@
	$(LD) $(CCFLAGS) $(LDFLAGS) $^ -o $@ $(LIBFLAGS)

$(OBJ_PATH)/%.o:%.c
	@echo $<
	$(CC) $(CCFLAGS) $(CONLYFLAGS) -MD -c $< -o $@

$(OBJ_PATH)/%.o:%.cpp
	$(CPPC) $(CPPCFLAGS) -MD -c $< -o $@

$(OBJ_PATH)/%.o:%.cc
	@echo $<
	$(CPPC) $(CPPCFLAGS) -MD -c $< -o $@

$(OBJ_PATH)/%.o:%.s
	$(AS) $(ASFLAGS) -c $< -o $@

$(OBJ_PATH)/%.o:%.S
	@echo $<
	$(AS) $(ASFLAGS) -c $< -o $@

include $(wildcard $(OBJ_PATH)/*.d)

clean:
	rm -f $(OBJECTS)
	rm -f $(patsubst %.o, %.d,$(OBJECTS))
	rm -f $(IMAGE).bin $(IMAGE).elf $(IMAGE).hex $(IMAGE).s19 $(IMAGE).map $(IMAGE).lst

clean-libs:
	make clean -f build/scripts/$(MCU_SERIES)/hal.make
	make clean -f build/scripts/$(MCU_SERIES)/bsp.make
