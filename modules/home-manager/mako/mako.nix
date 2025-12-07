{
  pkgs,
  config,
  ...
}: {
  home.file.".config/mako/config".source = ../mako.conf;

  home.sessionVariables = {
    XDG_RUNTIME_DIR = "/run/user/${config.uid}";
  };

  systemd.user.services.mako = {
    description = "Mako Notification Daemon";
    after = ["graphical-session.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.mako}/bin/mako";
  };
}
