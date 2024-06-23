# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
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
