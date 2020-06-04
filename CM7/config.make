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

VERSION					:= Debug
#VERSION				:= Release

PROJECT_NAME			:= BSP_example
BOARD_NAME 				:= STM32H747I-DISCO

MCU_CORE 				:= CORE_CM7
MCU_SERIES				:= STM32H7xx
MCU_DEVICE 				:= STM32H747xx

CUBE_PATH				:= $(HOME)/STM32CubeH7

TOOL_PATH				:= $(HOME)/gcc-arm-none-eabi-9-2019-q4-major

PROJECT_PATH			:= $(CUBE_PATH)/Projects/$(BOARD_NAME)/Examples/BSP
