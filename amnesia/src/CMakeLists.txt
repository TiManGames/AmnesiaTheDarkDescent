cmake_minimum_required (VERSION 3.19)
project(Lux)

message(STATUS "Configuring a ${CMAKE_SYSTEM} ${CMAKE_BUILD_TYPE} build")

option(FULL_WARNINGS "Enable full compiler warnings" OFF)
option(USERDIR_RESOURCES "Allow using local userdirectory resources" ON)
option(FBX_SUPPORT "Add FBX support during compilation" OFF)

set(CMAKE_BUILD_TYPE "Release")
# Release: high optimization level, no debug info, code or asserts.
# Debug: No optimization, asserts enabled, debug info included in executable (so you can step through the code with a debugger and have address to source-file:line-number translation).
# RelWithDebInfo: optimized, *with* debug info, but no debug (output) code or asserts.
# MinSizeRel: same as Release but optimizing for size rather than speed.

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/../output)

add_compile_options(
    -std=c++20
    -fno-strict-aliasing
)

# silence some annoying warnings
add_compile_options(
    -Wno-unused-result  # just annoying
    -Wno-aggressive-loop-optimizations  # shows false positive errors about simple loops being unpredictable
    -Wno-write-strings  # don't convert const string to char* because the boogeyman will get you!
    # TODO fix these:
    -Wno-deprecated-enum-float-conversion
    -Wno-narrowing
    -Wno-int-to-pointer-cast
    -Wno-format-security
    -Wno-delete-incomplete
)

# Required by the libGLEW dependency
add_link_options(
    -no-pie
)

if (FULL_WARNINGS)
    add_compile_options(-Wall -Wextra)
endif ()

if (FBX_SUPPORT)
    add_compile_definitions(FBX_SUPPORT)
    # Ignore retarded shit done by the FBX SDK:
    add_compile_options(
        -Wno-literal-suffix  # missing spaces between stuff
        -Wno-deprecated-enum-enum-conversion  # bitwise operation between different enumeration types
    )
endif()

if(USERDIR_RESOURCES)
    add_definitions(
        -DUSERDIR_RESOURCES
    )
endif()

add_subdirectory(../../HPL2/core build_core)
add_subdirectory(game build_game)
add_subdirectory(launcher build_launcher)

add_custom_target(GameRelease
    DEPENDS Amnesia Launcher
)
