{...}: {
  # Tmux - Terminal Multiplexer
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    extraConfig = ''
      bind C-Space send-prefix
      set-option -g default-terminal "screen-256color"
      set-option -sg escape-time 10
      set-option -g focus-events on
    '';
  };
}
