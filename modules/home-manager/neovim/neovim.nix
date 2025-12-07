{pkgs, ...}: let
  neovimNightlyOverlay = import (builtins.fetchGit {
    url = "https://github.com/nix-community/neovim-nightly-overlay.git";
  });
in {
  home.packages = [
    (import pkgs {
      overlays = [neovimNightlyOverlay];
    }).neovim-nightly
  ];

  programs.neovim = {
    enable = true;
    package =
      (import pkgs {
        overlays = [neovimNightlyOverlay];
      }).neovim-nightly;
  };
}
