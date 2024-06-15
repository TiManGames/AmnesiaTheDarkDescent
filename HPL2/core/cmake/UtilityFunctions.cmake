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

# Helper to ensures a scope has been set for certain target properties
macro(_SetDefaultScope var_name default_scope)
    list(GET ${var_name} 0 __setdefaultscope_temp)
    if (__setdefaultscope_temp STREQUAL "PRIVATE" OR __setdefaultscope_temp STREQUAL "PUBLIC" OR __setdefaultscope_temp STREQUAL "INTERFACE")
    else ()
        list(INSERT ${var_name} 0 ${default_scope})
    endif ()
    unset(__setdefaultscope_temp)
endmacro()

# magic function to handle the power functions below
function(_BuildDynamicTarget name type)
    set(_mode "dirs")
    foreach (dir ${ARGN})
        if (dir STREQUAL "EXCLUDE")
            set(_mode "excl")
        elseif (dir STREQUAL "DIRS")
            set(_mode "dirs")
        elseif (dir STREQUAL "FILES")
            set(_mode "files")
        elseif (dir STREQUAL "INCLUDES")
            set(_mode "incl")
        elseif (dir STREQUAL "DEFINES")
            set(_mode "define")
        elseif (dir STREQUAL "FLAGS")
            set(_mode "flags")
        elseif (dir STREQUAL "LINK")
            set(_mode "link")
        else ()
            if (_mode STREQUAL "excl")
                file(GLOB _files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
                        ${dir}
                        )
                if (_files)
                    list(REMOVE_ITEM _source_files
                            ${_files}
                            )
                endif ()
            elseif (_mode STREQUAL "files")
                list(APPEND _source_files
                        ${dir}
                        )
            elseif (_mode STREQUAL "incl")
                list(APPEND _include_dirs
                        ${dir}
                        )
            elseif (_mode STREQUAL "define")
                list(APPEND _definitions
                        ${dir}
                        )
            elseif (_mode STREQUAL "flags")
                list(APPEND _flags
                        ${dir}
                        )
            elseif (_mode STREQUAL "link")
                list(APPEND _link_libs
                        ${dir}
                        )
            elseif (_mode STREQUAL "dirs")
                file(GLOB _files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
                        ${dir}/*.c
                        ${dir}/*.cpp
                        ${dir}/*.h
                        ${dir}/*.hpp
                        ${dir}/*.inl
                        )
                if (_files)
                    list(APPEND _source_files
                            ${_files}
                            )
                endif ()
            else ()
                message(FATAL_ERROR "Unknown Mode ${_mode}")
            endif ()
        endif ()
    endforeach ()
    if (NOT _source_files)
        message(FATAL_ERROR "Could not find any sources for ${name}")
    endif ()
    if (type STREQUAL "lib")
        add_library(${name} EXCLUDE_FROM_ALL
                ${_source_files}
                )
    else ()
        add_executable(${name} MACOSX_BUNDLE WIN32
                ${_source_files}
                )
    endif ()
    if (_include_dirs)
        _SetDefaultScope(_include_dirs PRIVATE)
        target_include_directories(${name} ${_include_dirs})
    endif ()
    if (_definitions)
        _SetDefaultScope(_definitions PRIVATE)
        target_compile_definitions(${name} ${_definitions})
    endif ()
    if (_link_libs)
        target_link_libraries(${name} ${_link_libs})
    endif ()
    if (_flags)
        set_target_properties(${name} PROPERTIES
                COMPILE_FLAGS "${_flags}"
                )
    endif ()
endfunction()


