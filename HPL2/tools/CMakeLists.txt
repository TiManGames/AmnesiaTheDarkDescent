cmake_minimum_required (VERSION 3.19)
project(Tools)

find_file(TOOLINFO_PLIST Tool-Info.plist
    PATHS ${CMAKE_CURRENT_SOURCE_DIR}
    NO_DEFAULT_PATH
)
mark_as_advanced(TOOLINFO_PLIST)

function(AddToolTarget target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} HPL2)
endfunction()

if(USERDIR_RESOURCES)
    add_definitions(
        -DUSERDIR_RESOURCES
    )
endif()

add_subdirectory(editors build_editors)

file(GLOB common_sources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    ../tests/Common/*.*
)

### MapViewer

AddToolTarget(MapViewerCE
    mapview/MapView.cpp
    ${common_sources}
)

### ModelViewer

AddToolTarget(ModelViewerCE
    modelview/ModelView.cpp
    ${common_sources}
)

### ParticleViewer

# AddToolTarget(ParticleViewer
#    particleview/ParticleView.cpp
#    ${common_sources}
# )

##  Mesh Converter

# add_executable(MshConverter
#     mshconverter/MshConverter.cpp
# )
# target_link_libraries(MshConverter HPL2)

