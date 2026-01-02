cmake_minimum_required(VERSION 3.28)
project(my_project LANGUAGES CXX)

set(CMAKE_CXX_COMPILER /nix/store/sqlnjj8c3n3si3sjnadhdbcwgrk97g2w-clang-wrapper-21.1.2/bin/clang++)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem /nix/store/cvjp8w08rnzbpwkgn8nlwg8mbwap9izl-libcxx-21.1.2-dev/include/c++/v1")

enable_testing()

add_subdirectory(external/googletest)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
add_subdirectory(exercises)

