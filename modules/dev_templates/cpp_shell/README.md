# Build Instructions

1. Copy all contents (including .clangd) to your project root.
2. Add the GTest submodule with
    a. `git submodule add https://github.com/google/googletest external/googletest`
    b. `git submodule update --init --recursive`
3. Enter the dev shell with `nix develop ./#default`
4. Set up the presets to use clang++ with `cmake --preset clang`
5. Generate `./build/compile_commands.json` with `cmake -S . -B build`
6. Link this `./build/compile_commands.json` to your project root with `ln -sf ./build/compile_commands.json .`
7. Build actual binaries with `cmake --build build`
