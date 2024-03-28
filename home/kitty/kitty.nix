{config, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = "yes";
      background_opacity = "0.8";
      draw_minimal_borders = "yes";
      background_blur = "255";

      # TODO: get color scheme working (base 16 is wonky)
      # # Colors
      # foreground = "#${config.colorScheme.palette.base05}";
      # background = "#${config.colorScheme.palette.base00}";

      # # The 16 terminal colors. There are 8 basic colors, each color has a dull and
      # # bright version.

      # # black
      # color0 = "#${config.colorScheme.palette.base00}";
      # color8 = "#${config.colorScheme.palette.base08}";

      # # red
      # color1 = "#${config.colorScheme.palette.base01}";
      # color9 = "#${config.colorScheme.palette.base09}";

      # # green
      # color2 = "#${config.colorScheme.palette.base02}";
      # color10 = "#${config.colorScheme.palette.base0A}";

      # # yellow
      # color3 = "#${config.colorScheme.palette.base03}";
      # color11 = "#${config.colorScheme.palette.base0B}";

      # # blue
      # color4 = "#${config.colorScheme.palette.base04}";
      # color12 = "#${config.colorScheme.palette.base0C}";

      # # magenta
      # color5 = "#${config.colorScheme.palette.base05}";
      # color13 = "#${config.colorScheme.palette.base0D}";

      # # cyan
      # color6 = "#${config.colorScheme.palette.base06}";
      # color14 = "#${config.colorScheme.palette.base0E}";

      # # white
      # color7 = "#${config.colorScheme.palette.base07}";
      # color15 = "#${config.colorScheme.palette.base0F}";
    };
  };
}
