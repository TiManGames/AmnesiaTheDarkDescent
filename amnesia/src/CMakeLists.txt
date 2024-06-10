cmake_minimum_required (VERSION 3.19)
project(Lux)

set(CMAKE_BUILD_TYPE "Release")
# Release: high optimization level, no debug info, code or asserts.
# Debug: No optimization, asserts enabled, debug info included in executable (so you can step through the code with a debugger and have address to source-file:line-number translation).
# RelWithDebInfo: optimized, *with* debug info, but no debug (output) code or asserts.
# MinSizeRel: same as Release but optimizing for size rather than speed.

MESSAGE(STATUS "Starting a ${CMAKE_SYSTEM} ${CMAKE_BUILD_TYPE} build")

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/../output)

OPTION(USERDIR_RESOURCES "Allow using local userdirectory resources" ON)

# silence some annoying warnings
add_definitions(
    -Wno-switch
    -Wno-reorder
    -Wno-unused-variable
    -Wno-unused-function
)

add_subdirectory(../../HPL2/core core2)

if(USERDIR_RESOURCES)
    add_definitions(
        -DUSERDIR_RESOURCES
    )
endif()

add_subdirectory(game game)
add_subdirectory(launcher launcher)

add_custom_target(GameRelease
    DEPENDS Amnesia Launcher
)

set(CMAKE_CXX_FLAGS "-fpermissive -no-pie")
