# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    obsidian
    alejandra
    zsh
    nixd
    neofetch
    ghostty
    rofi
    waybar
    swww
    lsof
    discord
    wlsunset
    chromium
    mako
  ];

  programs.zsh.enable = true;
  programs._1password-gui.enable = true;

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  # Cachix to avoid building Hyprland
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  users.users.domenico = {
    isNormalUser = true;
    initialPassword = "domo";
    description = "Domenico D'Erasmo";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    users = {
      "domenico" = import ./home.nix;
    };
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.hyprland}/bin/Hyprland";
      user = "domenico";
    };
  };

  hardware.graphics.enable = true;
  # hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    egl-wayland
  ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    prime.offload.enable = false;
    nvidiaSettings = true;
    open = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  # Allow flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
