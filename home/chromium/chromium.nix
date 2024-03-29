{...}: {
  # Chromium - web browser
  programs.chromium = {
    enable = true;
    extensions = [
      # uBlock Origin - Ad Blocker
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      # BetterTTV - more emotes and features
      "ajopnjidmegmdimjlfnijceegpefgped"
      # 1Password - Password manager
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
    ];
  };
}
