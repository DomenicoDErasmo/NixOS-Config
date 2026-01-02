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
      ];

      shellHook = ''
        export CC=${pkgs.clang}/bin/clang
        export CXX=${pkgs.clang}/bin/clang++

        export LIBCXX_INCLUDE_DIR=${pkgs.llvmPackages_21.libcxx.dev}/include/c++/v1
        export LIBCXX_LIB_DIR=${pkgs.llvmPackages_21.libcxx.out}/lib

        export PATH=${pkgs.clang}/bin:$PATH

        if [ -z "$ZSH_VERSION" ]; then
          exec zsh
        fi
      '';
    };
  };
}
