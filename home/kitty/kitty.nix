{...}: {
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = "yes";
      background_opacity = "0.8";
      draw_minimal_borders = "yes";
      background_blur = "255";
    };
  };
}
