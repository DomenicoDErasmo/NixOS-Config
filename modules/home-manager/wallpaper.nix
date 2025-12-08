{
  pkgs,
  config,
  ...
}: let
  wallpaperDir = "${config.home.homeDirectory}/Pictures/wallpapers/nature";
  wallpaperScript = pkgs.writeShellScriptBin "random-wallpaper" ''
    WALLPAPER_DIR="${config.home.homeDirectory}/Pictures/wallpapers/nature"
    FILE=$(find "${wallpaperDir}" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)
    swww img "$FILE" --transition-duration 2
  '';
in {
  home.packages = [wallpaperScript];

  systemd.user.services.random-wallpaper = {
    Unit.Description = "Random wallpaper changer";
    Service = {
      ExecStart = "${wallpaperScript}/bin/random-wallpaper";
    };
  };

  systemd.user.timers.random-wallpaper = {
    Unit.Description = "Run random wallpaper every 10 minutes";
    Timer = {
      OnBootSec = "1m";
      OnUnitActiveSec = "10m";
    };
    Install.WantedBy = ["timers.target"];
  };
}
