{pkgs, ...}: {
  systemd.user.services.swww = {
    Unit.Description = "Swww";
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Type = "simple";
      Restart = "always";
    };
    Install.WantedBy = ["default.target"];
  };
}
