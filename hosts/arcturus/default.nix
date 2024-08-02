{pkgs, ...}: {
  imports = [
    ./hw.nix
    ./nvidia.nix
    ./intel.nix

    ../common/global

    ../common/optional/gamemode.nix
    ../common/optional/kmscon.nix
    ../common/optional/podman.nix
    ../common/optional/quietboot.nix
    ../common/optional/steam.nix
    ../common/optional/stylix.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/systemd-networkd.nix

    ../common/services/udisks2.nix

    ../common/users
  ];

  fileSystems = {
    "/2tb" = {
      device = "/dev/disk/by-uuid/0b8b0c5d-8363-43a5-8a3a-a71fa3c7d953";
      fsType = "ext4";
      mountPoint = "/mnt/2tb";

      options = [
        "users"
        "exec"
        "nofail"
      ];
    };
  };

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  hardware = {
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;

      configFile = pkgs.writeText "default.pa" ''
        load-module module-bluetooth-policy
        load-module module-bluetooth-discover
      '';

      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
  };

  networking = {
    domain = "home";
    hostName = "arcturus";
  };

  security.pam.services.swaylock.text = "auth include login";
}
