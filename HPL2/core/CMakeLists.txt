cmake_minimum_required (VERSION 3.19)
project(HPL2)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(BoilerPlate)

# Set up dependencies dirs (CACHE = global scope)
set(DEPENDENCIES_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../../dependencies/precompiled CACHE PATH "Dir which holds precompiled dependencies - libs and headers")
set(DEPENDENCIES_PLATFORM_LIBS ${DEPENDENCIES_ROOT}/lib/${PLATFORM_PREFIX} CACHE PATH "Dir which holds prebuilt libraries for target system")

include(UtilityFunctions)

add_subdirectory(../../dependencies/OALWrapper build_oalwrapper)

# We use SDL2 by default in CMake now, but in the code 1.2 is also supported and we need to instruct it to use 2
add_definitions(-DUSE_SDL2)
add_definitions(-DUSE_OALWRAPPER)

set(HPL2_INCLUDES
    PUBLIC include
    #Important that this is before dependencies so the correct OpenAL headers are used
    PRIVATE ${OALWRAPPER_INCLUDE_DIR}
    PRIVATE ../../dependencies/AngelScript/include
    PUBLIC ${DEPENDENCIES_ROOT}/include
)

IF(LINUX)
    add_library(binreloc STATIC ../../dependencies/binreloc/binreloc.c)
    set_target_properties(binreloc PROPERTIES COMPILE_DEFINITIONS "ENABLE_BINRELOC")

    list(APPEND HPL2_INCLUDES
        ../../dependencies/binreloc/
    )
ENDIF()


# common shared source
file(GLOB common_sources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    sources/ai/*
    sources/engine/*
    sources/generate/*
    sources/graphics/*
    sources/gui/*
    sources/haptic/*
    sources/input/*
    sources/math/*
    sources/physics/*
    sources/resources/*
    sources/scene/*
    sources/sound/*
	sources/system/*
	sources/*.*

    include/ai/*
    include/engine/*
    include/generate/*
    include/graphics/*
    include/gui/*
    include/haptic/*
    include/input/*
    include/math/*
    include/physics/*
    include/resources/*
    include/scene/*
    include/sound/*
    include/system/*
    include/*.*
)
list(REMOVE_DUPLICATES common_sources)

#setup various IMPL sources
file(GLOB impl_sources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    include/impl/tinyXML/*
    include/impl/*.*

    # tinyXML
    sources/impl/tinyXml/*
    sources/impl/XmlDocumentTiny.cpp
    # scripting
    sources/impl/SqScript.cpp
    sources/impl/scriptarray.cpp
    sources/impl/scripthelper.cpp
    sources/impl/scriptstring.cpp
    sources/impl/scriptstring_utils.cpp
    # Image loading
    sources/impl/BitmapLoader*
    # theora video
    sources/impl/VideoStreamTheora.cpp
    # Newton
    sources/impl/*Newton.cpp
    # GL
    sources/impl/FrameBufferGL.cpp
    sources/impl/GLSL*
    sources/impl/OcclusionQueryOGL.cpp
    sources/impl/VertexBufferOGL_Array.cpp
    sources/impl/VertexBufferOGL_VBO.cpp
    sources/impl/VertexBufferOpenGL.cpp
    # SDL
    sources/impl/GamepadSDL.cpp
    sources/impl/GamepadSDL2.cpp
    sources/impl/KeyboardSDL.cpp
    sources/impl/MouseSDL.cpp
    sources/impl/MutexSDL.cpp
    sources/impl/ThreadSDL.cpp
    sources/impl/TimerSDL.cpp
    sources/impl/LowLevelGraphicsSDL.cpp
    sources/impl/LowLevelInputSDL.cpp
    sources/impl/LowLevelResourcesSDL.cpp
    sources/impl/LowLevelSystemSDL.cpp
    sources/impl/SDLEngineSetup.cpp
    sources/impl/SDLFontData.cpp
    sources/impl/SDLTexture.cpp
    # OpenAL
    sources/impl/LowLevelSoundOpenAL.cpp
    sources/impl/OpenAL*
    # mesh loader
    sources/impl/MeshLoaderCollada.cpp
    sources/impl/MeshLoaderColladaHelpers.cpp
    sources/impl/MeshLoaderColladaLoader.cpp
    sources/impl/MeshLoaderMSH.cpp
)

IF(LINUX)
    LIST(APPEND impl_sources
        sources/impl/PlatformUnix.cpp
        sources/impl/PlatformSDL.cpp
    )
ELSEIF(WIN32)
    LIST(APPEND impl_sources
        sources/impl/MutexWin32.cpp
        sources/impl/ThreadWin32.cpp
        sources/impl/PlatformWin32.cpp
    )
ENDIF()

if(FBX_SUPPORT)
    list(APPEND impl_sources
    sources/impl/MeshLoaderFBX.cpp
    )
endif()

# setup source groups
source_group("AI" REGULAR_EXPRESSION "\\/ai\\/.+")
source_group("Engine" REGULAR_EXPRESSION "\\/engine\\/.+")
source_group("Generate" REGULAR_EXPRESSION "\\/generate\\/.+")
source_group("Graphics" REGULAR_EXPRESSION "\\/graphics\\/.+")
source_group("GUI" REGULAR_EXPRESSION "\\/gui\\/.+")
source_group("Input" REGULAR_EXPRESSION "\\/input\\/.+")
source_group("Math" REGULAR_EXPRESSION "\\/math\\/.+")
source_group("Physics" REGULAR_EXPRESSION "\\/physics\\/.+")
source_group("Resources" REGULAR_EXPRESSION "\\/resources\\/.+")
source_group("Scene" REGULAR_EXPRESSION "\\/scene\\/.+")
source_group("Sound" REGULAR_EXPRESSION "\\/sound\\/.+")
source_group("System" REGULAR_EXPRESSION "\\/system\\/.+")

source_group("Implementation Specific" REGULAR_EXPRESSION "\\/impl\\/.+")
source_group("TinyXML" REGULAR_EXPRESSION "\\/impl\\/tiny.+")
source_group("SDL Specific" REGULAR_EXPRESSION "\\/impl\\/.*SDL.+")
source_group("OpenGL Specific" REGULAR_EXPRESSION "\\/impl\\/.*GL.+")
source_group("HaptX Specific" REGULAR_EXPRESSION "\\/impl\\/.+HaptX.+")
source_group("Newton Specific" REGULAR_EXPRESSION "\\/impl\\/.+Newton.+")
source_group("Mesh Loaders" REGULAR_EXPRESSION "\\/impl\\/Mesh.+")
source_group("OpenAL Specific" REGULAR_EXPRESSION "\\/impl\\/.*OpenAL.+")
source_group("Win32" REGULAR_EXPRESSION "\\/impl\\/.+Win32.+")
source_group("Platform" REGULAR_EXPRESSION "\\/impl\\/Platform.+")

# setup HPL2 compile target

add_library(HPL2 STATIC
    ${common_sources}
    ${impl_sources}
)

target_include_directories(HPL2
    ${HPL2_INCLUDES}
)

# setup libs

if(WIN32)
    FindPrebuiltLibrary(NEWTON_LIBRARY newton)
    FindPrebuiltLibrary(FBX_LIBRARY fbxsdk-2012.2-md)
    FindPrebuiltLibrary(GLEW_LIBRARY glew32)
    FindPrebuiltLibrary(DEVIL_LIBRARY DevIL)

    add_subdirectory(../../dependencies/AngelScript build_angelscript)
    target_link_libraries(HPL2 angelscript)
else()
    FindPrebuiltLibrary(NEWTON_LIBRARY Newton)
    FindPrebuiltLibrary(FBX_LIBRARY fbxsdk-2012.2-static)
    FindPrebuiltLibrary(GLEW_LIBRARY GLEW)
    FindPrebuiltLibrary(DEVIL_LIBRARY IL)

    FindPrebuiltLibrary(ANGELSCRIPT_LIBRARY angelscript)
    target_link_libraries(HPL2 ${ANGELSCRIPT_LIBRARY})
endif()

FindPrebuiltLibrary(THEORA_LIBRARY theora)
FindPrebuiltLibrary(DEVIL_LIBRARY IL)

set(OpenGL_GL_PREFERENCE LEGACY)
find_package(OpenGL)

if(LINUX)
    set(PLATFORM_LIBS
        binreloc
        pthread
        dl
    )
endif()

target_link_libraries(HPL2
    OALWrapper # also pulls in ogg,vorbis,SDL
    ${NEWTON_LIBRARY}
    ${OPENGL_gl_LIBRARY}
    ${OPENGL_glu_LIBRARY}
    ${GLEW_LIBRARY}
    ${THEORA_LIBRARY}
    ${DEVIL_LIBRARY}
    ${PLATFORM_LIBS}
)

if(FBX_SUPPORT)
    target_link_libraries(HPL2 ${FBX_LIBRARY})
endif()

if(WIN32)
    # FindPrebuiltLibrary(ZLIB zlib)
    add_subdirectory(../../dependencies/zlib build_zlib)
    target_link_libraries(HPL2 zlib)
    find_file(ZCONF_DIR zconf.h PATHS ${CMAKE_CURRENT_BINARY_DIR}/build_zlib REQUIRED NO_DEFAULT_PATH)
    message(STATUS "zconfdir ${ZCONF_DIR}")
    target_include_directories(HPL2
        PUBLIC ../../dependencies/zlib
        ${ZCONF_DIR}
    )
else()
    find_library(ZLIB z REQUIRED)
    target_link_libraries(HPL2 ${ZLIB})
endif()

message(STATUS
    "Core libs:
    ${ZLIB}
    ${NEWTON_LIBRARY}
    ${ANGELSCRIPT_LIBRARY}
    ${OPENGL_gl_LIBRARY}
    ${OPENGL_glu_LIBRARY}
    ${GLEW_LIBRARY}
    ${THEORA_LIBRARY}
    ${DEVIL_LIBRARY}
    ${FBX_LIBRARY}
    ${PLATFORM_LIBS}"
)

add_subdirectory(../tools build_tools)

