{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix Formatter
    alejandra

    # Bash LSP
    bash-language-server

    # Better cat
    bat

    # Rust installer for certain dependencies
    cargo

    # Claude Code
    claude-code

    # CLI for codecrafters projects
    codecrafters-cli

    # Better LS
    eza

    # Better find
    fd

    # Fuzzy find
    fzf

    # Make dependencies
    gnumake

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
