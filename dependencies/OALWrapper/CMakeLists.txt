cmake_minimum_required (VERSION 3.19)
project (OALWrapper)

set(OALWrapper_VERSION_MAJOR 1)
set(OALWrapper_VERSION_MINOR 0)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMakeScripts)

# Validate dependency dir
if(DEPENDENCIES_ROOT)
    # Set header folder for dependencies
    if(NOT EXISTS ${DEPENDENCIES_ROOT}/include)
        message(FATAL_ERROR "folder named include not found in lib dir ${DEPENDENCIES_ROOT}")
    endif()
    set(EXTRA_INCLUDE_DIR ${DEPENDENCIES_ROOT}/include)
else()
    message(WARNING "DEPENDENCIES_ROOT not set. Build will probably fail to find dependencies in the system.")
endif()

# Check platform lib dir
if(NOT EXISTS ${DEPENDENCIES_PLATFORM_LIBS})
    message(FATAL_ERROR "Platform lib dir (DEPENDENCIES_PLATFORM_LIBS) not found")
endif()


if(LINUX)
    find_library(OGG_LIBRARY ogg PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBIS_LIBRARY vorbis PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBISFILE_LIBRARY vorbisfile PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(OPENAL_LIBRARY openal PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)

    find_library(SDL2_LIBRARY SDL2 PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_path(SDL2_INCLUDE_DIR SDL.h
        PATHS ${DEPENDENCIES_ROOT}/include
        PATH_SUFFIXES SDL2
        NO_DEFAULT_PATH
    )
elseif(WIN32)
    find_library(OGG_LIBRARY ogg PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBIS_LIBRARY vorbis PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBISFILE_LIBRARY vorbisfile PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(OPENAL_LIBRARY OpenAL32 PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)

    find_library(SDL2_LIBRARY SDL2 PATHS ${DEPENDENCIES_PLATFORM_LIBS} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_path(SDL2_INCLUDE_DIR SDL.h
        PATHS ${DEPENDENCIES_ROOT}/include
        PATH_SUFFIXES SDL2
        NO_DEFAULT_PATH
    )
else()
    find_package(OGG)
    find_package(Vorbis)
    find_package(VorbisFile)
    find_package(OpenAL)
    find_package(SDL2)

    list(APPEND OALWRAPPER_INCLUDE_PATHS
        PRIVATE ${OGG_INCLUDE_DIR}
        PRIVATE ${VORBIS_INCLUDE_DIR}
        PUBLIC ${OPENAL_INCLUDE_DIR}
    )
    if(VORBISFILE_INCLUDE_DIR)
        list(APPEND OALWRAPPER_INCLUDE_PATHS
            PRIVATE ${VORBISFILE_INCLUDE_DIR}
        )
    endif()
endif()

list(APPEND OALWRAPPER_INCLUDE_PATHS
    PUBLIC include
    PRIVATE ${SDL2_INCLUDE_DIR}
)

if(EXTRA_INCLUDE_DIR)
    list(APPEND OALWRAPPER_INCLUDE_PATHS
        PRIVATE ${EXTRA_INCLUDE_DIR}
    )
endif()

set(all_sources
    sources/OAL_AudioData.cpp
    sources/OAL_Buffer.cpp
    sources/OAL_Device.cpp
    sources/OAL_Effect.cpp
    sources/OAL_Effect_Reverb.cpp
    sources/OAL_EffectSlot.cpp
    sources/OAL_EFX.cpp
    sources/OAL_EFXManager.cpp
    sources/OAL_Filter.cpp
    sources/OAL_Helper.cpp
    sources/OAL_Init.cpp
    sources/OAL_Loaders.cpp
    sources/OAL_LoggerObject.cpp
    sources/OAL_OggSample.cpp
    sources/OAL_OggStream.cpp
    sources/OAL_WAVSample.cpp
    sources/OAL_CustomStream.cpp
    sources/OAL_Playback.cpp
    sources/OAL_Sample.cpp
    sources/OAL_Source.cpp
    sources/OAL_SourceManager.cpp
    sources/OAL_Stream.cpp
    sources/OAL_Types.cpp
)

set(all_includes
    include//OALWrapper/OAL_AudioData.h
    include//OALWrapper/OAL_Buffer.h
    include//OALWrapper/OAL_CustomStream.h
    include//OALWrapper/OAL_Device.h
    include//OALWrapper/OAL_Effect.h
    include//OALWrapper/OAL_Effect_Reverb.h
    include//OALWrapper/OAL_EffectSlot.h
    include//OALWrapper/OAL_EFX.h
    include//OALWrapper/OAL_EFXManager.h
    include//OALWrapper/OAL_Filter.h
    include//OALWrapper/OAL_Funcs.h
    include//OALWrapper/OAL_Helper.h
    include//OALWrapper/OAL_Init.h
    include//OALWrapper/OAL_Loaders.h
    include//OALWrapper/OAL_LoggerObject.h
    include//OALWrapper/OAL_LowLevelObject.h
    include//OALWrapper/OAL_OggSample.h
    include//OALWrapper/OAL_OggStream.h
    include//OALWrapper/OAL_Playback.h
    include//OALWrapper/OAL_Sample.h
    include//OALWrapper/OAL_Source.h
    include//OALWrapper/OAL_SourceManager.h
    include//OALWrapper/OAL_Stream.h
    include//OALWrapper/OAL_Types.h
    include//OALWrapper/OAL_WAVSample.h
)

add_definitions(-DUSE_SDL2)

add_library(OALWrapper STATIC
    ${all_sources}
    ${all_includes}
)
target_link_libraries(OALWrapper
    ${VORBISFILE_LIBRARY}
    ${VORBIS_LIBRARY}
    ${OGG_LIBRARY}
    ${OPENAL_LIBRARY}
    ${SDL2_LIBRARY}
)
target_include_directories(OALWrapper
    ${OALWRAPPER_INCLUDE_PATHS}
)
message(STATUS
    "OAL libs:
    ${OGG_LIBRARY}
    ${VORBIS_LIBRARY}
    ${VORBISFILE_LIBRARY}
    ${OPENAL_LIBRARY}"
)
message(STATUS
    "OAL lib includes:
    ${OGG_INCLUDE_DIR}
    ${VORBIS_INCLUDE_DIR}
    ${VORBISFILE_INCLUDE_DIR}
    ${OPENAL_INCLUDE_DIR}"
)
message(STATUS "OAL all includes: ${OALWRAPPER_INCLUDE_PATHS}")

# TODO these could probably be done using CTest instead of add_executable
add_executable(SimpleTest EXCLUDE_FROM_ALL tests/Simple/main.cpp)
add_executable(PlaySound EXCLUDE_FROM_ALL tests/PlaySound/main.cpp)
add_executable(Playlist EXCLUDE_FROM_ALL tests/Playlist/main.cpp)
add_executable(CustomStream EXCLUDE_FROM_ALL tests/CustomStream/main.cpp)

target_link_libraries(SimpleTest OALWrapper)
target_link_libraries(PlaySound OALWrapper)
target_link_libraries(Playlist OALWrapper)
target_link_libraries(CustomStream OALWrapper)

# Exports
set(OALWRAPPER_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include PARENT_SCOPE)
