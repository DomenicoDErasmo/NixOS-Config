{pkgs, ...}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "domenico";
  home.homeDirectory = "/home/domenico";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/chromium.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/mako/mako.nix
    ../../modules/home-manager/notion-pwa.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/vscode.nix
    ../../modules/home-manager/wallpaper.nix
    ../../modules/home-manager/waybar/waybar.nix
    ../../modules/home-manager/wlsunset.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  home.packages = [
    pkgs.zsh
    pkgs.zsh-powerlevel10k
    pkgs.meslo-lgs-nf
    pkgs.capitaine-cursors
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".p10k.zsh".source = ../../modules/home-manager/zsh/.p10k.zsh;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
