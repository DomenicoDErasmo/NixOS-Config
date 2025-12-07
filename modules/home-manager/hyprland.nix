{pkgs, ...}: {
  wayland.windowManager.hyprland = let
    startupScript = pkgs.writeShellScriptBin "post-hyprland-startup" ''
      # --- Startup script for Hyprland session ---

      # Give Wayland a moment to settle
      sleep 1

      ${pkgs.swww}/bin/swww-daemon &

      # Wait for swww to be ready
      sleep 1

      ${pkgs.mako}/bin/mako &
      ${pkgs.wlsunset}/bin/wlsunset -l 40.7128 -L -74.0060 -t 3500 -T 6500 &

    '';
  in {
    enable = true;
    systemd.enable = true;

    settings = {
      exec-once = ''${startupScript}/bin/post-hyprland-startup'';
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, ghostty"
        "$mod, W, exec, waybar"
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
        "$mod ALT, left, movewindow, l"
        "$mod ALT, up, movewindow, u"
        "$mod ALT, right, movewindow, r"
        "$mod ALT, down, movewindow, d"
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
