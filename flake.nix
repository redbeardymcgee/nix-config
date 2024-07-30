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
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    kixvim.url = "github:redbeardymcgee/kixvim";
    # nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
    yazi.url = "github:sxyazi/yazi";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
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
      "rbm@arcturus" = home-manager.homeManagerConfiguration {
        modules = [
          ./home/rbm/arcturus.nix

          hyprland.homeManagerModules.default
        ];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      "rbm@headmaster" = home-manager.homeManagerConfiguration {
        modules = [./home/rbm/headmaster.nix];
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
