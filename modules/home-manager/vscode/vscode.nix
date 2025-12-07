{pkgs, ...}: {
  # VSCode -code editor
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        kamadorueda.alejandra # Alejandra integration
        arrterian.nix-env-selector # Select nix shells from VS Code
        jnoortheen.nix-ide # Nix IDE
        timonwong.shellcheck # ShellCheck
        eamodio.gitlens # GitLens - more Git context
        rust-lang.rust-analyzer # rust-analyzer - Rust LSP
        vadimcn.vscode-lldb # LLDB - Debugging
        tamasfe.even-better-toml # TOML syntax highlighting
        fill-labs.dependi # Cargo crate completion
        llvm-vs-code-extensions.vscode-clangd # clangd
      ];

      # hack to allow for easy LSP
      userSettings = builtins.fromJSON (builtins.readFile ../../../.vscode/settings.json);
    };
  };
}
