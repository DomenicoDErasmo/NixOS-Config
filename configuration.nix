# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#
# Build with $ sudo nixos-rebuild switch --flake ./#default
#
# Check options at
# - https://mynixos.com/
# - man configuration.nix
# - https://search.nixos.org/
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Home manager - /home/domenico/
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 15;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Cachix to avoid building Hyprland
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Exclude packages from GNOME
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.domenico = {
    isNormalUser = true;
    description = "Domenico D'Erasmo";
    extraGroups = ["networkmanager" "wheel"];
    password = "";
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "domenico";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # swww on startup
  systemd.user.services.wallpaper = {
    path = ["${pkgs.swww}" "${pkgs.wallust}"];
    script = ''
      /etc/nixos/home/swww/wallpaper.sh
    '';
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
    };
  };

  systemd.user.timers.wallpaper = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "10s";
      OnUnitActiveSec = "10m";
      Unit = "wallpaper.service";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Available packages on search.nixos.org
  environment.systemPackages = with pkgs; [
    wget # wget - web getting
    kitty # Kitty - terminal emulator
    alejandra # Alejandra - Nix formatter
    nil # nil - Nix LSP
    home-manager # Home manager - Settings for programs
    obsidian # Obsidian - notetaker
    neofetch # Neofetch - system info
    discord # Discord - VOIP
    spotify # Spotify - Music player
    wallust # Wallust - Color theme from image
    unzip # Unzip - Unzip zipped archives
    waybar # Waybar - Configurable taskbar
    rofi-wayland # rofi-wayland - App switcher
    swww # swww - Wallpaper selecter
    mako # mako - Notification daemon
    ripgrep # ripgrep - Faster grep
    unrar # rar - Unzip RAR files
    libreoffice-qt # LibreOffice - Microsoft Word replacement
    hunspell # LibreOffice spellcheck
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "domenico" = import ./home.nix;
    };
    useGlobalPkgs = true;
  };

  # 1Password - password manager
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["yourUsernameHere"];
  };

  # Bash
  programs.bash = {
    shellAliases = {
      c = "clear";
      eg = "egrep";
      g = "grep";
    };
    # Doesn't work well in Virtualbox, so I've disabled this
    loginShellInit = ''
      # if [ "$(tty)" = "/dev/tty1" ];then
      #   exec Hyprland
      # fi
    '';
  };

  # nix-ld - Dynamically linked executables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # Add extra options
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
