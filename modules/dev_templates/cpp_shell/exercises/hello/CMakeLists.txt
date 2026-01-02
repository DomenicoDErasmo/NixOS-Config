add_executable(printer_bin main.cpp)
target_include_directories(printer_bin PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(printer_bin PRIVATE c++)

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/tests)
    # Collect all test source files
    file(GLOB TEST_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cpp)

    # Only if tests exist
    if(TEST_SOURCES)
      add_executable(printer_tests ${TEST_SOURCES})

      target_link_libraries(printer_tests PRIVATE
          gtest
          gtest_main
          c++
      )

      include(GoogleTest)
      gtest_discover_tests(printer_tests
          WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tests
      )
  endif()
endif()

