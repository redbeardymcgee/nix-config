{
  config,
  lib,
  inputs,
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
      inputs.stylix.homeManagerModules.stylix

      ./nixpkgs.nix
      ./xdg-user-dirs.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

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
    homeDirectory = lib.mkDefault "/home/${config.home.username}";

    packages =
      # let
      #   # TODO: Get root of flake or pass it down
      #   replPath = toString ../../../../.;
      #
      #   flake-repl = pkgs.writeShellScriptBin "flake-repl" /* fish */
      #     ''
      #       source /etc/set-environment
      #       nix repl "${replPath}/repl.nix" "$@"
      #     '';
      # in
      with pkgs; [
        (pkgs.nerdfonts.override {fonts = ["FiraCode"];})
        # flake-repl
        gcc
        pavucontrol
        unzip
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
      FLAKE = "/mnt/2tb/nix-config";
      NODE_PATH = "$HOME/local/lib/node_modules";
      VISUAL = "nvim";
    };

    username = lib.mkDefault "rbm";
  };

  news.display = "show";

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-storm.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font";
      };

      sizes = {
        applications = 12;
        terminal = 14;
        desktop = 11;
        popups = 12;
      };
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/5g/wallhaven-5g8xj7.jpg";
      hash = "sha256-sVbkNiOUJvq0T3B/l9AOA6J0ro5s0GVBH1P3g+XGUj4=";
    };

    opacity = {
      terminal = 0.8;
    };
  };

  systemd.user.startServices = "sd-switch";
}
