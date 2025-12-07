{
  pkgs,
  config,
  ...
}: let
  wallpapersDir = "${config.home.homeDirectory}/Pictures/wallpapers/nature";
  wallpaperTimerInterval = "10min";
  wallpaperTimerBootDelay = "1min";
  homeDirectory = config.home.homeDirectory;
  wallpaperScript = pkgs.writeShellScriptBin "wallpaper-set" ''
    #!/run/current-system/sw/bin/zsh

    # pick random image
    image=$(find "${wallpapersDir}" -type f | shuf -n 1)

    # set wallpaper
    ${pkgs.swww}/bin/swww img "$image" --transition-duration 1 --transition-type fade &

    # store current wallpaper for other apps
    ${pkgs.coreutils}/bin/cp -f "$image" "${homeDirectory}/current-wallpaper" &
  '';
in {
  systemd.user.services.wallpaper = {
    Unit = {
      Description = "Set random wallpaper";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaperScript}/bin/wallpaper-set";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };

  home.packages = [
    wallpaperScript
  ];

  systemd.user.timers.wallpaper = {
    Unit = {
      Description = "Run wallpaper service every 10 minutes";
    };

    Timer = {
      OnBootSec = wallpaperTimerBootDelay;
      OnUnitActiveSec = wallpaperTimerInterval;
      AccuracySec = "1s";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
