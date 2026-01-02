# Automatically adds an exercise with its main sources and optional tests
function(add_exercise name)
    set(exercise_dir "${CMAKE_CURRENT_LIST_DIR}")

    # Find all .cpp files in the exercise folder (excluding tests)
    file(GLOB_RECURSE EXERCISE_SOURCES
        "${exercise_dir}/*.cpp"
    )

    # Separate main sources from tests
    set(MAIN_SOURCES "")
    set(TEST_SOURCES "")
    foreach(f ${EXERCISE_SOURCES})
        if(f MATCHES "/tests/")
            list(APPEND TEST_SOURCES ${f})
        else()
            list(APPEND MAIN_SOURCES ${f})
        endif()
    endforeach()

    # Main binary
    if(MAIN_SOURCES)
        add_executable(${name}_bin ${MAIN_SOURCES})
        target_include_directories(${name}_bin PUBLIC ${exercise_dir})
        target_link_libraries(${name}_bin PRIVATE c++)
    endif()

    # Tests
    if(TEST_SOURCES)
        add_executable(${name}_tests ${TEST_SOURCES})
        target_include_directories(${name}_tests PUBLIC ${exercise_dir})
        target_link_libraries(${name}_tests PRIVATE
            gtest
            gtest_main
            c++
        )

        include(GoogleTest)
        gtest_discover_tests(${name}_tests
            WORKING_DIRECTORY "${exercise_dir}/tests"
        )
    endif()
endfunction()

