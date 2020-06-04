## STM32 Command line Interface

### Introduction
This repository contains makefiles to build BSP example for STM32H747I-DISCO board.
You should clone STM32CubeH7 repository by the link https://github.com/STMicroelectronics/STM32CubeH7.git to your home directory.

**$ cd ~/**

**$ git clone https://github.com/STMicroelectronics/STM32CubeH7.git**

To build the example use following commands:

**$ cd ~/STM32-CLI**

**$ make all**

To clean binary files use the command:

**$ make clean**

### Toolchain
This project uses ARM GNU Toolchain which can be downloaded by the link https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
The toolchain should be located at your home directory ~/gcc-arm-none-eabi-9-2020-q2-update.
You can change a toolchain location editing the variable TOOL_PATH in CM7/config.make file.

### License
This library is provided under Apache license version 2.0. LICENSE file contains license terms.
