{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    # Unzip compressed files (for stylua in Neovim)
    pkgs.unzip
    # Lua formatting
    pkgs.stylua
    # Lua LSP
    pkgs.lua-language-server
    # Rustfmt
    pkgs.rustfmt
    # Python language server
    pkgs.pyright
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovimNightlyOverlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    plugins = with pkgs.vimPlugins; [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p:
        with p; [
          lua
          rust
          cpp
          python
          css
          cmake
          markdown
          markdown_inline
          nix
          bash
          c
        ]))
      # Pre-compiled plugins (require native compilation)
      telescope-fzf-native-nvim
      blink-cmp
    ];
  };
  home.file.".config/nvim/init.lua".source = ./config/init.lua;
  home.file.".config/nvim/lua".source = ./config/lua;
}
