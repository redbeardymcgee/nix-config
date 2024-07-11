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
      inputs.stylix.homeManagerModules.stylix

      ./nixpkgs.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

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

  stylix = {
    enable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";

    fonts = {
      monospace = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
      };
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/5g/wallhaven-5g8xj7.jpg";
      hash = "sha256-sVbkNiOUJvq0T3B/l9AOA6J0ro5s0GVBH1P3g+XGUj4=";
    };

    opacity = {
      desktop = 0.85;
      popups = 0.9;
    };

    polarity = "dark";
  };

  systemd.user.startServices = "sd-switch";
}
