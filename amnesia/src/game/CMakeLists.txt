cmake_minimum_required(VERSION 3.19)
project(Amnesia)

file(GLOB all_sources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
        *.cpp
        *.h
        )
file(GLOB serial_source RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
        LuxCopyProtection.cpp
        LuxKeyEntry.cpp
        ../serial_gen/SerialGenAlgo.cpp
        )
list(REMOVE_ITEM all_sources ${serial_source})

set(compile_defs "")
set(demo_compile_defs "LUX_DEMO_VERSION")

option(USE_GAMEPAD "Enable gamepad support" ON)
if (USE_GAMEPAD)
    list(APPEND compile_defs USE_GAMEPAD)
    list(APPEND demo_compile_defs USE_GAMEPAD)
endif ()

option(AMNESIA_WITH_SERIAL "Enable Serial Key Checking" OFF)
if (AMNESIA_WITH_SERIAL)
    list(APPEND compile_defs COPY_PROTECTION_ENABLED)
    set(full_sources ${all_sources} ${serial_source})
else ()
    set(full_sources ${all_sources})
endif ()

if(LINUX)
    add_compile_definitions(LINUX)
elseif(WIN32)
    # This does not propagate from BoilerPlate
    add_compile_definitions(WIN32)
    # Include the resource file for Windows builds
    set(WINDOWS_RESOURCE_FILE "Lux.rc")
    list(APPEND full_sources ${WINDOWS_RESOURCE_FILE})
endif()

add_executable(AmnesiaCE ${full_sources})
target_link_libraries(AmnesiaCE HPL2)
set_target_properties(AmnesiaCE PROPERTIES COMPILE_DEFINITIONS "${compile_defs}")

add_executable(AmnesiaDemo EXCLUDE_FROM_ALL ${all_sources})
target_link_libraries(AmnesiaDemo HPL2)
set_target_properties(AmnesiaDemo PROPERTIES COMPILE_DEFINITIONS "${demo_compile_defs}")

