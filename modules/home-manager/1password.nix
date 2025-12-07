{pkgs, ...}: {
  home.packages = [
    pkgs._1password-gui
  ];

  xdg.desktopEntries.onepassword = {
    name = "1Password";
    exec = "${pkgs._1password-gui}/bin/1password";
    icon = "${pkgs._1password-gui}/share/icons/hicolor/128x128/apps/1password.png"; # optional custom icon
    terminal = false;
    categories = ["Utility"];
  };
}
