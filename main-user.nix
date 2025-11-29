{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    main-user.enable = lib.mkEnableOption "enable user module";

    main-user.userName = lib.mkOption {
      default = "domenico";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cnofig.main-user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      initialPassword = "domo";
      description = "main user";
      shell = pkgs.bash;
    };
  };
}
