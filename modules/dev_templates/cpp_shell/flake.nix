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

      # Force clang++ / clang as default compiler
      shellHook = ''
        export CC=clang
        export CXX=clang++
        if [ -z "$ZSH_VERSION" ]; then
          exec zsh
        fi
      '';
    };
  };
}
