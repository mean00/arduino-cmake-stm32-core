include(arduino-stm32-version)

MESSAGE(STATUS "Defining Macros..")
#
#
#
MACRO(GENERATE_FIRMWARE  Target)
    add_executable(${Target} ${ARGN})
    target_link_libraries(${Target} srcWrapper srcCores srcVariant )
    add_custom_command(TARGET ${Target} POST_BUILD
            COMMAND ${CMAKE_OBJCOPY}
            ARGS -Oihex
            ${Target}.elf
            ${Target}.hex
            COMMENT "Generating HEX image"
            VERBATIM)
    add_custom_command(TARGET ${Target} POST_BUILD
            COMMAND ${CMAKE_OBJCOPY}
            ARGS -Obinary
            ${Target}.elf
            ${Target}.bin
            COMMENT "Generating HEX image"
            VERBATIM)

ENDMACRO()


