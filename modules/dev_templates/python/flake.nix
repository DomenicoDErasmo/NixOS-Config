{
  description = "Python dev shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.python313
        pkgs.python313Packages.pip
        pkgs.python313Packages.virtualenv
        pkgs.pyright
        pkgs.pylint
        pkgs.black
        pkgs.mypy
        pkgs.zsh
      ];

      shellHook = ''
        zsh
      '';
    };
  };
}
