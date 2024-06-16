## Find a prebuiltlib
## Must set a cache/global var of DEPENDENCIES_PLATFORM_LIBS so this function knows where to find the libraries.
## the epected structure is simply to have the libs/frameworks in the directory pointed to by that variable.
## for multi-arch linux putting libs in two subdirectories of lib and lib64 will allow cmake to find the right ones
function(FindPrebuiltLibrary result_var libname)
    if (NOT DEPENDENCIES_PLATFORM_LIBS)
        message(FATAL_ERROR "Must set DEPENDENCIES_PLATFORM_LIBS before using this function")
    endif ()

    # check prebuilt directory first
    find_library(${result_var}
            NAMES ${libname}
            PATHS ${DEPENDENCIES_PLATFORM_LIBS}/lib ${DEPENDENCIES_PLATFORM_LIBS}
            NO_DEFAULT_PATH)
    # Check system dir
    find_library(${result_var}
            NAMES ${libname})
    if (NOT ${result_var})
        message(FATAL_ERROR "Could not find library ${libname} in prebuilt folder ${DEPENDENCIES_PLATFORM_LIBS}")
    endif ()
endfunction()
