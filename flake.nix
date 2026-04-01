{
  description = "rbm flake";

  nixConfig = {
    # extra-substituters = [ ];

    # extra-trusted-public-keys = [ ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fsel = {
      url = "github:Mjoyufull/fsel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcats = {
      url = "git+file:///home/rbm/src/redbeardymcgee/nixcats";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixcats.url = "github:redbeardymcgee/nixcats";
    otter-launcher = {
      url = "github:kuokuo123/otter-launcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oxicord = {
      url = "github:linuxmobile/oxicord";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    posting = {
      url = "github:justdeeevin/posting/flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.11";
  };

  outputs = {
    self,
    dms,
    dms-plugin-registry,
    home-manager,
    niri,
    nix-index-database,
    nixos-hardware,
    nixpkgs,
    nixpkgs-unstable,
    otter-launcher,
    posting,
    sops-nix,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
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
          inherit inputs outputs pkgs-unstable;
        };
        modules =
          commonModules
          ++ [
            ./hosts/arcturus
            dms.nixosModules.greeter
          ];
      };
      luhman = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs pkgs-unstable;
        };
        modules =
          commonModules
          ++ [
            nixos-hardware.nixosModules.framework-12-13th-gen-intel
            ./hosts/luhman
          ];
      };
      toliman = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs pkgs-unstable;
        };
        modules =
          commonModules
          ++ [
            nixos-hardware.nixosModules.framework-desktop-amd-ai-max-300-series
            niri.nixosModules.niri
            dms.nixosModules.dank-material-shell
            dms.nixosModules.greeter
            ./hosts/toliman
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
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs pkgs-unstable;
        };
        modules =
          commonModules
          ++ [
            dms.homeModules.dank-material-shell
            dms.homeModules.niri
            dms-plugin-registry.modules.default
            niri.homeModules.niri
            niri.homeModules.stylix
            ./home/rbm/arcturus.nix
          ];
      };

      "rbm@luhman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs pkgs-unstable;
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
          inherit inputs outputs pkgs-unstable;
        };
        modules =
          commonModules
          ++ [
            dms.homeModules.dank-material-shell
            dms.homeModules.niri
            dms-plugin-registry.modules.default
            niri.homeModules.niri
            niri.homeModules.stylix
            ./home/rbm/toliman.nix
          ];
      };
    };
  };
}
