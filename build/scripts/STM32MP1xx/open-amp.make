############################################################################
#
# Copyright (C) 2022 Petro Shevchenko <shevchenko.p.i@gmail.com>
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
.PHONY:	all clean

include MP1_CM4/config.make

LIB_NAME				:= open-amp

CMSIS_PATH				:= $(CUBE_PATH)/Drivers/CMSIS

INCLUDE_PATH			+= $(CMSIS_PATH)/Include
INCLUDE_PATH			+= $(CMSIS_PATH)/Device/ST/$(MCU_SERIES)/Include

VPATH					+= $(CMSIS_PATH)/Device/ST/$(MCU_SERIES)/Source/Templates
VPATH					+= $(CMSIS_PATH)/Device/ST/$(MCU_SERIES)/Source/Templates/gcc

HAL_PATH 				:= $(CUBE_PATH)/Drivers/STM32MP1xx_HAL_Driver

VPATH 					+= $(HAL_PATH)/Src
VPATH 					+= $(OPEN_AMP_PATH)/virtual_driver

INCLUDE_PATH			+= $(HAL_PATH)/Inc
INCLUDE_PATH			+= $(PROJECT_PATH)/Inc

OPEN_AMP_PATH			:= $(CUBE_PATH)/Middlewares/Third_Party/OpenAMP

VPATH 					+= $(OPEN_AMP_PATH)/virtual_driver
VPATH 					+= $(OPEN_AMP_PATH)/open-amp/lib/virtio
VPATH 					+= $(OPEN_AMP_PATH)/open-amp/lib/rpmsg
VPATH 					+= $(OPEN_AMP_PATH)/open-amp/lib/remoteproc
VPATH 					+= $(OPEN_AMP_PATH)/libmetal/lib
VPATH 					+= $(OPEN_AMP_PATH)/libmetal/lib/system/generic
VPATH 					+= $(OPEN_AMP_PATH)/libmetal/lib/system/generic/cortexm
VPATH 					+= $(OPEN_AMP_PATH)/libmetal/lib/system/generic/cortexm

INCLUDE_PATH			+= $(OPEN_AMP_PATH)/virtual_driver
INCLUDE_PATH			+= $(OPEN_AMP_PATH)/open-amp/lib/include
INCLUDE_PATH			+= $(OPEN_AMP_PATH)/open-amp/lib/rpmsg
INCLUDE_PATH			+= $(OPEN_AMP_PATH)/libmetal/lib/include


SRC_HAL					:= virt_uart.c
SRC_HAL					+= virtio.c
SRC_HAL					+= virtqueue.c
SRC_HAL					+= rpmsg.c
SRC_HAL					+= rpmsg_virtio.c
SRC_HAL					+= remoteproc_virtio.c
SRC_HAL					+= sys.c
SRC_HAL					+= condition.c
SRC_HAL					+= generic_device.c
SRC_HAL					+= generic_init.c
SRC_HAL					+= generic_io.c
SRC_HAL					+= generic_shmem.c
SRC_HAL					+= time.c
SRC_HAL					+= device.c
SRC_HAL					+= init.c
SRC_HAL					+= io.c
SRC_HAL					+= log.c
SRC_HAL					+= shmem.c

SRC 					:= $(SRC_HAL)

OPTIMIZE_LEVEL			:= 2
DEBUG_LEVEL				:= gdb

DEFINE					:= USE_HAL_DRIVER
DEFINE					+= $(MCU_DEVICE)
DEFINE					+= $(MCU_CORE)
DEFINE 					+= $(BOARD_NAME)
DEFINE 					+= METAL_MAX_DEVICE_REGIONS=2
DEFINE 					+= __LOG_TRACE_IO_
DEFINE 					+= NO_ATOMIC_64_SUPPORT
DEFINE 					+= METAL_INTERNAL
DEFINE 					+= VIRTIO_SLAVE_ONLY

CCFLAGS 				:= -mcpu=cortex-m4
CCFLAGS 				+= -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb
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
ARFLAGS					:= rcs

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

OBJ_PATH				:= build/MP1_CM4/obj

OBJECTS					:= $(addprefix $(OBJ_PATH)/,$(patsubst %.c, %.o,$(filter %.c,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.cpp, %.o,$(filter %.cpp,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.cc, %.o,$(filter %.cc,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.s, %.o,$(filter %.s,$(SRC))))
OBJECTS					+= $(addprefix $(OBJ_PATH)/,$(patsubst %.S, %.o,$(filter %.S,$(SRC))))

IMAGE 					:= $(OBJ_PATH)/$(LIB_NAME)
LIBRARY 				:= build/MP1_CM4/lib$(LIB_NAME).a

all: lib

lib: $(LIBRARY)
	$(RANLIB) $(LIBRARY)

lst:$(IMAGE).lst

$(IMAGE).lst: $(LIBRARY)
	@echo $@
	$(OBJDUMP) -D $< > $@

size: $(LIBRARY)
	@echo $@
	$(SIZE) $(LIBRARY)

$(LIBRARY): $(OBJECTS)
	@echo $@
	$(AR) $(ARFLAGS) $@ $^

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
	rm -f $(LIBRARY) $(IMAGE).lst
