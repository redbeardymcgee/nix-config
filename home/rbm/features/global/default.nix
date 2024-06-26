{
  config,
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.catppuccin.homeManagerModules.catppuccin

      ./nixpkgs.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    packages = with pkgs; [
      gcc
      pavucontrol
      unzip
      xdg-user-dirs
      # xdg-terminal-emulator
      # xterm-256color
    ];
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      FLAKE = "$HOME/nix-config";
      NODE_PATH = "$HOME/local/lib/node_modules";
      VISUAL = "nvim";
    };
    username = lib.mkDefault "rbm";
  };

  news.display = "show";
  systemd.user.startServices = "sd-switch";
}
