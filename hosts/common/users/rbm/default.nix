{
  pkgs,
  config,
  ...
}: let
  ifExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.rbm = {
    isNormalUser = true;
    description = "josh";
    hashedPassword = "$6$eiZ2Cxt3CKj4cZ21$VS4lcMg21wOc1XTmf42eQK993hhqA2SVh/cAKKJCUkJCdglgrFJwU1.XL4cKVd1MQpyMe3oJoUKPIuGO2RU.l/";
    shell = pkgs.bash;

    extraGroups = ifExist [
      "audio"
      "docker"
      "gamemode"
      "libvirtd"
      "kvm"
      "mysql"
      "network"
      "podman"
      "video"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      #
      # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/rbm/ssh.pub);
    ];
  };
}
