{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./gtk.nix
      ./nixpkgs.nix
      ./stylix.nix
      ./xdg-mimeapps.nix
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

  

  
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  home = {
    stateVersion = lib.mkDefault "24.05";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    username = lib.mkDefault "rbm";
    preferXdgDirectories = true;

    packages = with pkgs; [
      (pkgs.nerdfonts.override {fonts = ["FiraCode"];})
    stateVersion = "24.05";
  #   homeDirectory = "/home/${config.home.username}";
  #   username = "rbm";
  #   preferXdgDirectories = true;
  #
  #   packages = with pkgs; [
  #     (pkgs.nerdfonts.override {fonts = ["FiraCode"];})
  #     gcc
  #     pwvucontrol
  #     unzip
  #   ];
  #
  #   sessionPath = [
  #     "$HOME/.local/lib/node_modules/bin"
  #     "$HOME/.cargo/bin"
  #     "$HOME/.local/bin"
  #   ];
  #
  #   sessionVariables = {
  #     FLAKE = "/mnt/2tb/nix-config";
  #     EDITOR = "redvim";
  #     VISUAL = "redvim";
  #     NODE_PATH = "$HOME/.local/lib/node_modules";
  #     XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    stateVersion = "24.05";
    homeDirectory = "/home/${config.home.username}";
    username = "rbm";
    preferXdgDirectories = true;

    packages = with pkgs; [
      pkgs.nerd-fonts.fira-code
      gcc
      pwvucontrol
      unzip
    ];

    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      FLAKE = "/mnt/2tb/nix-config";
      EDITOR = "redvim";
      VISUAL = "redvim";
      NODE_PATH = "$HOME/.local/lib/node_modules";
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    };
  };

  
  # };
}
