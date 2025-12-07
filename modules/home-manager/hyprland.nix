{pkgs, ...}: {
  wayland.windowManager.hyprland = let
    startupScript = pkgs.writeShellScriptBin "start" ''
      sleep 1
      swww-daemon &
      sleep 1
      waybar &
      sleep 1
      /home/domenico/.nix-profile/bin/wallpaper-set &
    '';
  in {
    settings = {
      exec-once = ''${startupScript}/bin/start'';
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, ghostty"
        "$mod, C, killactive"
        "$mod, M, exit"
        "ALT, TAB, exec, rofi -show drun -show-icons"
        "$mod SHIFT, right, movetoworkspace, +1"
        "$mod SHIFT, left, movetoworkspace, -1"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
      ];
      # TODO: how to un-hardcode?
      monitor = [
        "DP-3,2560x1440@143.97,0x0,1"
        "HDMI-A-1,2560x1440@143.98,2560x0,1"
      ];

      workspace = [
        "1,monitor:DP-3,default:true"
        "2,monitor:DP-3"
        "3,monitor:HDMI-A-1"
        "4,monitor:HDMI-A-1"
        "5,monitor:HDMI-A-1"
      ];
    };
  };
}
