{pkgs, ...}: {
  systemd.user.services.wlsunset = {
    description = "Wayland color temperature adjustment";
    serviceConfig = {
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 40.7128 -L -74.0060 -t 6500:4000 -m 0.0:1.0 -s 5";
      Type = "simple";
    };
    wantedBy = ["default.target"];
  };
}
