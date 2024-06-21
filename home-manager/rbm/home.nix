{
  config,
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../features
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home = {
    homeDirectory = "/home/rbm";
    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      NODE_PATH = "~/.local/lib/node_modules";
      VISUAL = "nvim";
    };
    stateVersion = "24.05";
    username = "rbm";
  };

  news.display = "silent";

  home.packages = with pkgs; [
    gcc
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    unzip
  ];

  programs.home-manager.enable = true;

  services = {
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "weekly";
    };
    remmina.enable = true;
    ssh-agent.enable = true;
  };

  systemd.user = {
    startServices = "sd-switch";
  };

  targets.genericLinux.enable = true;

  xdg = {
    mimeApps.enable = true;
    portal.enable = true;
  };
}
