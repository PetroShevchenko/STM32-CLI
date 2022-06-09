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

BSP_PATH				:= $(CUBE_PATH)/Drivers/BSP

INCLUDE_PATH			+= $(BSP_PATH)/$(BOARD_NAME)
VPATH					+= $(BSP_PATH)/$(BOARD_NAME)

INCLUDE_PATH 			+= $(BSP_PATH)
VPATH 					+= $(BSP_PATH)

SRC_BSP 				:= stm32mp15xx_disco.c
#SRC_BSP 				+= stm32mp15xx_disco_bus.c
#SRC_BSP 				+= stm32mp15xx_disco_errno.c
#SRC_BSP 				+= stm32mp15xx_disco_stpmic1.c
