{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix Formatter
    alejandra

    # Bash LSP
    bash-language-server

    # For dev shells
    direnv
    devenv

    # better find
    fd

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
}
