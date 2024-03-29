{...}: {
  # Bash - Shell
  programs.bash = {
    enable = true;
    initExtra = ''
      wal -c
      wal -i ~/wallpaper
      wal -c
    '';
  };
}
