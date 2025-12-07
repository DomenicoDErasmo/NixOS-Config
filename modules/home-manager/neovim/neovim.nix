{
  inputs,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovimNightlyOverlay.packages.${pkgs.system}.default;
  };
}
