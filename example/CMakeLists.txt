include(./platformConfig.cmake)
include(./cmake/arduino-stm32-core.cmake)
cmake_minimum_required(VERSION 2.8.5)
Project("cmake core stm32" C CXX ASM)
#
GENERATE_FIRMWARE(blink blink.cpp)
