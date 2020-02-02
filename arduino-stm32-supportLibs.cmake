#
# Generate STM32Core
#
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
add_library(CoreSrcWrapper STATIC ${ALL_WRAPPER})

#
# ARDUINO CORES
#
include(srcCores_files)
SET(STM32_CORES_SRC_PATH ${STM32_CORE_PATH}/hardware/stm32/${STM32_CORE_VERSION}/cores/arduino/)
FOREACH(wrapper ${LIBCORE_SRC_y})
    SET(CORES_WRAPPER  ${CORES_WRAPPER} ${STM32_CORES_SRC_PATH}/${wrapper})
ENDFOREACH()
add_library(CoreSrcCores STATIC ${CORES_WRAPPER})

