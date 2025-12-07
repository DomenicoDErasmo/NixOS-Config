{...}: {
  # Chromium - web browser
  programs.chromium = {
    extensions = [
      # uBlock Origin - Ad Blocker
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      # 1Password - Password manager
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
    ];
  };
}
