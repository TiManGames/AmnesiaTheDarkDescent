cmake_minimum_required (VERSION 3.19)
project (OALWrapper)

OPTION(USE_SDL2 "Use SDL2 instead of SDL1.2" OFF)
OPTION(FORCE32 "Force a 32 bit build on 64bit linux" OFF)

set(OALWrapper_VERSION_MAJOR 1)
set(OALWrapper_VERSION_MINOR 0)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMakeScripts)


# Set lib subdir from the dependencies (PRIVATE_LIB_DIR) folder
if(APPLE)
    if(IS_APPLE_64)
        SET(PRIVATE_LIB_SUFFIX "lib/macosx64")
    else()
        SET(PRIVATE_LIB_SUFFIX "lib/macosx")
    endif()
elseif(LINUX)
    if(CMAKE_SIZEOF_VOID_P MATCHES "8" AND NOT(FORCE32))
        SET(PRIVATE_LIB_SUFFIX "lib/linux/lib64")
    else()
        SET(PRIVATE_LIB_SUFFIX "lib/linux/lib")
    endif()
elseif(WIN32)
    SET(PRIVATE_LIB_SUFFIX "lib/win32")
else()
    message(FATAL_ERROR "unhandled platform")
endif()

# Validate dependency dir
if(PRIVATE_LIB_DIR)
    # Set header folder for dependencies
    if(NOT EXISTS ${PRIVATE_LIB_DIR}/include)
        message(FATAL_ERROR "folder named include not found in lib dir ${PRIVATE_LIB_DIR}")
    endif()
    set(EXTRA_INCLUDE_DIR ${PRIVATE_LIB_DIR}/include)
    # Check full dependency dir path
    if(NOT EXISTS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX})
        message(FATAL_ERROR "folder ${PRIVATE_LIB_SUFFIX} not found in lib dir ${PRIVATE_LIB_DIR}")
    endif()
else()
    message(WARNING "PRIVATE_LIB_DIR is empty. Build will probably fail to find dependencies in the system.")
endif()


if(PRIVATE_LIB_DIR AND LINUX)
    find_library(OGG_LIBRARY ogg PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBIS_LIBRARY vorbis PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBISFILE_LIBRARY vorbisfile PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(OPENAL_LIBRARY openal PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)

    if(USE_SDL2)
        find_library(SDL_LIBRARY SDL2 PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
        find_path(SDL_INCLUDE_DIR SDL.h
            PATHS ${PRIVATE_LIB_DIR}/include
            PATH_SUFFIXES SDL2
            NO_DEFAULT_PATH
        )
    else()
        find_library(SDL_LIBRARY SDL PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
        find_path(SDL_INCLUDE_DIR SDL.h
            PATHS ${PRIVATE_LIB_DIR}/include
            PATH_SUFFIXES SDL
            NO_DEFAULT_PATH
        )
    endif()
elseif(PRIVATE_LIB_DIR AND WIN32)
    find_library(OGG_LIBRARY ogg PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBIS_LIBRARY vorbis PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(VORBISFILE_LIBRARY vorbisfile PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
    find_library(OPENAL_LIBRARY OpenAL32 PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)

    if(USE_SDL2)
        find_library(SDL_LIBRARY SDL2 PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
        find_path(SDL_INCLUDE_DIR SDL.h
            PATHS ${PRIVATE_LIB_DIR}/include
            PATH_SUFFIXES SDL2
            NO_DEFAULT_PATH
        )
    else()
        find_library(SDL_LIBRARY SDL PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} PATH_SUFFIXES lib NO_DEFAULT_PATH)
        find_path(SDL_INCLUDE_DIR SDL.h
            PATHS ${PRIVATE_LIB_DIR}/include
            PATH_SUFFIXES SDL
            NO_DEFAULT_PATH
        )
    endif()
elseif(PRIVATE_LIB_DIR AND APPLE)
    if(IOS)
        set(PRIVATE_LIB_SUFFIX ios)
        find_library(OGG_LIBRARY ogg PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
        find_library(VORBIS_LIBRARY vorbis PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
        find_library(VORBISFILE_LIBRARY vorbisfile PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
    else()
        if(NOT PRIVATE_LIB_SUFFIX)
            set(PRIVATE_LIB_SUFFIX macosx)
        endif()
        find_library(OGG_LIBRARY Ogg PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
        find_library(VORBIS_LIBRARY Vorbis PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
        if (VORBIS_LIBRARY AND NOT VORBIS_LIBRARY MATCHES /.framework$/)
            find_library(VORBISFILE_LIBRARY vorbisfile PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
        endif()
    endif()

    if(USE_SDL2)
        find_library(SDL_LIBRARY SDL2 PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
    else()
        find_library(SDL_LIBRARY SDL PATHS ${PRIVATE_LIB_DIR}/${PRIVATE_LIB_SUFFIX} NO_DEFAULT_PATH)
    endif()

    find_path(SDL_INCLUDE_DIR SDL.h
        PATHS ${PRIVATE_LIB_DIR}/include
        PATH_SUFFIXES SDL2
        NO_DEFAULT_PATH
    )

    find_package(OpenAL)
else()
    find_package(OGG)
    find_package(Vorbis)
    if(NOT(APPLE))
        find_package(VorbisFile)
    endif()
    find_package(OpenAL)
    if(USE_SDL2)
        find_package(SDL2)
    else()
        find_package(SDL)
    endif()

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
    PRIVATE ${SDL_INCLUDE_DIR}
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

if(USE_SDL2)
    add_definitions(-DUSE_SDL2)
endif()

add_library(OALWrapper STATIC
    ${all_sources}
    ${all_includes}
)
target_link_libraries(OALWrapper
    ${VORBISFILE_LIBRARY}
    ${VORBIS_LIBRARY}
    ${OGG_LIBRARY}
    ${OPENAL_LIBRARY}
    ${SDL_LIBRARY}
)
target_include_directories(OALWrapper
    ${OALWRAPPER_INCLUDE_PATHS}
)
message(STATUS "Lib includes: ${OGG_INCLUDE_DIR} ${VORBIS_INCLUDE_DIR} ${VORBISFILE_INCLUDE_DIR} ${OPENAL_INCLUDE_DIR}")
message(STATUS "Includes: ${OALWRAPPER_INCLUDE_PATHS}")

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
