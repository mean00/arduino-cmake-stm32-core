MESSAGE(STATUS "Loading spec for Bluepill F103xxx 128kB")
SET(STM32_BOARD_SPEC_DEFS "${STM32_BOARD_DEFS} -DARDUINO_BLUEPILL_F103C8 -DBOARD_NAME=BLUEPILL_F103C8 -DSTM32F103xB" CACHE INTERNAL "")
SET(STM32_BOARD_MAX_RAM 20480)
SET(STM32_BOARD_MAX_FLASH 131072)
SET(STM32_BOARD_FAMILY  "PILL_F103XX" CACHE INTERNAL "")


