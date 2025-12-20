project(hello LANGUAGES CXX)

add_executable(hello
    main.cpp
    printer.cpp
)

target_include_directories(hello PRIVATE .)
