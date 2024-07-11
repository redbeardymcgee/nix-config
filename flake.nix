{
  description = "Nix flake configuration";

  nixConfig = {
    extra-subsituters = [
      "https://yazi.cachix.org"
    ];

    extra-trusted-public-keys = [
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };

  inputs = {
    # catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    stylix.url = "github:danth/stylix";

    yazi.url = "github:sxyazi/yazi";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor =
      lib.genAttrs (import systems)
      (
        system:
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          }
      );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      arcturus = lib.nixosSystem {
        modules = [./hosts/arcturus];

        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "rbm@arcturus" = lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home/rbm/arcturus.nix
        ];
        pkgs = pkgsFor.x86_64-linux;
      };

      "rbm@headmaster" = lib.homeManagerConfiguration {
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home/rbm/headmaster.nix
        ];
        pkgs = pkgsFor.x86_64-linux;
      };
    };
  };
}
