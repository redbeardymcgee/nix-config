{
  description = "rbm flake";

  nixConfig = {
    extra-substituters = ["https://niri.cachix.org" "https://cache.numtide.com"];
    extra-trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # systems.url = "github:nix-systems/default-linux";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fsel = {
      url = "github:Mjoyufull/fsel";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixcats = {
    #   url = "git+file:///home/rbm/src/redbeardymcgee/nixcats";
    # };
    # nixcats.url = "github:redbeardymcgee/nixcats";
    redvim = {
      url = "git+https://git.mcgee.red/redbeardymcgee/nvim";
    };
    otter-launcher = {
      url = "github:kuokuo123/otter-launcher";
    };
    oxicord = {
      url = "github:linuxmobile/oxicord";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
    stylix.url = "github:danth/stylix/release-26.05";
    tmux-which-key = {
      url = "github:alexwforsythe/tmux-which-key";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-nerd-font-window-name = {
      url = "github:joshmedeski/tmux-nerd-font-window-name";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tmux-power-zoom = {
      url = "github:jaclu/tmux-power-zoom";
      flake = false;
    };
    tmux-matryoshka = {
      url = "github:niqodea/tmux-matryoshka";
      flake = false;
    };
    tmux-fzf-links = {
      url = "github:alberti42/tmux-fzf-links";
      flake = false;
    };
    tmux-smart-splits = {
      url = "github:mrjones2014/smart-splits.nvim";
      flake = false;
    };
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
          inherit inputs outputs pkgs-unstable niri;
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
