{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix Formatter
    alejandra

    # Bash LSP
    bash-language-server

    # Better cat
    bat

    # For dev shells
    direnv
    devenv

    # Better find
    fd

    # Better LS
    eza

    # Performance measuring
    hyperfine

    # JSON parsing
    jq

    # Markdown Linting
    markdownlint-cli

    # Markdown LSP
    marksman

    # Nix LSP
    nixd

    # View system details
    neofetch

    # Code formatter (like Markdown)
    prettier

    # Better grep
    ripgrep

    # CSS LSP
    vscode-css-languageserver

    # Wikipedia TUI
    wiki-tui
  ];

  news.display = "silent";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
