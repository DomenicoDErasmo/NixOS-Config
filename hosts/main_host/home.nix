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
    ../../modules/home-manager/brave.nix
    ../../modules/home-manager/ghostty/ghostty.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/mako/mako.nix
    ../../modules/home-manager/neovim/neovim.nix
    ../../modules/home-manager/notion/notion.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/vscode.nix
    ../../modules/home-manager/wallpaper.nix
    ../../modules/home-manager/waybar/waybar.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
    # Password Manager
    _1password-gui

    # Nix Formatter
    alejandra

    # Study tool
    anki

    # Bash LSP
    bash-language-server

    # Sound visualizer
    cava

    # CLI bonsai tree
    cbonsai

    # CLI matrix animation
    cmatrix

    # For dev shells
    direnv
    devenv

    # Voice calls
    discord

    # Performance measuring
    hyperfine

    # Markdown LSP
    marksman

    # TUI Spotify
    ncspot

    # Nix LSP
    nixd

    # View system details
    neofetch

    # Better grep
    ripgrep

    # CLI pipe animation
    pipes

    # CSS LSP
    vscode-css-languageserver

    # Wikipedia TUI
    wiki-tui

    # Redlight
    wlsunset

    # Weather in Wayland
    wttrbar
  ];

  # For certain Electron apps like 1password
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
