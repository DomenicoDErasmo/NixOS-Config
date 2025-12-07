{pkgs, ...}: {
  xdg.desktopEntries.notion = {
    name = "Notion";
    exec = "${pkgs.chromium}/bin/chromium --app=https://www.notion.so/";
    icon = "${pkgs.chromium}/share/icons/hicolor/128x128/apps/chromium.png"; # you can replace with a custom Notion icon
    terminal = false;
    categories = ["Office"];
    startupNotify = true;
    comment = "Notion PWA launched via Chromium";
  };
}
