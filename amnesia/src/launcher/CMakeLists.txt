cmake_minimum_required (VERSION 3.19)
project(Launcher)

FindPrebuiltLibrary(FLTK_LIBRARY fltk)

if (WIN32)
    FindPrebuiltLibrary(FLTK_IMAGES_LIBRARY fltkimages)
    FindPrebuiltLibrary(JPEG_LIBRARY fltkjpeg)
    # This does not propagate from BoilerPlate
    add_compile_definitions(WIN32)
else()
    FindPrebuiltLibrary(FLTK_IMAGES_LIBRARY fltk_images)
    FindPrebuiltLibrary(JPEG_LIBRARY jpeg)
endif()

set(launcher_sources
    launcher.cpp
    Main.cpp
    QualityChooser.cpp
    LauncherHelper.cpp)

# Include the resource file for Windows builds
if(WIN32)
    set(WINDOWS_RESOURCE_FILE "Launcher.rc")
    list(APPEND launcher_sources ${WINDOWS_RESOURCE_FILE})
endif()

add_executable(Launcher ${launcher_sources})

target_link_libraries(Launcher HPL2 ${FLTK_IMAGES_LIBRARY} ${FLTK_LIBRARY} ${JPEG_LIBRARY})

if (LINUX)
    target_link_libraries(Launcher X11 Xext Xft fontconfig)
endif()
