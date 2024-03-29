{pkgs, ...}: {
  # VSCodium -code editor
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      kamadorueda.alejandra # Alejandra integration
      arrterian.nix-env-selector # Select nix shells in VS Code
      jnoortheen.nix-ide # Nix IDE
      timonwong.shellcheck # ShellCheck
    ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "git.autofetch" = true;
      "git.terminalAuthentication" = false;
      "editor.rulers" = [88];
    };
  };
}
