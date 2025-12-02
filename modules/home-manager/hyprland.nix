{pkgs, ...}: {
  # Hyprland - Window Manager
  wayland.windowManager.hyprland = let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    '';
  in {
    enable = true;
    settings = {
      exec-once = ''${startupScript}/bin/start'';
      bind = [
        "SUPER, Q, exec, kitty"
        "SUPER, W, exec, waybar"
        "SUPER, C, killactive"
        "ALT, TAB, exec, rofi -show drun -show-icons"
      ];
    };
  };
}