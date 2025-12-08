{
  pkgs,
  config,
  ...
}: let
  wallpaperDir = "${config.users.users.domenico.homeDirectory}/Downloads/wallpapers/nature";
  wallpaperScript = pkgs.writeShellScriptBin "random-wallpaper" ''
    #!/usr/bin/env bash
    FILE=$(find "${wallpaperDir}" -type f \\( -iname "*.jpg" -o -iname "*.png" \\) | shuf -n 1)
    swww img "$FILE"
  '';
in {
  home.packages = [wallpaperScript];

  # Optionally run it on startup
  home.sessionVariables = {
    RANDOM_WALLPAPER_SCRIPT = wallpaperScript;
  };

  # Create a systemd user timer to run every 10 minutes
  systemd.user.timers.random-wallpaper = {
    description = "Change Hyprland wallpaper every 10 minutes";
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "10min";
    };
    unitConfig = {
      Service = {
        ExecStart = "${wallpaperScript}";
        Type = "oneshot";
      };
    };
  };
}
