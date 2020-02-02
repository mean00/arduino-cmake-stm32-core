This is a very simple cmake based build system on top of the  Arduino STM32 CORE libraries and tools.

Put this repository as cmake subfolder of your project


Sample CmakeLists.txt for blink.cpp, change the path according to your setup:
-----------------------------------------------------------------------------
SET(STM32_CORE_TOOLCHAIN_PATH /home/fx/.arduino15/packages/STM32/tools/xpack-arm-none-eabi-gcc/9.2.1-1.1/bin/ CACHE PATH "" FORCE)

SET(STM32_CORE_PATH /home/fx/.arduino15/packages/STM32/ CACHE PATH "" FORCE)

SET(STM32_CORE_TARGET "BLUEPILL_F103C8")

include(./cmake/arduino-stm32-core.cmake)

cmake_minimum_required(VERSION 2.8.5)

Project("cmake core stm32" C CXX ASM)

GENERATE_FIRMWARE(blink blink.cpp)


Dont forget to include Arduino.h in your files, it is not done automatically
Similarily, you have to explictely include and generate the library you use and link to them
Little price to pay to have a full build system and not a toy like the arduino IDE.

Example usage
-------------

mkdir build && cd build && cmake .. && make

You'll end up with foo.elf, foo.bin and foo.hex
