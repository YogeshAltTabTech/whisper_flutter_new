cmake_minimum_required(VERSION 3.4.1)
project(whisper_flutter_new)

# Enable Vulkan support
find_package(Vulkan REQUIRED)

# Set source files
set(WHISPER_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/src/whisper/whisper.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/whisper/ggml.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/whisper/ggml-vulkan.c
)

# Add whisper library
add_library(whisper SHARED ${WHISPER_SOURCES})

# Add compiler definitions for GPU support
target_compile_definitions(whisper PRIVATE
    GGML_USE_VULKAN
)

# Include directories
target_include_directories(whisper PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src/whisper
    ${Vulkan_INCLUDE_DIRS}
)

# Link libraries
target_link_libraries(whisper
    Vulkan::Vulkan
    android
    log
)

# Set compiler flags for optimization
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DNDEBUG")

# Enable LTO for better optimization
set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)

# Set platform-specific flags
if(ANDROID)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fexceptions -frtti")
endif() 