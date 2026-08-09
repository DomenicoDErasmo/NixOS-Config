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
    # Rust LSP
    pkgs.rust-analyzer
    # Python type checker / LSP (global fallback; project devShells take
    # priority on PATH when present)
    pkgs.ty
    # Python linter/formatter (same fallback role as ty above)
    pkgs.ruff
    # C compiler (for building native Neovim plugins like telescope-fzf-native)
    pkgs.gcc
    # C/C++ LSP (clangd)
    pkgs.clang-tools
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovimNightlyOverlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    withPython3 = false;
    withRuby = false;

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
      blink-cmp
    ];
  };
  xdg.configFile."nvim/init.lua".source = "${inputs.neovim-config}/init.lua";
  xdg.configFile."nvim/lua".source = "${inputs.neovim-config}/lua";

  # Standard library source + compiled sysroot, for rust-analyzer to resolve
  # std types (e.g. Vec) when there's no Cargo.toml to derive a sysroot from,
  # e.g. leetcode.nvim's standalone problem files. rustc.unwrapped's output
  # already has the lib/rustlib/<target>/lib layout rust-analyzer expects
  # from a real sysroot, so this also sidesteps needing `rustc` on PATH.
  home.sessionVariables = {
    NVIM_RUST_SRC = "${pkgs.rustPlatform.rustLibSrc}";
    NVIM_RUST_SYSROOT = "${pkgs.rustc.unwrapped}";
  };
}
