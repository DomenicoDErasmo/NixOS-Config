cmake_minimum_required(VERSION 3.28)
project(roadmap_study_cpp LANGUAGES CXX)

# Default build type to debug
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_compile_options(-g -fno-omit-frame-pointer)
endif()

# Use compiler from environment
if(DEFINED ENV{CC})
  set(CMAKE_C_COMPILER $ENV{CC})
endif()
if(DEFINED ENV{CXX})
  set(CMAKE_CXX_COMPILER $ENV{CXX})
endif()

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Use libc++ if env vars are set
if(DEFINED ENV{LIBCXX_INCLUDE_DIR})
  include_directories(SYSTEM $ENV{LIBCXX_INCLUDE_DIR})
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
endif()
if(DEFINED ENV{LIBCXX_LIB_DIR})
  link_directories($ENV{LIBCXX_LIB_DIR})
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc++ -lc++abi")
endif()

enable_testing()

include(FetchContent)

set(FETCHCONTENT_BASE_DIR "${CMAKE_BINARY_DIR}/_deps")

FetchContent_Declare(
  googletest 
  GIT_REPOSITORY https://github.com/google/googletest.git 
  GIT_TAG v1.17.0
)

FetchContent_GetProperties(googletest)
if(NOT googletest_POPULATED)
  FetchContent_MakeAvailable(googletest)
endif()

# GoogleTest submodule
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

# Output binaries to bin/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# Include helpers
include(cmake/Helpers.cmake)

# Add exercises
add_subdirectory(exercises)

