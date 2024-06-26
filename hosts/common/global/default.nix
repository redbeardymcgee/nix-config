{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
      inputs.home-manager.nixosModules.home-manager
      ./locale.nix
      ./nix-ld.nix
      ./nix.nix
      ./qemu.nix
      ./sudo.nix
      ./systemd-initrd.nix

      ../services/greetd.nix
      ../services/kanata.nix
      ../services/libinput.nix
      ../services/openssh.nix
      ../services/pipewire.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  environment = {
    systemPackages = with pkgs; [
      libnotify
    ];
    # TODO: KDE only?
    profileRelativeSessionVariables = {
      QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
    };
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
  };

  services = {
    avahi.enable = true;
    blueman.enable = true;
  };

  system = {
    autoUpgrade.enable = false;
    stateVersion = "24.05"; # Did you read the comment?
  };
}


