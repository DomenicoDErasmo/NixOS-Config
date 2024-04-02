{pkgs, ...}: {
  # VSCode -code editor
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      kamadorueda.alejandra # Alejandra integration
      arrterian.nix-env-selector # Select nix shells from VS Code
      jnoortheen.nix-ide # Nix IDE
      timonwong.shellcheck # ShellCheck
      eamodio.gitlens # GitLens - more Git context
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
