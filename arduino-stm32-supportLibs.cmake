#
# Generate STM32Core
#
include(arduino-stm32-version)
include(target_${STM32_CORE_TARGET})

MESSAGE(STATUS "Preparing LibWrapper")
MESSAGE(STATUS "Module path ${CMAKE_MODULE_PATH}")
SET(STM32_CORE_DEFINED TRUE CACHE BOOL "" FORCE)
include(srcWrapper_files)
#
# SRC WRAPPER
#
FOREACH(wrapper ${LIBWRAPPER_SRC_y})
    #MESSAGE(STATUS  "${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/libraries/SrcWrapper/${wrapper}")
    SET(ALL_WRAPPER  ${ALL_WRAPPER} ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/libraries/SrcWrapper/${wrapper})
ENDFOREACH()
#MESSAGE(STATUS "Wrappper src ${ALL_WRAPPER}")
add_library(srcWrapper STATIC ${ALL_WRAPPER})

#
# ARDUINO CORES
#
include(srcCores_files)
SET(STM32_CORES_SRC_PATH ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/cores/arduino/)
FOREACH(wrapper ${LIBCORE_SRC_y})
    SET(CORES_WRAPPER  ${CORES_WRAPPER} ${STM32_CORES_SRC_PATH}/${wrapper})
ENDFOREACH()

add_library(srcCores STATIC ${CORES_WRAPPER})

#
include(srcVariant_PILL_F103XX)
SET(STM32_VARIANT_SRC_PATH ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/variants/${STM32_BOARD_FAMILY}/)
FOREACH(wrapper ${LIBCORE_VARIANT_y})
    SET(VARIANT_WRAPPER  ${VARIANT_WRAPPER} ${STM32_VARIANT_SRC_PATH}/${wrapper})
ENDFOREACH()
add_library(srcVariant STATIC ${VARIANT_WRAPPER})

# Libraries

SET(STM32_LIB_PATH  ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/libraries/)
add_library(srcLibraries STATIC ${STM32_LIB_PATH}/SPI/src/SPI.cpp ${STM32_LIB_PATH}/SPI/src/utility/spi_com.c ${STM32_LIB_PATH}/Wire/src/Wire.cpp)



