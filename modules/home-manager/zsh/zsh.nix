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
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".p10k.zsh".source = ./.p10k.zsh;
  };
}
