# Build Instructions

1. Copy all contents (including .clangd) to your project root.
2. Enter the dev shell with `nix develop ./#default`
3. Set up the presets to use clang++ with `cmake --preset clang`
4. Generate `./build/compile_commands.json` with `cmake -S . -B build`
5. Link this `./build/compile_commands.json` to your project root with `ln -sf ./build/compile_commands.json .`
6. Build actual binaries with `cmake --build build`
