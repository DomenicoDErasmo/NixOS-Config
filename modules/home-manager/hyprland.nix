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
        "$mod, W, exec, waybar"
        "$mod, C, killactive"
        "ALT, TAB, exec, rofi -show drun -show-icons"
        "$mod, M, exit"
      ];
      # TODO: how to un-hardcode?
      monitor = [
        "DP-3,2560x1440@143.97,0x0,1"
        "HDMI-A-1,2560x1440@143.98,2560x0,1"
      ];

      # workspace = [
      #   "1,monitor:DP-3,default:true"
      #   "2,monitor:DP-3"
      #   "3,monitor:DP-3"
      #   "4,monitor:DP-3"
      #   "5,monitor:DP-3"
      # ];
    };
  };
}
