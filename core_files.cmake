IF(NOT DEFINED STM32_CORE_DEFINED)
MESSAGE(STATUS "Loading arduino stm32 core...")
SET(STM32_CORE_DEFINED TRUE CACHE BOOL "" FORCE)
SET(STM32_BOARD_DEFS "-DSTM32F1xx -DARDUINO=10810 -DARDUINO_BLUEPILL_F103C6 -DARDUINO_ARCH_STM32 -DBOARD_NAME=\"BLUEPILL_F103C6\" -DSTM32F103x6 -DHAL_UART_MODULE_ENABLED")

SET(STM32_CORE_CFLAGS_COMMON "-mcpu=cortex-m3 -mthumb  -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500 ${STM32_BOARD_DEFS}")
SET(STM32_CORE_CFLAGS "${STM32_CORE_CFLAGS_COMMON}")
SET(STM32_CORE_CXXFLAGS "${STM32_CORE_CFLAGS_COMMON} -fno-rtti -fno-exceptions -fno-use-cxa-atexit -std=gnu++14 -fno-threadsafe-statics ")

SET(STM32_CORE_VERSION 1.8.0)
SET(STM32_CMIS_TARGET "5.5.1")

SET(STM32_CORE_TOOLCHAIN_PREFIX arm-none-eabi-)

# Lock platformConfig in cache
MESSAGE(STATUS "Toolchain ${STM32_CORE_TOOLCHAIN_PATH}")
MESSAGE(STATUS "Arduino core ${STM32_CORE_PATH}")
SET(STM32_CORE_TARGET "PILL_F103XX")

#
# Setup  Compilers & friends
#
SET(CMAKE_C_COMPILER_ID   "GNU" CACHE INTERNAL "")
SET(CMAKE_CXX_COMPILER_ID   "GNU" CACHE INTERNAL "")

SET(CMAKE_C_COMPILER   ${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}gcc CACHE PATH "" FORCE)
SET(CMAKE_ASM_COMPILER ${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}gcc CACHE PATH "" FORCE)
SET(CMAKE_CXX_COMPILER ${STM32_CORE_TOOLCHAIN_PATH}/${STM32_CORE_TOOLCHAIN_PREFIX}g++ CACHE PATH "" FORCE)
set(CMAKE_CXX_LINK_EXECUTABLE    "<CMAKE_CXX_COMPILER>   <CMAKE_CXX_LINK_FLAGS>  <LINK_FLAGS> -lgcc -mthumb -Wl,--start-group  <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group   -o <TARGET> ")
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
include_directories( ${STM32_CORE_PATH}/tools/CMIS/${STM32_CMIS_TARGET}/Core/Include)
include_directories( ${STM32_CORE_PATH}/tools/CMIS/${STM32_CMIS_TARGET}/DSP/Include)

SET(STM32_EXTENDED_PATH ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION})

FOREACH(incl cores/arduino/stm32 cores/arduino/stm32/LL cores/arduino/stm32/usb cores/arduino/stm32/usb/hid cores/arduino/stm32/usb/cdc system/Drivers/STM32F1xx_HAL_Driver/Inc system/Drivers/STM32F1xx_HAL_Driver/Src system/STM32F1xx system/Middlewares/ST/STM32_USB_Device_Library/Core/Inc system/Middlewares/ST/STM32_USB_Device_Library/Core/Src system/Drivers/CMSIS/Device/ST/STM32F1xx/Include/ system/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/ cores/arduino variants/${STM32_CORE_TARGET} libraries/SrcWrapper/src )
    SET(IFLAGS "${IFLAGS} -I${STM32_EXTENDED_PATH}/${incl}")
ENDFOREACH()
#
#
SET(CMAKE_C_FLAGS ${STM32_CORE_CFLAGS} ${IFLAGS} CACHE STRING "")
SET(CMAKE_CXX_FLAGS ${STM32_CORE_CXXFLAGS} ${IFLAGS} CACHE STRING "")
#
# Generate STM32Core
#
MESSAGE(STATUS "Preparing LibWrapper")
SET(LIBWRAPPER_SRC_z
/home/fx/.arduino15/packages/STM32/hardware/stm32/1.8.0/libraries/SrcWrapper/src/HAL/stm32yyxx_hal_i2s.c)

SET(LIBWRAPPER_SRC_y
src/HAL/stm32yyxx_hal_i2s.c
src/HAL/stm32yyxx_hal_rtc.c
src/HAL/stm32yyxx_hal_gfxmmu.c
src/HAL/stm32yyxx_hal_dcmi_ex.c
src/HAL/stm32yyxx_hal_cordic.c
src/HAL/stm32yyxx_hal_adc.c
src/HAL/stm32yyxx_hal_cortex.c
src/HAL/stm32yyxx_hal_pwr_ex.c
src/HAL/stm32yyxx_hal_gpio.c
src/HAL/stm32yyxx_hal_dma2d.c
src/HAL/stm32yyxx_hal_ltdc_ex.c
src/HAL/stm32yyxx_hal_sd_ex.c
src/HAL/stm32yyxx_hal_dma.c
src/HAL/stm32yyxx_hal_mdma.c
src/HAL/stm32yyxx_hal_dcmi.c
src/HAL/stm32yyxx_hal_flash_ramfunc.c
src/HAL/stm32yyxx_hal_i2s_ex.c
src/HAL/stm32yyxx_hal_nand.c
src/HAL/stm32yyxx_hal_smartcard_ex.c
src/HAL/stm32yyxx_hal_pwr.c
src/HAL/stm32yyxx_hal_spi.c
src/HAL/stm32yyxx_hal_opamp_ex.c
src/HAL/stm32yyxx_hal_cryp.c
src/HAL/stm32yyxx_hal_eth.c
src/HAL/stm32yyxx_hal_i2c_ex.c
src/HAL/stm32yyxx_hal_rng.c
src/HAL/stm32yyxx_hal_fmpi2c_ex.c
src/HAL/stm32yyxx_hal_comp.c
src/HAL/stm32yyxx_hal_timebase_rtc_wakeup_template.c
src/HAL/stm32yyxx_hal_opamp.c
src/HAL/stm32yyxx_hal_timebase_rtc_alarm_template.c
src/HAL/stm32yyxx_hal_adc_ex.c
src/HAL/stm32yyxx_hal_uart.c
src/HAL/stm32yyxx_hal_smartcard.c
src/HAL/stm32yyxx_hal_jpeg.c
src/HAL/stm32yyxx_hal_pcd.c
src/HAL/stm32yyxx_hal_comp_ex.c
src/HAL/stm32yyxx_hal_ramecc.c
src/HAL/stm32yyxx_hal_i2c.c
src/HAL/stm32yyxx_hal_hash_ex.c
src/HAL/stm32yyxx_hal_tim_ex.c
src/HAL/stm32yyxx_hal_sai.c
src/HAL/stm32yyxx_hal_pccard.c
src/HAL/stm32yyxx_hal_ipcc.c
src/HAL/stm32yyxx_hal_pka.c
src/HAL/stm32yyxx_hal_tim.c
src/HAL/stm32yyxx_hal.c
src/HAL/stm32yyxx_hal_spi_ex.c
src/HAL/stm32yyxx_hal_usart_ex.c
src/HAL/stm32yyxx_hal_dfsdm_ex.c
src/HAL/stm32yyxx_hal_nor.c
src/HAL/stm32yyxx_hal_irda.c
src/HAL/stm32yyxx_hal_fmac.c
src/HAL/stm32yyxx_hal_eth_ex.c
src/HAL/stm32yyxx_hal_fmpi2c.c
src/HAL/stm32yyxx_hal_sram.c
src/HAL/stm32yyxx_hal_sai_ex.c
src/HAL/stm32yyxx_hal_sdadc.c
src/HAL/stm32yyxx_hal_timebase_tim_template.c
src/HAL/stm32yyxx_hal_lcd.c
src/HAL/stm32yyxx_hal_rtc_ex.c
src/HAL/stm32yyxx_hal_dac_ex.c
src/HAL/stm32yyxx_hal_hash.c
src/HAL/stm32yyxx_hal_fdcan.c
src/HAL/stm32yyxx_hal_sd.c
src/HAL/stm32yyxx_hal_firewall.c
src/HAL/stm32yyxx_hal_tsc.c
src/HAL/stm32yyxx_hal_flash.c
src/HAL/stm32yyxx_hal_exti.c
src/HAL/stm32yyxx_hal_swpmi.c
src/HAL/stm32yyxx_hal_pcd_ex.c
src/HAL/stm32yyxx_hal_dsi.c
src/HAL/stm32yyxx_hal_ltdc.c
src/HAL/stm32yyxx_hal_usart.c
src/HAL/stm32yyxx_hal_sdram.c
src/HAL/stm32yyxx_hal_gpio_ex.c
src/HAL/stm32yyxx_hal_ospi.c
src/HAL/stm32yyxx_hal_iwdg.c
src/HAL/stm32yyxx_hal_spdifrx.c
src/HAL/stm32yyxx_hal_crc_ex.c
src/HAL/stm32yyxx_hal_cryp_ex.c
src/HAL/stm32yyxx_hal_dac.c
src/HAL/stm32yyxx_hal_rcc_ex.c
src/HAL/stm32yyxx_hal_lptim.c
src/HAL/stm32yyxx_hal_rcc.c
src/HAL/stm32yyxx_hal_flash_ex.c
src/HAL/stm32yyxx_hal_smbus.c
src/HAL/stm32yyxx_hal_mdios.c
src/HAL/stm32yyxx_hal_uart_ex.c
src/HAL/stm32yyxx_hal_mmc.c
src/HAL/stm32yyxx_hal_qspi.c
src/HAL/stm32yyxx_hal_cec.c
src/HAL/stm32yyxx_hal_crc.c
src/HAL/stm32yyxx_hal_can.c
src/HAL/stm32yyxx_hal_msp_template.c
src/HAL/stm32yyxx_hal_mmc_ex.c
src/HAL/stm32yyxx_hal_hrtim.c
src/HAL/stm32yyxx_hal_hsem.c
src/HAL/stm32yyxx_hal_dfsdm.c
src/HAL/stm32yyxx_hal_dma_ex.c
src/HAL/stm32yyxx_hal_wwdg.c
src/HAL/stm32yyxx_hal_hcd.c
src/LL/stm32yyxx_ll_rtc.c
src/LL/stm32yyxx_ll_dac.c
src/LL/stm32yyxx_ll_spi.c
src/LL/stm32yyxx_ll_utils.c
src/LL/stm32yyxx_ll_rcc.c
src/LL/stm32yyxx_ll_usart.c
src/LL/stm32yyxx_ll_lpuart.c
src/LL/stm32yyxx_ll_rng.c
src/LL/stm32yyxx_ll_gpio.c
src/LL/stm32yyxx_ll_exti.c
src/LL/stm32yyxx_ll_dma.c
src/LL/stm32yyxx_ll_crs.c
src/LL/stm32yyxx_ll_sdmmc.c
src/LL/stm32yyxx_ll_opamp.c
src/LL/stm32yyxx_ll_fsmc.c
src/LL/stm32yyxx_ll_pka.c
src/LL/stm32yyxx_ll_crc.c
src/LL/stm32yyxx_ll_swpmi.c
src/LL/stm32yyxx_ll_cordic.c
src/LL/stm32yyxx_ll_bdma.c
src/LL/stm32yyxx_ll_fmc.c
src/LL/stm32yyxx_ll_lptim.c
src/LL/stm32yyxx_ll_i2c.c
src/LL/stm32yyxx_ll_ucpd.c
src/LL/stm32yyxx_ll_hrtim.c
src/LL/stm32yyxx_ll_adc.c
src/LL/stm32yyxx_ll_fmac.c
src/LL/stm32yyxx_ll_tim.c
src/LL/stm32yyxx_ll_pwr.c
src/LL/stm32yyxx_ll_usb.c
src/LL/stm32yyxx_ll_comp.c
src/LL/stm32yyxx_ll_delayblock.c
src/LL/stm32yyxx_ll_dma2d.c
src/LL/stm32yyxx_ll_mdma.c
src/syscalls.c
src/stm32/hw_config.c
src/stm32/uart.c
src/stm32/core_callback.c
src/stm32/timer.c
src/stm32/pinmap.c
src/stm32/PortNames.c
src/stm32/stm32_def.c
src/stm32/lock_resource.c
src/stm32/bootloader.c
src/stm32/analog.cpp
src/stm32/clock.c
src/stm32/interrupt.cpp
src/stm32/system_stm32yyxx.c
src/stm32/rtc.c
src/stm32/stm32_eeprom.c
src/stm32/dwt.c
src/stm32/low_power.c)

FOREACH(wrapper ${LIBWRAPPER_SRC_x})
    LIST(APPEND ALL_WRAPPER  ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/libraries/SrcWrapper/${wrapper})
ENDFOREACH()
MESSAGE(STATUS "Wrapper : ${LIBWRAPPER_SRC_z}")
add_library(CoreSrcWrapper STATIC ${LIBWRAPPER_SRC_z})


ENDIF() 
