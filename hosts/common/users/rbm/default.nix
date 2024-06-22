{
  pkgs,
  config,
  # lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  home-manager.users.rbm = import ../../../../home/rbm/${config.networking.hostName}.nix;

  users.users.rbm = {
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "kvm"
      "mysql"
      "network"
      "podman"
      "video"
      "wheel"
      "wireshark"
    ];
    isNormalUser = true;
    packages = [pkgs.home-manager];
    shell = pkgs.bash;

    # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/rbm/ssh.pub);
    # hashedPasswordFile = config.sops.secrets.rbm-password.path;
  };

  # sops.secrets.rbm-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };
}
