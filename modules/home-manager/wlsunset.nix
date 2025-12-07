{pkgs, ...}: {
  home.packages = [
    pkgs.wlsunset
  ];

  systemd.user.services.wlsunset = {
    Unit = {
      Description = "Adjust screen color temperature automatically";
    };

    Service = {
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 40.7128 -L -74.0060 -t 3500 -T 6500";
      Type = "simple";
      Restart = "always";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
