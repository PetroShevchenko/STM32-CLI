## STM32 Command line Interface
### Introduction
This repository contains makefiles to build examples for STMicroelectronics' boards.
You should clone appropriate repository to your home directory using one of the following links:
<h4>STM32CubeH7</h4> https://github.com/STMicroelectronics/STM32CubeH7.git
<h4>STM32CubeMP1</h4> https://github.com/STMicroelectronics/STM32CubeMP1.git

~~~
$ cd ~/
$ git clone https://github.com/STMicroelectronics/STM32CubeH7.git
$ git clone https://github.com/STMicroelectronics/STM32CubeMP1.git
~~~
To build the example use the following commands:
~~~
$ cd ~/STM32-CLI
$ ./build.sh <BOARD-NAME> <TARGET>
~~~

BOARD-NAME:
* STM32H747I-DISCO
* STM32MP157A-DK1

TARGET:
* all - build the project and all its dependencies  
* clean - remove compiled application and temporaly object files
* clean-libs - remove compiled libraries and their temporaly object files

To clean binary files use the commands:
~~~
$ ./build.sh <BOARD-NAME> clean
$ ./build.sh <BOARD-NAME> clean-libs
~~~
### Toolchain
This project uses ARM GNU Toolchain which can be downloaded by the link https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
The toolchain should be located at your home directory ~/gcc-arm-none-eabi-9-2020-q2-update.
You can change a toolchain location editing the variable TOOL_PATH in CM7/config.make file.
### License
This library is provided under Apache license version 2.0. LICENSE file contains license terms.
