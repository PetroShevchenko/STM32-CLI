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

BSP_PATH				:= $(CUBE_PATH)/Drivers/BSP

INCLUDE_PATH			+= $(BSP_PATH)/$(BOARD_NAME)
VPATH					+= $(BSP_PATH)/$(BOARD_NAME)

INCLUDE_PATH 			+= $(BSP_PATH)/Components/Common
INCLUDE_PATH 			+= $(BSP_PATH)/Components/ov9655
INCLUDE_PATH			+= $(BSP_PATH)/Components/otm8009a
INCLUDE_PATH			+= $(BSP_PATH)/Components/mt25tl01g
INCLUDE_PATH			+= $(BSP_PATH)/Components/ft6x06
INCLUDE_PATH			+= $(BSP_PATH)/Components/is42s32800j
INCLUDE_PATH			+= $(BSP_PATH)/Components/wm8994
INCLUDE_PATH 			+= $(CUBE_PATH)/Projects/$(BOARD_NAME)/Demonstrations/STemWin/Modules/audio_player/Addons/PDM/Inc
INCLUDE_PATH 			+= $(CUBE_PATH)/Utilities/Basic_GUI

VPATH 					+= $(BSP_PATH)/Components/ov9655
VPATH 					+= $(BSP_PATH)/Components/otm8009a
VPATH 					+= $(BSP_PATH)/Components/mt25tl01g
VPATH 					+= $(BSP_PATH)/Components/ft6x06
VPATH 					+= $(BSP_PATH)/Components/is42s32800j
VPATH 					+= $(BSP_PATH)/Components/wm8994
VPATH 					+= $(CUBE_PATH)/Utilities/Basic_GUI
#VPATH 					+= CM7

SRC_BSP 				:= stm32h747i_discovery_audio.c
SRC_BSP 				+= stm32h747i_discovery_bus.c
SRC_BSP 				+= stm32h747i_discovery.c
SRC_BSP 				+= stm32h747i_discovery_camera.c
SRC_BSP 				+= stm32h747i_discovery_lcd.c
SRC_BSP 				+= stm32h747i_discovery_qspi.c
SRC_BSP 				+= stm32h747i_discovery_sd.c
SRC_BSP 				+= stm32h747i_discovery_sdram.c
SRC_BSP 				+= stm32h747i_discovery_ts.c
SRC_BSP 				+= basic_gui.c
SRC_BSP 				+= ov9655.c
SRC_BSP 				+= ov9655_reg.c
SRC_BSP 				+= otm8009a.c
SRC_BSP 				+= otm8009a_reg.c
SRC_BSP 				+= mt25tl01g.c
SRC_BSP 				+= ft6x06.c
SRC_BSP 				+= ft6x06_reg.c
SRC_BSP 				+= is42s32800j.c
SRC_BSP 				+= wm8994.c
SRC_BSP 				+= wm8994_reg.c
#SRC_BSP					+= PDMfilter_stubs.c 

