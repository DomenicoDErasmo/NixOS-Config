{...}: {
  # Bash - Shell
  programs.bash = {
    enable = true;
    initExtra = ''
      wallust run ~/wallpaper -p dark16 -w
    '';
  };
}
