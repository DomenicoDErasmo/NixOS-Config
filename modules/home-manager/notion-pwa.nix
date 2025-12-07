{
  config,
  pkgs,
  ...
}: let
  manifestDir = "${config.home.homeDirectory}/.local/share/firefoxpwa/notion";
in {
  # Install firefoxpwa
  home.packages = [
    pkgs.firefoxpwa
    pkgs.wget
  ];

  # Create the directory + manifest + icon
  home.file."${manifestDir}/manifest.json".text = ''
    {
      "name": "Notion",
      "short_name": "Notion",
      "start_url": "https://www.notion.so/",
      "display": "standalone",
      "background_color": "#ffffff",
      "theme_color": "#ffffff",
      "icons": [
        {
          "src": "icon.png",
          "sizes": "512x512",
          "type": "image/png"
        }
      ]
    }
  '';

  # Fetch the Notion icon (no derivations needed)
  home.file."${manifestDir}/icon.png".source = pkgs.fetchurl {
    url = "https://www.notion.so/front-static/favicon.png";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    # replace this with the real hash — see instructions below
  };

  # Desktop entry
  home.file.".local/share/applications/notion.desktop".text = ''
    [Desktop Entry]
    Name=Notion
    Exec=firefoxpwa site launch ${manifestDir}/manifest.json
    Terminal=false
    Type=Application
    Categories=Office;
    Icon=${manifestDir}/icon.png
    StartupWMClass=notion
  '';

  # Install the PWA automatically
  # Runs at login (and only installs if not already installed)
  systemd.user.services.notion-pwa-install = {
    Unit = {
      Description = "Install Notion PWA using firefoxpwa";
    };
    Service = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.firefoxpwa}/bin/firefoxpwa site install file://${manifestDir}/manifest.json --no-launch
      '';
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}
