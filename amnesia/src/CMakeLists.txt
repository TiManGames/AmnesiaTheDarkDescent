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

if(MINGW)
    # There is some stuff that breaks in mingw in newer standards
    # https://stackoverflow.com/questions/58059048/ambiguous-byte-definition-in-rpcndr-and-cstddef
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
else()
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

# silence some annoying warnings that are language-agnostic
add_compile_options(
    # False Positive or Pedantic Warnings
    -Wno-unused-result  # suppress warnings about unused return values
    -Wno-aggressive-loop-optimizations  # suppress false positive warnings about loop optimizations
    -Wno-write-strings  # allow converting const string literals to char* (non-const)
    # TODO fix these:
    -Wno-format-security  # suppress format security warnings (e.g., printf format vulnerabilities)
    -Wno-int-to-pointer-cast  # suppress warnings about casting integers to pointers
    -Wno-attributes  # suppress warnings about ignored attributes in the code
)

# silence C++ specific warnings
add_compile_options(
    # TODO fix these:
    "$<$<COMPILE_LANGUAGE:CXX>:-Wno-deprecated-enum-float-conversion>"  # suppress warnings about deprecated enum to float conversions
    "$<$<COMPILE_LANGUAGE:CXX>:-Wno-narrowing>"  # suppress warnings about narrowing conversions
    "$<$<COMPILE_LANGUAGE:CXX>:-Wno-delete-incomplete>"  # suppress warnings about deleting incomplete types
)

# required by AngelScript
add_compile_options(-fno-strict-aliasing)
# Required by the libGLEW dependency
add_link_options(-no-pie)

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
