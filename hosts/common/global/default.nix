{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager

      ./greetd.nix
      ./kanata.nix
      ./locale.nix
      ./nix-ld.nix
      ./nix.nix
      ./openssh.nix
      ./pipewire.nix
      ./qemu.nix
      ./systemd-initrd.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  environment = {
    # TODO: KDE only?
    profileRelativeSessionVariables = {
      QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
    };
  };

  home-manager = {
    extraSpecialArgs = {
        inherit inputs outputs;
      };
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.dconf.enable = true;

  services = {
    avahi.enable = true;
    blueman.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  system = {
    autoUpgrade.enable = true;
    stateVersion = "24.05"; # Did you read the comment?
  };
}


