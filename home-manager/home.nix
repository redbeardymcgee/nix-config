{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./features/cli
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home = {
    # FIXME: stinky warning suppression
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/var/home/josh";
    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER="sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT="-c";
      NODE_PATH = "~/.local/lib/node_modules";
      VISUAL = "nvim";
    };
    stateVersion = "24.05";
    username = "josh";
  };

  programs.home-manager.enable = true;

  services = {
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "weekly";
    };
    ssh-agent.enable = true;
  };

  systemd.user = {
    startServices = "sd-switch";
  };

  targets.genericLinux.enable = true;

  xdg = {
    enable = true;
    # mimeApps.enable = true;
    # portal.enable = true;
  };
}
