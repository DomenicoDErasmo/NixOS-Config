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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "domenico";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # swww on startup
  systemd.user.services.wallpaper = {
    path = ["${pkgs.swww}" "${pkgs.pywal}"];
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
      OnUnitActiveSec = "5m";
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
    nil # nil - Nix LSP
    home-manager # Home manager - Settings for programs
    pkgs.notion-app-enhanced # Notion - productivity
    obsidian # Obsidian - notetaker
    neofetch # Neofetch - system info
    discord # Discord - VOIP
    spotify # Spotify - Music player
    pywal # Pywal - Color theme from image
    unzip # Unzip - Unzip zipped archives
    waybar # Waybar - Configurable taskbar
    rofi-wayland # rofi-wayland - App switcher
    swww # swww - Wallpaper selecter
    mako # mako - Notification daemon
    ripgrep # ripgrep - Faster grep
    alejandra # Alejandra - Nix formatter
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "domenico" = import ./home.nix;
    };
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
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ];then
        exec Hyprland
      fi
    '';
  };

  # Nixvim
  # programs.nixvim = {
  #   enable = true;

  #   options = {
  #     number = true;
  #     relativenumber = true;
  #   };

  #   plugins = {
  #     # Builtin LSP
  #     lsp = {
  #       enable = true;
  #       servers = {
  #         # Rust
  #         rust-analyzer = {
  #           enable = true;
  #           installCargo = true;
  #           installRustc = true;
  #           settings = {
  #             checkOnSave = true;
  #             check = {
  #               command = "clippy";
  #               extraArgs = [
  #                 "--"
  #                 # "-D"
  #                 # "clippy::correctness"
  #                 # "-D"
  #                 # "clippy::pedantic"
  #                 # "-D"
  #                 # "clippy::nursery"
  #                 # "-D"
  #                 # "clippy::perf"
  #                 # "-D"
  #                 # "clippy::suspicious"
  #                 # "-D"
  #                 # "clippy::style"
  #                 # "-D"
  #                 # "clippy::complexity"
  #                 # "-D"
  #                 # "clippy::cargo"
  #                 # "-D"
  #                 # "clippy::absolute_paths"
  #                 # "-D"
  #                 # "clippy::alloc_instead_of_core"
  #                 # "-D"
  #                 # "clippy::arithmetic_side_effects"
  #                 # "-D"
  #                 # "clippy::as_underscore "
  #                 # "-D"
  #                 # "clippy::assertions_on_result_states"
  #                 # "-D"
  #                 # "clippy::clone_on_ref_ptr"
  #                 # "-D"
  #                 # "clippy::create_dir"
  #                 # "-D"
  #                 # "clippy::decimal_literal_representation"
  #                 # "-D"
  #                 # "clippy::default_numeric_fallback"
  #                 # "-D"
  #                 # "clippy::default_union_representation"
  #                 # "-D"
  #                 # "clippy::disallowed_script_idents"
  #                 # "-D"
  #                 # "clippy::else_if_without_else"
  #                 # "-D"
  #                 # "clippy::empty_drop"
  #                 # "-D"
  #                 # "clippy::empty_structs_with_brackets"
  #                 # "-D"
  #                 # "clippy::error_impl_error"
  #                 # "-D"
  #                 # "clippy::exit"
  #                 # "-D"
  #                 # "clippy::expect_used"
  #                 # "-D"
  #                 # "clippy::filetype_is_file"
  #                 # "-D"
  #                 # "clippy::float_arithmetic"
  #                 # "-D"
  #                 # "clippy::float_cmp_const"
  #                 # "-D"
  #                 # "clippy::fn_to_numeric_cast_any"
  #                 # "-D"
  #                 # "clippy::format_push_string"
  #                 # "-D"
  #                 # "clippy::get_unwrap"
  #                 # "-D"
  #                 # "clippy::host_endian_bytes"
  #                 # "-D"
  #                 # "clippy::if_then_some_else_none"
  #                 # "-D"
  #                 # "clippy::impl_trait_in_params"
  #                 # "-D"
  #                 # "clippy::indexing_slicing"
  #                 # "-D"
  #                 # "clippy::infinite_loop"
  #                 # "-D"
  #                 # "clippy::integer_division"
  #                 # "-D"
  #                 # "clippy::iter_over_hash_type"
  #                 # "-D"
  #                 # "clippy::large_include_file"
  #                 # "-D"
  #                 # "clippy::let_underscore_must_use"
  #                 # "-D"
  #                 # "clippy::let_underscore_untyped"
  #                 # "-D"
  #                 # "clippy::little_endian_bytes"
  #                 # "-D"
  #                 # "clippy::lossy_float_literal"
  #                 # "-D"
  #                 # "clippy::map_err_ignore"
  #                 # "-D"
  #                 # "clippy::mem_forget"
  #                 # "-D"
  #                 # "clippy::min_ident_chars"
  #                 # "-D"
  #                 # "clippy::missing_assert_message"
  #                 # "-D"
  #                 # "clippy::missing_asserts_for_indexing"
  #                 # "-D"
  #                 # "clippy::missing_docs_in_private_items"
  #                 "-D"
  #                 "clippy::missing_inline_in_public_items"
  #                 # "-D"
  #                 # "clippy::missing_trait_methods"
  #                 # "-D"
  #                 # "clippy::mixed_read_write_in_expression"
  #                 # "-D"
  #                 # "clippy::mod_module_files"
  #                 # "-D"
  #                 # "clippy::modulo_arithmetic"
  #                 # "-D"
  #                 # "clippy::multiple_inherent_impl"
  #                 # "-D"
  #                 # "clippy::multiple_unsafe_ops_per_block"
  #                 # "-D"
  #                 # "clippy::mutex_atomic"
  #                 # "-D"
  #                 # "clippy::needless_raw_strings"
  #                 # "-D"
  #                 # "clippy::non_ascii_literal"
  #                 # "-D"
  #                 # "clippy::panic"
  #                 # "-D"
  #                 # "clippy::panic_in_result_fn"
  #                 # "-D"
  #                 # "clippy::partial_pub_fields"
  #                 # "-D"
  #                 # "clippy::pattern_type_mismatch"
  #                 # "-D"
  #                 # "clippy::pub_use"
  #                 # "-D"
  #                 # "clippy::pub_with_shorthand"
  #                 # "-D"
  #                 # "clippy::rc_buffer"
  #                 # "-D"
  #                 # "clippy::rc_mutex"
  #                 # "-D"
  #                 # "clippy::redundant_type_annotations"
  #                 # "-D"
  #                 # "clippy::rest_pat_in_fully_bound_structs"
  #                 # "-D"
  #                 # "clippy::same_name_method"
  #                 # "-D"
  #                 # "clippy::semicolon_inside_block"
  #                 # "-D"
  #                 # "clippy::shadow_reuse"
  #                 # "-D"
  #                 # "clippy::shadow_same"
  #                 # "-D"
  #                 # "clippy::shadow_unrelated"
  #                 # "-D"
  #                 # "clippy::single_char_lifetime_names"
  #                 # "-D"
  #                 # "clippy::std_instead_of_alloc"
  #                 # "-D"
  #                 # "clippy::std_instead_of_core"
  #                 # "-D"
  #                 # "clippy::str_to_string"
  #                 # "-D"
  #                 # "clippy::string_add"
  #                 # "-D"
  #                 # "clippy::string_lit_chars_any"
  #                 # "-D"
  #                 # "clippy::string_slice"
  #                 # "-D"
  #                 # "clippy::string_to_string"
  #                 # "-D"
  #                 # "clippy::suspicious_xor_used_as_pow"
  #                 # "-D"
  #                 # "clippy::tests_outside_test_module"
  #                 # "-D"
  #                 # "clippy::todo"
  #                 # "-D"
  #                 # "clippy::try_err"
  #                 # "-D"
  #                 # "clippy::undocumented_unsafe_blocks"
  #                 # "-D"
  #                 # "clippy::unimplemented"
  #                 # "-D"
  #                 # "clippy::unnecessary_safety_comment"
  #                 # "-D"
  #                 # "clippy::unnecessary_safety_doc"
  #                 # "-D"
  #                 # "clippy::unnecessary_self_imports"
  #                 # "-D"
  #                 # "clippy::unneeded_field_pattern"
  #                 # "-D"
  #                 # "clippy::unreachable"
  #                 # "-D"
  #                 # "clippy::unseparated_literal_suffix"
  #                 # "-D"
  #                 # "clippy::unwrap_in_result"
  #                 # "-D"
  #                 # "clippy::unwrap_used"
  #                 # "-D"
  #                 # "clippy::verbose_file_reads"
  #                 # "-D"
  #                 # "clippy::wildcard_enum_match_arm"
  #               ];
  #             };
  #           };
  #         };
  #         # Nix
  #         nil_ls = {
  #           enable = true;
  #         };
  #       };
  #     };
  #     # LSP Lines
  #     lsp-lines = {
  #       enable = true;
  #     };
  #     # Fugitive - Git wrapper
  #     fugitive = {
  #       enable = true;
  #     };
  #     # Airline - Status bar
  #     airline = {
  #       enable = true;
  #     };
  #   };
  # };

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
