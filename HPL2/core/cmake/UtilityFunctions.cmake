### build up utility functions

## Find a prebuiltlib
## Must set a cache/global var of PREBUILT_PLATFORM_ROOT so this function knows where to find the libraries.
## the epected structure is simply to have the libs/frameworks in the directory pointed to by that variable.
## for multi-arch linux putting libs in two subdirectories of lib and lib64 will allow cmake to find the right ones
function(FindPrebuiltLibrary result_var libname)
    if (NOT PREBUILT_PLATFORM_ROOT)
        message(FATAL_ERROR "Must set PREBUILT_PLATFORM_ROOT before using this function")
    endif ()

    # check prebuilt directory first
    find_library(${result_var}
            NAMES ${libname}
            PATHS ${PREBUILT_PLATFORM_ROOT}/lib ${PREBUILT_PLATFORM_ROOT}
            NO_DEFAULT_PATH)
    # Check system dir
    find_library(${result_var}
            NAMES ${libname})
    if (NOT ${result_var})
        message(FATAL_ERROR "Could not find library ${libname} in prebuilt folder ${PREBUILT_PLATFORM_ROOT}")
    endif ()
endfunction()
