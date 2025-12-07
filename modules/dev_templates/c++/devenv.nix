{
  pkgs,
  lib,
  ...
}: {
  # Basic packages
  packages = with pkgs; [
    clang
    clang-tools # includes clangd
    cmake
    gnumake
    git
    libcxx
    gcc # provides system headers
  ];

  # Correct compiler settings
  env.CC = "${pkgs.clang}/bin/clang";
  env.CXX = "${pkgs.clang}/bin/clang++";

  # Make clangd see all standard library + libc++ + system headers
  env.CPLUS_INCLUDE_PATH = lib.concatStringsSep ":" [
    "${pkgs.libcxx}/include/c++/v1"
    "${pkgs.gcc}/include/c++/${pkgs.gcc.version}"
    "${pkgs.gcc}/include/c++/${pkgs.gcc.version}/backward"
    "${pkgs.gcc}/include" # stddef.h, stdbool.h etc.
    "${pkgs.gcc}/lib/gcc/x86_64-linux-gnu/${pkgs.gcc.version}/include"
  ];

  # Helpful scripts (optional)
  scripts.hello.exec = ''
    echo "C++ dev shell ready!"
  '';

  enterShell = ''
    hello
    clang --version
    echo "Clangd sees headers at: $CPLUS_INCLUDE_PATH"
  '';

  processes.writeClangdConfig.exec = ''
        cat > .clangd <<EOF
    CompileFlags:
      Add:
        - -isystem
          ${pkgs.libcxx}/include/c++/v1
        - -isystem
          ${pkgs.gcc}/include/c++/${pkgs.gcc.version}
        - -isystem
          ${pkgs.gcc}/include/c++/${pkgs.gcc.version}/backward
        - -isystem
          ${pkgs.gcc}/lib/gcc/x86_64-linux-gnu/${pkgs.gcc.version}/include
        - -isystem
          ${pkgs.gcc}/include
    EOF
  '';
}
