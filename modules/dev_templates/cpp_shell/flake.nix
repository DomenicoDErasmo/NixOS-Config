{
  description = "C++ development shell with clang, lldb, cmake, and Zsh";

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
        clang
        clang-tools
        lldb
        cmake
        gcc
      ];

      shell = pkgs.zsh;
    };
  };
}
