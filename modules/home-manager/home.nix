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
    ./brave.nix
    ./ghostty/ghostty.nix
    ./git.nix
    ./hyprland.nix
    ./mako/mako.nix
    ./neovim/neovim.nix
    ./notion/notion.nix
    ./rofi.nix
    ./vscode.nix
    ./wallpaper.nix
    ./waybar/waybar.nix
    ./zsh/zsh.nix
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

    # Markdown Linting
    markdownlint-cli

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
