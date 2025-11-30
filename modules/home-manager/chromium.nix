{...}: {
  # Chromium - web browser
  programs.chromium = {
    enable = true;
    extensions = [
      # uBlock Origin - Ad Blocker
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      # 1Password - Password manager
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
    ];
  };
}