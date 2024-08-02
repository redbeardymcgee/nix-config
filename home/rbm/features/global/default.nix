{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: let
  # nur-no-pkgs = import inputs.nur {
  #   nurpkgs = import nixpkgs { system = "x86_64-linux"; };
  # };
in {
  imports =
    [
      ./nixpkgs.nix
      ./xdg-user-dirs.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  news.display = "show";
  systemd.user.startServices = "sd-switch";

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home = {
    stateVersion = lib.mkDefault "24.05";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    username = lib.mkDefault "rbm";
    preferXdgDirectories = true;

    packages = with pkgs; [
      (pkgs.nerdfonts.override {fonts = ["FiraCode"];})
      gcc
      pavucontrol
      unzip
    ];

    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      # saves `--flake /path/`
      FLAKE = "/mnt/2tb/nix-config";

      EDITOR = "nvim";
      VISUAL = "nvim";

      NODE_PATH = "$HOME/local/lib/node_modules";

      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-storm.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font";
      };

      sizes = {
        applications = 12;
        terminal = 10;
        desktop = 14;
        popups = 13;
      };
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/5g/wallhaven-5g8xj7.jpg";
      hash = "sha256-sVbkNiOUJvq0T3B/l9AOA6J0ro5s0GVBH1P3g+XGUj4=";
    };

    opacity = {
      terminal = 0.95;
    };
  };

  xdg.desktopEntries."Steam-Nvidia" = {
    name = "steam-fixed";
    exec = "steam %U";
    icon = "steam";
  };
}
