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
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    nixpkgs-stable.url = github:nixos/nixpkgs/nixos-24.05;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kixvim.url = github:redbeardymcgee/kixvim;
    # nur.url = github:nix-community/NUR;
    stylix.url = github:danth/stylix;
    yazi.url = github:sxyazi/yazi;
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
  in {
    inherit lib;

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      arcturus = lib.nixosSystem {
        modules = [./hosts/arcturus];

        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      "rbm@arcturus" = lib.homeManagerConfiguration {
        modules = [./home/rbm/arcturus.nix];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "rbm@headmaster" = lib.homeManagerConfiguration {
        modules = [./home/rbm/headmaster.nix];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
