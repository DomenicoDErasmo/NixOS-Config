{pkgs, ...}: let
  notionLogo = ./notion-logo.png;
in {
  xdg.desktopEntries.notion = {
    name = "Notion";
    exec = "${pkgs.chromium}/bin/chromium --app=https://www.notion.so/";
    icon = "${notionLogo}";
    terminal = false;
    categories = ["Office"];
    startupNotify = true;
    comment = "Notion PWA launched via Chromium";
  };
}
