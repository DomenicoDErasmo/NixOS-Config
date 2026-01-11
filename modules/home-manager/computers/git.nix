{...}: {
  # Git - Version control
  programs.git = {
    enable = true;
    settings = {
      core = {
        editor = "nvim";
      };
      user = {
        name = "Domenico D'Erasmo";
        email = "domenicoderasmo99@gmail.com";
      };
    };
  };
}
