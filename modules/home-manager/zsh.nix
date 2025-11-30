{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autosuggestions.enable = true;
    shellAliases = {
      c = "clear";
    };
    histSize = 10000;
  };
}