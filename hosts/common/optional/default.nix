{ ... }: {
  imports =
    [
      ./gamemode.nix
      ./podman.nix
      ./quietboot.nix
      ./steam-hardware.nix
      ./systemd-boot.nix
    ];
}


