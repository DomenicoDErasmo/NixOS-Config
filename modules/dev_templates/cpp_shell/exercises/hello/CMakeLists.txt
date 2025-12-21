add_library(printer_lib
    printer.cpp
)
target_include_directories(printer_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_executable(printer_bin main.cpp)
target_link_libraries(printer_bin PRIVATE printer_lib)
target_include_directories(printer_bin PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/tests)
    # Collect all test source files
    file(GLOB TEST_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cpp)

    if(TEST_SOURCES)
        add_executable(printer_tests ${TEST_SOURCES})

        # Link with the exercise library and GoogleTest
        target_link_libraries(printer_tests PRIVATE
            printer_lib
            GTest::gtest
            GTest::gtest_main
        )

        # Register tests with CTest
        include(GoogleTest)
        gtest_discover_tests(linked_list_tests
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tests
        )
    endif()
endif()
