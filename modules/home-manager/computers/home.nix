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
    ../common/git.nix
    ../common/neovim/neovim.nix
    ../common/tmux.nix
    ../common/zsh/zsh.nix
    ../common/settings.nix
    ./brave.nix
    ./ghostty/ghostty.nix
    ./hyprland.nix
    ./mako/mako.nix
    ./notion/notion.nix
    ./rofi.nix
    ./vscode.nix
    ./wallpaper.nix
    ./waybar/waybar.nix
  ];

  home.packages = with pkgs; [
    # Password Manager
    _1password-gui

    # Study tool
    anki

    # Sound visualizer
    cava

    # CLI bonsai tree
    cbonsai

    # CLI matrix animation
    cmatrix

    # Voice calls
    discord

    # TUI Spotify
    ncspot

    # Paint
    pinta

    # CLI pipe animation
    pipes

    # Redlight
    wlsunset

    # Weather in Wayland
    wttrbar
  ];

  # For certain Electron apps like 1password
  home.sessionVariables = {
    # For more dark themes
    GTK_THEME = "Adwaita:dark";
  };
}
