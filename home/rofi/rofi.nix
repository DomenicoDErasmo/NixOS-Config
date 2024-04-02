{pkgs, ...}: {
  programs.rofi = {
    theme = "${pkgs.rofi-wayland}/share/rofi/themes/Arc-Dark.rasi";
  };
}
