cmake_minimum_required (VERSION 3.19)
project(Launcher)

FindPrebuiltLibrary(FLTK_LIBRARY fltk)

if (WIN32)
    FindPrebuiltLibrary(FLTK_IMAGES_LIBRARY fltkimages)
    FindPrebuiltLibrary(JPEG_LIBRARY fltkjpeg)
else()
    FindPrebuiltLibrary(FLTK_IMAGES_LIBRARY fltk_images)
    FindPrebuiltLibrary(JPEG_LIBRARY jpeg)
endif()

add_executable(Launcher
    launcher.cpp
    Main.cpp
    QualityChooser.cpp
    LauncherHelper.cpp)
target_link_libraries(Launcher HPL2 ${FLTK_IMAGES_LIBRARY} ${FLTK_LIBRARY} X11 Xext Xft fontconfig ${JPEG_LIBRARY})

