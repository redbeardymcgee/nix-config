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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-utils = {
      url = "github:numtide/flake-utils";
      # inputs.systems.follows = "systems";
    };
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    # kixvim.url = "github:redbeardymcgee/kixvim";
    # nur.url = "github:nix-community/NUR";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lix,
    # nur,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      arcturus = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/arcturus

          lix.nixosModules.default
          stylix.nixosModules.stylix
        ];

        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      "rbm@arcturus" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home/rbm/arcturus.nix
        ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "rbm@headmaster" = home-manager.lib.homeManagerConfiguration {
        modules = [./home/rbm/headmaster.nix];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
