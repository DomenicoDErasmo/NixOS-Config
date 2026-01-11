# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  wsl = {
    enable = true;
    defaultUser = "domenico";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    zsh
  ];

  programs.zsh.enable = true;

  users.users.domenico = {
    isNormalUser = true;
    uid = 1000;
    initialPassword = "domo";
    description = "Domenico D'Erasmo";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    users = {
      "domenico" = import ../../home-manager/wsl/home.nix;
    };
  };

  # Allow flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05"; # Did you read the comment?
}
