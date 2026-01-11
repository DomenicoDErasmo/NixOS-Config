{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        llvmPackages_21.clang
        llvmPackages_21.clang-tools
        llvmPackages_21.libcxx
        cmake
        cmake-language-server
        gdb
        glibc.dev
        gtest
      ];

      shellHook = ''
        export CC=${pkgs.llvmPackages_21.clang}/bin/clang
        export CXX=${pkgs.llvmPackages_21.clang}/bin/clang++

        export C_INCLUDE_PATH=$C_INCLUDE_PATH:${pkgs.glibc.dev}/include
        export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:${pkgs.glibc.dev}/include

        export LIBCXX_INCLUDE_DIR=${pkgs.llvmPackages_21.libcxx.dev}/include/c++/v1
        export LIBCXX_LIB_DIR=${pkgs.llvmPackages_21.libcxx.out}/lib

        export PATH=${pkgs.llvmPackages_21.clang}/bin:$PATH

        export GTEST_ROOT=${pkgs.gtest}
        export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:$GTEST_ROOT

        export PATH=${pkgs.llvmPackages_21.lldb}/bin:$PATH

        if [ -z "$ZSH_VERSION" ]; then
          exec zsh
        fi
      '';
    };
  };
}
