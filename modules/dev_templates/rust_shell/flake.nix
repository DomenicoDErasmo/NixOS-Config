{
  description = "Raytracer development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    fenix,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      toolchain = fenix.packages.${system}.complete.withComponents [
        "cargo"
        "rust-docs"
        "rust-src"
        "rustc"
        "clippy"
        "rust-analyzer"
      ];
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          toolchain
          pkgs.git
          pkgs.bacon
          pkgs.cargo-info
          pkgs.zsh
          pkgs.ripgrep
          pkgs.tree-sitter
          pkgs.nodejs
        ];

        shellHook = ''
              export RUST_SRC_PATH="${toolchain}/lib/rustlib/src/rust/library"
          if [ -z "$ZSH_VERSION" ]; then
            exec zsh
          fi
        '';
      };
    });
}
