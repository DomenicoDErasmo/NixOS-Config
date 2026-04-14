{...}: {
  # Tmux - Terminal Multiplexer
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    extraConfig = ''
      bind C-Space send-prefix
    '';
  };
}
