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
      bind =
        [
          "$mod, Q, exec, ghostty"
          "$mod, W, exec, waybar"
          "ALT, TAB, exec, rofi -show drun -show-icons"
          "$mod, M, exit"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
      # TODO: how to un-hardcode?
      monitor = [
        "DP-3,2560x1440@143.97,0x0,1"
        "HDMI-A-1,2560x1440@143.98,2560x0,1"
      ];
      # fix flickering cursor
      cursor.no_hardware_cursors = true;
    };
  };
}
