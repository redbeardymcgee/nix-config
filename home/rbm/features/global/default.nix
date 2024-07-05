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
    pointerCursor.enable = true;
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
      fira-code-nerdfont
      gcc
      pavucontrol
      unzip
      xdg-user-dirs
    ];

    preferXdgDirectories = true;
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
