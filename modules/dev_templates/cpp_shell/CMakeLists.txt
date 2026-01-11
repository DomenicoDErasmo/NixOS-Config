cmake_minimum_required(VERSION 3.28)
project(roadmap_study_cpp LANGUAGES CXX)

# Use compiler from environment
if(DEFINED ENV{CC})
  set(CMAKE_C_COMPILER   $ENV{CC})
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

# GoogleTest submodule
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

# Output binaries to bin/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# Include helpers
include(cmake/Helpers.cmake)

# Add exercises
add_subdirectory(exercises)

