{...}: {
  # Waybar - Taskbar
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = [
      {
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "custom/sound_icon"
          "pulseaudio/slider"
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
        # The hollow squares are icons taken from Ubuntu Nerd Font.
        # I couldn't get these to show up in VSCode.
        clock = {
          format = "    {:%Y-%m-%d      %I:%M %p}";
        };
        "custom/sound_icon" = {
          format = "󰕾";
        };
        cpu = {
          format = "    {usage}%";
        };
        disk = {
          format = "    {percentage_used}%";
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "persistent_workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        layer = "top";
        memory = {
          format = "󰍛    {percentage}%";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        temperature = {
          format = "    {temperatureC}°C";
        };
      }
    ];
  };
}
