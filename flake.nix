{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # No `inputs.nixpkgs.follows` here on purpose: the nightly package must be
    # built against the overlay's own pinned nixpkgs so its store path matches
    # what nix-community.cachix.org has prebuilt (see nix.settings in the
    # NixOS configurations). Following our nixpkgs forces a local compile.
    neovimNightlyOverlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-config = {
      url = "github:DomenicoDErasmo/Neovim-Config";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    neovimNightlyOverlay,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./modules/nixos/computers/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
          hyprland.nixosModules.default
          neovimNightlyOverlay.nixosModules
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./modules/nixos/computers/configuration.nix
          ./hosts/laptop/hardware-configuration.nix
          hyprland.nixosModules.default
          neovimNightlyOverlay.nixosModules
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          inputs.nixos-wsl.nixosModules.default
          ./modules/nixos/wsl/configuration.nix
          neovimNightlyOverlay.nixosModules
        ];
      };
    };

    homeConfigurations = {
      computers = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux // {config = {allowUnfree = true;};};
        modules = [
          ./modules/home-manager/computers/home.nix
        ];
        extraSpecialArgs = {inherit inputs;};
      };
      wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux // {config = {allowUnfree = true;};};
        modules = [
          ./modules/home-manager/wsl/home.nix
        ];
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}
