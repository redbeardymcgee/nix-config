{
  description = "rbm flake";

  nixConfig = {
    # extra-substituters = [ ];

    # extra-trusted-public-keys = [ ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    fsel.url = "github:Mjoyufull/fsel";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixcats.url = "git+file:///home/rbm/src/redbeardymcgee/nixcats";
    # nixcats.url = "github:redbeardymcgee/nixcats";
    otter-launcher.url = "github:kuokuo123/otter-launcher";
    posting.url = "github:justdeeevin/posting/flake";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.11";

    ## TODO: These want to be removed by using mkYaziPlugin somehow
    augment-command-yazi = {
      url = "github:hankertrix/augment-command.yazi";
      flake = false;
    };
    bunny-yazi = {
      url = "github:stelcodes/bunny.yazi";
      flake = false;
    };
    cd-git-root-yazi = {
      url = "github:ciarandg/cd-git-root.yazi";
      flake = false;
    };
    pref-by-location-yazi = {
      url = "github:boydaihungst/pref-by-location.yazi";
      flake = false;
    };
  };

  outputs = {
    self,
    home-manager,
    nix-index-database,
    nixos-hardware,
    nixpkgs,
    otter-launcher,
    posting,
    sops-nix,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = let
      commonModules = [
        stylix.nixosModules.stylix
        sops-nix.nixosModules.default
      ];
    in {
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
        otter-launcher.homeModules.default
        posting.modules.homeManager.default
        sops-nix.homeModules.default
        stylix.homeModules.stylix
      ];
    in {
      "rbm@arcturus" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64_linux;
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
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
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
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
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
