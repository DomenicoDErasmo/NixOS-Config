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

  # Tests: one executable per test file
    foreach(test_file ${TEST_SOURCES})
        get_filename_component(test_name ${test_file} NAME_WE)  # strip path and .cpp
        set(exe_name "${name}_${test_name}")

        add_executable(${exe_name} ${test_file})
        target_include_directories(${exe_name} PUBLIC ${exercise_dir})
        target_link_libraries(${exe_name} PRIVATE
            gtest
            gtest_main
            c++
        )

        include(GoogleTest)
        gtest_discover_tests(${exe_name}
            WORKING_DIRECTORY "${exercise_dir}/tests"
        )
    endforeach()
endfunction()

