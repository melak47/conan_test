cmake_minimum_required(VERSION 3.15)

project(conan_test VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(cmake/conan-integration.cmake)

find_package(fmt REQUIRED)
find_package(SDL2 REQUIRED)
find_package(SDL2_image REQUIRED)

add_executable(conan_test
    src/conan_test.cpp
)
target_link_libraries(conan_test PRIVATE
    fmt::fmt
    SDL2::SDL2main
    SDL2::SDL2
    SDL2_image::SDL2_image
)

