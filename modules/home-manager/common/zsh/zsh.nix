{pkgs, ...}: {
  home.packages = [
    pkgs.zsh
    pkgs.zsh-powerlevel10k
    pkgs.meslo-lgs-nf
  ];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      c = "clear";
      cat = "bat";
      grep = "rg";
      g = "rg";
      ls = "exa";
      find = "fd";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    history = {
      append = true;
      share = true;
      findNoDups = true;
      expireDuplicatesFirst = true;
      extended = true;
      size = 10000;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".p10k.zsh".source = ./.p10k.zsh;
  };
}
