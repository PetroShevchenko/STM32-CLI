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

VERSION					:= Debug
#VERSION				:= Release

PROJECT_NAME			:= OpenAMP_TTY_echo
BOARD_NAME 				:= STM32MP15xx_DISCO

MCU_CORE 				:= CORE_CM4
MCU_SERIES				:= STM32MP1xx
MCU_DEVICE 				:= STM32MP157Cxx

CUBE_PATH				:= $(HOME)/STM32CubeMP1

TOOL_PATH				:= $(HOME)/gcc-arm-none-eabi-10.3-2021.07

PROJECT_PATH			:= $(CUBE_PATH)/Projects/STM32MP157C-DK2/Applications/OpenAMP/OpenAMP_TTY_echo