{
  inputs,
  outputs,
  pkgs,
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

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  environment = {
    # TODO: KDE only?
    profileRelativeSessionVariables = {
      QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
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

  users.users = {
    rbm = {
      description = "josh";
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      isNormalUser = true;
      hashedPassword = "$y$j9T$NmHSd/vNRVZnq8XMjboqb.$zDRNKunxvFgsVTb8URv6xOWjj3yCIGKc1YqvcPd8FP0";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}


