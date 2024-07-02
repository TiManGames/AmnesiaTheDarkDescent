cmake_minimum_required (VERSION 3.19)
project(Launcher)

FindPrebuiltLibrary(FLTK_LIBRARY fltk)

if(MINGW)
    FindPrebuiltLibrary(FLTK_LIBRARY libfltk)
    FindPrebuiltLibrary(FLTK_IMAGES_LIBRARY libfltk_images)
    FindPrebuiltLibrary(JPEG_LIBRARY libfltk_jpeg)

    # Specify the static linking options for GCC and C++ runtimes
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libgcc -static-libstdc++")

    # This does not propagate from BoilerPlate
    add_compile_definitions(WIN32)
elseif(WIN32)
    FindPrebuiltLibrary(FLTK_IMAGES_LIBRARY fltkimages)
    FindPrebuiltLibrary(JPEG_LIBRARY fltkjpeg)
else()
    FindPrebuiltLibrary(FLTK_IMAGES_LIBRARY fltk_images)
    FindPrebuiltLibrary(JPEG_LIBRARY jpeg)
endif()

set(launcher_sources
    launcher.cpp
    Main.cpp
    QualityChooser.cpp
    LauncherHelper.cpp)

if(MINGW)
    # Include the Windows resource file for MinGW builds
    set(WINDOWS_RESOURCE_FILE "Launcher.rc")
    list(APPEND launcher_sources ${WINDOWS_RESOURCE_FILE})
endif()

add_executable(LauncherCE ${launcher_sources})

target_link_libraries(LauncherCE HPL2 ${FLTK_IMAGES_LIBRARY} ${FLTK_LIBRARY} ${JPEG_LIBRARY})

if(MINGW)
    target_link_libraries(LauncherCE "${CMAKE_CURRENT_SOURCE_DIR}/glut32.lib" comctl32)
elseif(LINUX)
    target_link_libraries(LauncherCE X11 Xext Xft fontconfig)
endif()
