{pkgs, ...}: {
  # Waybar - Taskbar
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = [
      {
        modules-left = [
          "hyprland/workspaces"
          "custom/rofi"
        ];

        modules-right = [
          "clock"
          "custom/weather"
          "battery"
          "custom/power"
        ];

        "custom/rofi" = {
          format = "Apps";
          "on-click" = "rofi -show drun -show-icons";
        };

        # The hollow squares are icons taken from Ubuntu Nerd Font.
        # I couldn't get these to show up in VSCode.
        clock = {
          format = "    {:%Y-%m-%d      %I:%M %p}";
          "tooltip" = false;
        };

        "custom/weather" = {
          "format" = "{}°";
          "tooltip" = true;
          "interval" = 3600;
          "exec" = "wttrbar --fahrenheit";
          "return-type" = "json";
        };

        "custom/power" = {
          "format" = "⏻ ";
          "tooltip" = false;
          "on-click" = "~/.config/waybar/power_menu.sh";
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        layer = "top";
      }
    ];
  };
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar panel";
      After = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "always";
      RestartSec = 2;
      Type = "simple";
    };
  };

  home.file.".config/waybar/power_menu.sh".source = ./power_menu.sh;
}
