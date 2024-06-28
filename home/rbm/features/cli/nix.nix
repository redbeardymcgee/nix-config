{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      warn-dirty = false;
    };
  };
}
