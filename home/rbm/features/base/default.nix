{
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./gtk.nix
      ./nixpkgs.nix
      ./session.nix
      ./sops.nix
      ./stylix.nix
      ./xdg.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  home.packages = with pkgs; [
    brogue-ce
    cataclysm-dda-git
    crawlTiles
    infra-arcana
    nerd-fonts.fira-code
    nerd-fonts.inconsolata-lgc
    nerd-fonts.iosevka-term-slab
    nerd-fonts.victor-mono
    dejavu_fonts
    gcc
    pwvucontrol
    unzip
  ];
}
