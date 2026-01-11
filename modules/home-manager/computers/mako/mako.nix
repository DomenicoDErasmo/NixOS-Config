{pkgs, ...}: {
  home.packages = [
    pkgs.mako
    pkgs.libnotify
  ];

  home.file.".config/mako/config".source = ./mako.conf;
}
