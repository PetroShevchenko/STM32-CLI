#!/bin/bash

usage() {
	echo "---------------------------------------------------------------"
	echo "Usage: $0 <board_name> [option]"
	echo "Board name:"
	echo "STM32H747I-DISCO"
	echo "STM32MP157A-DK1"
	echo "Option:"
	echo "all   	 - build the project and all its dependencies"
	echo "clean 	 - remove compiled application and temporaly object files"
	echo "clean-libs - remove compiled libraries and their temporaly object files"
	echo "Example: $0 STM32H747I-DISCO all"
	echo "---------------------------------------------------------------"
}

if [ -z $1 ];then
	usage
	exit 0
elif [ "$1" == "STM32H747I-DISCO" ];then
	mkdir -p build/CM7
	mkdir -p build/CM7/obj

	if [ -z $2 ];then
		make -f makefile.stm32h7 all
	else
		make -f makefile.stm32h7 $2
	fi
elif [ "$1" == "STM32MP157A-DK1" ];then
	mkdir -p build/MP1_CM4
	mkdir -p build/MP1_CM4/obj

	if [ -z $2 ];then
		make -f makefile.stm32mp1 all
	else
		make -f makefile.stm32mp1 $2
	fi
else
	usage
fi