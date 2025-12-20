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
        cmake
        cmake-language-server
      ];

      shellHook = ''
        if [ -z "$ZSH_VERSION" ]; then
          exec zsh
        fi
      '';
    };
  };
}
