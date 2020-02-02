#
SET(STM32_CORE_VERSION 1.8.0 CACHE INTERNAL "")
SET(STM32_CMIS_TARGET  5.5.1 CACHE INTERNAL "")
#
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY) # dont try to build shared libs
MESSAGE(STATUS "Loading arduino stm32 core...")
SET(STM32_BOARD_DEFS "-DSTM32F1xx -DARDUINO=10810 -DARDUINO_BLUEPILL_F103C6 -DARDUINO_ARCH_STM32 -DBOARD_NAME=BLUEPILL_F103C6 -DSTM32F103x6 -DHAL_UART_MODULE_ENABLED ")
SET(STM32_CORE_CFLAGS_COMMON "-mcpu=cortex-m3 -mthumb  -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 ")
#
SET(STM32_CORE_CFLAGS "${STM32_CORE_CFLAGS_COMMON} ${STM32_BOARD_DEFS}")
SET(STM32_CORE_CXXFLAGS "${STM32_CORE_CFLAGS_COMMON}  ${STM32_BOARD_DEFS} -fno-rtti -fno-exceptions -fno-use-cxa-atexit -std=gnu++14 -fno-threadsafe-statics ")

#
SET(STM32_CORE_TOOLCHAIN_PREFIX arm-none-eabi- CACHE INTERNAL "" )
# Lock platformConfig in cache
SET(STM32_CORE_PATH ${STM32_CORE_PATH}  CACHE PATH "")
MESSAGE(STATUS "Toolchain ${STM32_CORE_TOOLCHAIN_PATH}")
MESSAGE(STATUS "Arduino core ${STM32_CORE_PATH}")
SET(STM32_CORE_TARGET "PILL_F103XX")
SET(STM32_CORE_TOOLCHAIN_PATH ${STM32_CORE_TOOLCHAIN_PATH} CACHE INTERNAL "")
SET(STM32_CORE_TOOLCHAIN_PATH ${STM32_CORE_TOOLCHAIN_PATH} CACHE INTERNAL "")
#
# Setup  Compilers & friends
#
SET(CMAKE_C_COMPILER_ID     "GNU" CACHE INTERNAL "")
SET(CMAKE_CXX_COMPILER_ID   "GNU" CACHE INTERNAL "")

SET(CMAKE_C_COMPILER   "${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}gcc"    CACHE PATH "" FORCE)
SET(CMAKE_ASM_COMPILER "${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}gcc"    CACHE PATH "" FORCE)
SET(CMAKE_CXX_COMPILER "${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}g++"    CACHE PATH "" FORCE)
SET(CMAKE_AR           "${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}ar"     CACHE PATH "" FORCE)
SET(CMAKE_RANLING      "${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}ranlib" CACHE PATH "" FORCE)
#
SET(CMAKE_CXX_LINK_FLAGS "" CACHE INTERNAL "")
#
set(CMAKE_CXX_LINK_EXECUTABLE     "<CMAKE_CXX_COMPILER>   <CMAKE_CXX_LINK_FLAGS>  <LINK_FLAGS> -lgcc -mthumb -Wl,--start-group  <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group   -o <TARGET> ")
set(CMAKE_C_COMPILE_OBJECT        "<CMAKE_C_COMPILER> -c <FLAGS> -o <OBJECT>  -c <SOURCE>")
SET(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> cr <TARGET> <LINK_FLAGS> <OBJECTS> "
                                  "<CMAKE_RANLIB> <TARGET> ")
#
# Skip compiler check
#
#set(CMAKE_C_COMPILER_WORKS 1)
#set(CMAKE_CXX_COMPILER_WORKS 1)

MESSAGE(STATUS "C   compiler ${CMAKE_C_COMPILER}")
MESSAGE(STATUS "C++ compiler ${CMAKE_CXX_COMPILER}")


#
# Setup Stm32 Core include folders
#
SET(STM32_EXTENDED_PATH ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION})
SET(IFLAGS "${IFLAGS} -I${STM32_CORE_PATH}/tools/CMSIS/${STM32_CMIS_TARGET}/CMSIS/Core/Include")
SET(IFLAGS "${IFLAGS} -I${STM32_CORE_PATH}/tools/CMSIS/${STM32_CMIS_TARGET}/CMSIS/DSP/Include")

FOREACH(incl cores/arduino/stm32 cores/arduino/stm32/LL cores/arduino/stm32/usb cores/arduino/stm32/usb/hid cores/arduino/stm32/usb/cdc system/Drivers/STM32F1xx_HAL_Driver/Inc system/Drivers/STM32F1xx_HAL_Driver/Src system/STM32F1xx system/Middlewares/ST/STM32_USB_Device_Library/Core/Inc system/Middlewares/ST/STM32_USB_Device_Library/Core/Src system/Drivers/CMSIS/Device/ST/STM32F1xx/Include/ system/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/ cores/arduino variants/${STM32_CORE_TARGET} libraries/SrcWrapper/src )
    SET(IFLAGS "${IFLAGS} -I${STM32_EXTENDED_PATH}/${incl}")
ENDFOREACH()
#
#
SET(CMAKE_C_FLAGS "${STM32_CORE_CFLAGS} ${IFLAGS}"     CACHE STRING "")
SET(CMAKE_CXX_FLAGS "${STM32_CORE_CXXFLAGS} ${IFLAGS}" CACHE STRING "")
