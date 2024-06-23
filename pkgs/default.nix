# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
  inputs,
  lib,
  pkgs,
  ...
}: (
# example = pkgs.callPackage ./example { };
  lib.dryFlakes pkgs inputs [
  ]
  //
  (lib.importRest {inherit pkgs lib inputs;}
    ../pkgs)
)
