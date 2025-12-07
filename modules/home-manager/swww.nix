{pkgs, ...}: {
  systemd.user.services.waybar = {
    Unit.Description = "Swww";
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Type = "simple";
      Restart = "always";
    };
    Install.WantedBy = ["default.target"];
  };
}
