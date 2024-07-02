cmake_minimum_required (VERSION 3.19)
project(Lux)

message(STATUS "Configuring a ${CMAKE_SYSTEM} ${CMAKE_BUILD_TYPE} build")

option(FULL_WARNINGS "Enable full compiler warnings" OFF)
option(USERDIR_RESOURCES "Allow using local userdirectory resources" ON)
option(FBX_SUPPORT "Add FBX support during compilation" OFF)

set(CMAKE_BUILD_TYPE "Release")
# Release: High optimization level, no debug info, no debug code, no asserts.
# Debug: No optimization, asserts enabled, debug info included (enables stepping through code with a debugger and source-file:line-number translation).
# RelWithDebInfo: Optimized build with embedded debug information, excluding debug output code and asserts.
# MinSizeRel: Same as Release but optimized for size rather than speed.

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/../output)

if(MINGW)
    # There are compatibility issues in MinGW with newer standards.
    # https://stackoverflow.com/questions/58059048/ambiguous-byte-definition-in-rpcndr-and-cstddef
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    # Specify the static linking options for GCC and C++ runtimes
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libgcc -static-libstdc++")
else()
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

# Silence some annoying warnings that are language-agnostic
add_compile_options(
    # False positive or pedantic warnings
    -Wno-unused-result  # Suppress warnings about unused return values
    -Wno-aggressive-loop-optimizations  # Suppress false positive warnings about loop optimizations
    -Wno-write-strings  # Allow converting const string literals to char* (non-const)

    # TODO fix these:
    -Wno-format-security  # Suppress format security warnings (e.g., printf format vulnerabilities)
    -Wno-int-to-pointer-cast  # Suppress warnings about casting integers to pointers
    -Wno-attributes  # Suppress warnings about ignored attributes in the code
)

# Silence C++ specific warnings
add_compile_options(
    # TODO fix these:
    "$<$<COMPILE_LANGUAGE:CXX>:-Wno-deprecated-enum-float-conversion>"  # Suppress warnings about deprecated enum to float conversions
    "$<$<COMPILE_LANGUAGE:CXX>:-Wno-narrowing>"  # Suppress warnings about narrowing conversions
    "$<$<COMPILE_LANGUAGE:CXX>:-Wno-delete-incomplete>"  # Suppress warnings about deleting incomplete types
)

# Define LINUX if we are on a Linux system
if(UNIX AND NOT APPLE)
    set(LINUX TRUE)
endif()
# This condition ensures that the LINUX variable is set on Unix-like systems excluding macOS.

# Suppress specific warning only on Linux
if(LINUX)
    add_compile_options(
        "$<$<COMPILE_LANGUAGE:CXX>:-Wno-deprecated-enum-enum-conversion>"  # Suppress warnings about deprecated enum to enum conversions
    )
endif()

# Required by AngelScript
add_compile_options(-fno-strict-aliasing)
# Required by the libGLEW dependency
add_link_options(-no-pie)

if(FULL_WARNINGS)
    add_compile_options(-Wall -Wextra)
endif()

if (FBX_SUPPORT)
    add_compile_definitions(FBX_SUPPORT)
    # FBX SDK warnings
    add_compile_options(
        -Wno-literal-suffix  # Suppresses warnings for missing spaces between literal suffixes and the literals themselves
        -Wno-deprecated-enum-enum-conversion  # Suppresses warnings for bitwise operations between different enumeration types
    )
endif()

if(USERDIR_RESOURCES)
    add_compile_definitions(USERDIR_RESOURCES)
endif()

add_subdirectory(../../HPL2/core build_core)
add_subdirectory(game build_game)
add_subdirectory(launcher build_launcher)

add_custom_target(GameRelease DEPENDS Amnesia Launcher)

