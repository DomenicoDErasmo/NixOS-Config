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
    neovimNightlyOverlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
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
