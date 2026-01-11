{pkgs, ...}: {
  home.packages = [
    pkgs.brave
  ];

  programs.brave = {
    enable = true;
    extensions = [
      # uBlock Origin - Ad Blocker
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";}
      # 1Password - Password manager
      {id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";}
      # Remove YouTube recommended and shorts
      {id = "khncfooichmfjbepaaaebmommgaepoid";}
    ];
  };
}
