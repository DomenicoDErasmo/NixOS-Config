{pkgs, ...}: {
  home.packages = [
    pkgs.chromium
  ];

  programs.chromium = {
    extensions = [
      # uBlock Origin - Ad Blocker
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      # 1Password - Password manager
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
    ];
  };
}
