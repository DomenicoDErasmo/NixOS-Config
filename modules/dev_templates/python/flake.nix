{
  description = "Python dev shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {nixpkgs}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.python313
        pkgs.python313Packages.pip
        pkgs.python313Packages.virtualenv
        pkgs.ruff
        pkgs.mypy
      ];

      shellHook = ''
        echo "Welcome to the Python dev shell!"
        export PYTHONWARNINGS="ignore"
      '';
    };
  };
}
