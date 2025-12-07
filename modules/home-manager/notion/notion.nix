{pkgs, ...}: {
  xdg.desktopEntries.notion = {
    name = "Notion";
    exec = "${pkgs.chromium}/bin/chromium --app=https://www.notion.so/";
    icon = "./notion-logo.png";
    terminal = false;
    categories = ["Office"];
    startupNotify = true;
    comment = "Notion PWA launched via Chromium";
  };
}
