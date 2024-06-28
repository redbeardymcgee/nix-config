{
  pkgs,
  config,
  ...
}: let
  ifExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # home-manager = {
  #   users = {
  #     rbm = import ../../../../home/rbm/arcturus.nix;
  #   };
  # };

  users.users.rbm = {
    description = "josh";
    extraGroups = ifExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "kvm"
      "mysql"
      "network"
      "networkmanager"
      "podman"
      "video"
      "wheel"
      "wireshark"
    ];
    hashedPassword = "$y$j9T$NmHSd/vNRVZnq8XMjboqb.$zDRNKunxvFgsVTb8URv6xOWjj3yCIGKc1YqvcPd8FP0";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      #
      # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/rbm/ssh.pub);
    ];
    packages = [pkgs.home-manager];
    shell = pkgs.bash;
  };
}
