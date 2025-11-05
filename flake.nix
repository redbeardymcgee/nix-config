{
  description = "rbm flake";

  nixConfig = {
    extra-substituters = [
      "https://yazi.cachix.org"
    ];

    extra-trusted-public-keys = [
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    # home-manager.url = "github:nix-community/home-manager";
    # lix.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    # ghostty.url = "github:ghostty-org/ghostty";
    # nixcats.url = "git+file:/mnt/2tb/repos/nixcats";
    nixcats.url = "github:redbeardymcgee/nixcats";
    posting.url = "github:justdeeevin/posting/flake";
    stylix.url = "github:danth/stylix/release-25.05";
    # stylix.url = "github:danth/stylix";
    yazi.url = "github:sxyazi/yazi";
    nix-index-database.url = "github:nix-community/nix-index-database";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    nix-index-database,
    home-manager,
    # lix,
    otter-launcher,
    posting,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    commonModules = [
      # lix.nixosModules.default
      stylix.nixosModules.stylix
    ];
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      arcturus = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules =
          commonModules
          ++ [
            ./hosts/arcturus
          ];
      };
      luhman = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules =
          commonModules
          ++ [
            ./hosts/luhman
            nixos-hardware.nixosModules.framework-12-13th-gen-intel
          ];
      };
      toliman = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules =
          commonModules
          ++ [
            ./hosts/toliman
            nixos-hardware.nixosModules.framework-desktop-amd-ai-max-300-series
          ];
      };
    };

    homeConfigurations = let
      commonModules = [
        nix-index-database.homeModules.nix-index
        stylix.homeModules.stylix
        # stylix.homeManagerModules.stylix
        otter-launcher.homeModules.default
        posting.modules.homeManager.default
      ];
    in {
      "rbm@arcturus" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules =
          commonModules
          ++ [
            ./home/rbm/arcturus.nix
          ];
      };

      "rbm@luhman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules =
          commonModules
          ++ [
            ./home/rbm/luhman.nix
          ];
      };
      "rbm@toliman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules =
          commonModules
          ++ [
            ./home/rbm/toliman.nix
          ];
      };
    };
  };
}
