## Find a prebuilt library
## Must set a cache/global variable of DEPENDENCIES_PLATFORM_LIBS so this function knows where to find the libraries.
## The expected structure is to have the libraries/frameworks in the directory pointed to by that variable.
## For multi-arch Linux, putting libraries in two subdirectories, lib and lib64, will allow CMake to find the right ones.
function(FindPrebuiltLibrary result_var libname)
    if(NOT DEPENDENCIES_PLATFORM_LIBS)
        message(FATAL_ERROR "Must set DEPENDENCIES_PLATFORM_LIBS before using this function")
    endif()

    # Check prebuilt directory first
    find_library(${result_var}
            NAMES ${libname}
            PATHS ${DEPENDENCIES_PLATFORM_LIBS}/lib ${DEPENDENCIES_PLATFORM_LIBS}
            NO_DEFAULT_PATH)
    # Check system dir
    find_library(${result_var}
            NAMES ${libname})
    if(NOT ${result_var})
        message(FATAL_ERROR "Could not find library ${libname} in prebuilt folder ${DEPENDENCIES_PLATFORM_LIBS}")
    endif()
endfunction()
