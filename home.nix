{
  pkgs,
  inputs,
  ...
}: {
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
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./features/kitty/kitty.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-light;

  # VSCodium -code editor
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      kamadorueda.alejandra # Alejandra integration
      arrterian.nix-env-selector # Select nix shells in VS Code
      jnoortheen.nix-ide # Nix IDE
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "git.autofetch" = true;
      "git.terminalAuthentication" = false;
      "editor.rulers" = [88];
    };
  };

  # Chromium - web browser
  programs.chromium = {
    enable = true;
    extensions = [
      # uBlock Origin - Ad Blocker
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
    ];
  };

  # Hyprland - Window Manager
  wayland.windowManager.hyprland = let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      waybar &
      swww init &
      sleep 1
    '';
  in {
    enable = true;
    settings = {
      exec-once = ''${startupScript}/bin/start'';
      bind = [
        "SUPER, Q, exec, kitty"
        "SUPER, M, exit"
      ];
    };
  };

  # Waybar - Taskbar
  programs.waybar = {
    enable = true;
    settings = [
      {
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "battery"
          "clock"
        ];
      }
    ];
  };

  # GNOME - GUI
  # Settings: https://github.com/GNOME/gsettings-desktop-schemas/tree/master/schemas
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/wm/preferences".button-layout = "menu:minimize,maximize,close";
    };
  };

  # Git - Version control
  programs.git = {
    enable = true;
    userName = "Domenico D'Erasmo";
    userEmail = "domenicoderasmo99@gmail.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/domenico/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
