#
#
#
include(target_${STM32_CORE_TARGET})

# Override compilation & link command
#
SET(LINK_FLAGS " -mcpu=cortex-m3 -mthumb -Os  --specs=nano.specs   -u _printf_float -u _scanf_float  -Wl,--defsym=LD_FLASH_OFFSET=0 -Wl,--defsym=LD_MAX_SIZE=${STM32_BOARD_MAX_FLASH} -Wl,--defsym=LD_MAX_DATA_SIZE=${STM32_BOARD_MAX_RAM} -Wl,--cref -Wl,--check-sections -Wl,--gc-sections -Wl,--entry=Reset_Handler -Wl,--unresolved-symbols=report-all -Wl,--warn-common " CACHE INTERNAL "" FORCE)
set(LINK_PATH     " -L${STM32_CORE_PATH}/tools/CMSIS/${STM32_CMIS_TARGET}/CMSIS/DSP/Lib/GCC/" CACHE INTERNAL "" FORCE)

set(CMAKE_CXX_LINK_EXECUTABLE     "<CMAKE_C_COMPILER>   ${LINK_FLAGS} -T${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/variants/${STM32_BOARD_FAMILY}/ldscript.ld -Wl,-Map,<TARGET>.map ${LINK_PATH}  -larm_cortexM3l_math  -Wl,--start-group  -o <TARGET>  <OBJECTS> <LINK_LIBRARIES> -lc -Wl,--end-group -lm -lgcc -lstdc++ -g")

#
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

FOREACH(incl cores/arduino/stm32 cores/arduino/stm32/LL cores/arduino/stm32/usb cores/arduino/stm32/usb/hid cores/arduino/stm32/usb/cdc system/Drivers/STM32F1xx_HAL_Driver/Inc system/Drivers/STM32F1xx_HAL_Driver/Src system/STM32F1xx system/Middlewares/ST/STM32_USB_Device_Library/Core/Inc system/Middlewares/ST/STM32_USB_Device_Library/Core/Src system/Drivers/CMSIS/Device/ST/STM32F1xx/Include/ system/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/ cores/arduino variants/${STM32_BOARD_FAMILY} libraries/SrcWrapper/src )
    SET(IFLAGS "${IFLAGS} -I${STM32_EXTENDED_PATH}/${incl}")
ENDFOREACH()
#
#
SET(CMAKE_C_FLAGS "${STM32_CORE_CFLAGS} ${IFLAGS}"     CACHE STRING "")
SET(CMAKE_CXX_FLAGS "${STM32_CORE_CXXFLAGS} ${IFLAGS}" CACHE STRING "")
SET(CMAKE_ASM_FLAGS "${STM32_CORE_CFLAGS} ${IFLAGS}"   CACHE STRING "")

# Toolchain ready!
