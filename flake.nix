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
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
    };
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    # ghostty.url = "github:ghostty-org/ghostty";
    nixcats.url = "git+file:/mnt/2tb/repos/nixcats";
    # nixcats.url = "github:redbeardymcgee/nixcats";
    posting.url = "github:justdeeevin/posting/flake";
    stylix.url = "github:danth/stylix/release-24.11";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    lix,
    posting,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      arcturus = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/arcturus
          lix.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };
      # luhman = nixpkgs.lib.nixosSystem {
      #   specialArgs = {
      #     inherit inputs outputs;
      #   };
      #   modules = [
      #     ./hosts/luhman
      #     lix.nixosModules.default
      #     stylix.nixosModules.stylix
      #     nixos-hardware.nixosModules.framework-12-13th-gen-intel
      #   ];
      # };
    };

    homeConfigurations = {
      "rbm@arcturus" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home/rbm/arcturus.nix
          # stylix.homeModules.stylix
          stylix.homeManagerModules.stylix
          posting.modules.homeManager.default
        ];
      };

      "rbm@luhman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home/rbm/luhman.nix
          # stylix.homeModules.stylix
          stylix.homeManagerModules.stylix
          posting.modules.homeManager.default
        ];
      };

      "rbm@headmaster" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./home/rbm/headmaster.nix
        ];
      };
    };
  };
}
