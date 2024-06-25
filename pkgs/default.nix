# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  # xdg-desktop-portal-luminous = pkgs.callPackage ./xdg-desktop-portal-luminous.nix { };
}
# {
#   inputs,
#   lib,
#   pkgs,
#   ...
# }: (
#   lib.dryFlakes pkgs inputs [
#   ]
#   //
#   (lib.importRest {inherit pkgs lib inputs;}
#     ../pkgs)
# )
