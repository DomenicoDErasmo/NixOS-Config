{...}: {
  # Git - Version control
  programs.git = {
    enable = true;
    userName = "Domenico D'Erasmo";
    userEmail = "domenicoderasmo99@gmail.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };
}