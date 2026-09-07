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
    # Rust linter (cargo-clippy), used by rust-analyzer's checkOnSave
    pkgs.clippy
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
  # Global clangd fallback for real libc++ headers (e.g. go-to-definition
  # from project code into <algorithm>): those files live entirely outside
  # any project's compile_commands.json, so clangd can't associate them
  # with a translation unit and parses them with generic defaults instead
  # - no -std flag, and guessed as Objective-C++ from the ambiguous .h
  # extension. That leaves _LIBCPP_STD_VER undefined, greying out every
  # version-gated block (e.g. C++20/23 <algorithm> additions). libcxx's own
  # headers also cross-reference each other via angle-bracket #includes
  # (e.g. <__config>), which only resolve via an explicit -isystem into
  # their v1 directory.
  #
  # PathMatch is a name pattern rather than a literal store path so it
  # survives libcxx version/hash changes; -isystem is a real Nix-computed
  # store path (not typed in) for the same reason.
  xdg.configFile."clangd/config.yaml".text = ''
    If:
      PathMatch: .*-libcxx-[0-9.]+-dev/include/c\+\+/v1/.*
    CompileFlags:
      Add:
        - -xc++-header
        - -std=c++23
        - -stdlib=libc++
        - -isystem
        - ${pkgs.llvmPackages_21.libcxx.dev}/include/c++/v1
  '';

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
