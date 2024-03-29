{...}: {
  # Waybar - Taskbar
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = [
      {
        modules-left = [
          "custom/rofi"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "pulseaudio"
          "disk"
          "temperature"
          "memory"
          "cpu"
          "clock"
        ];
        "custom/rofi" = {
          format = "Apps";
          "on-click" = "rofi -show drun -show-icons";
        };
        clock = {
          format = "{:%Y-%m-%d   |   %I:%M %p}";
        };
        layer = "top";
      }
    ];
  };
}
