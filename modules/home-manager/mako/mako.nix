{pkgs, ...}: {
  home.packages = [
    pkgs.mako
    pkgs.libnotify
  ];
  home.file.".config/mako/config".source = ./mako.conf;

  systemd.user.services.mako = {
    Unit = {
      Description = "Mako notification daemon";
      after = ["graphical.target"];
    };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}
