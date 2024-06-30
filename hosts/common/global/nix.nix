{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    package = pkgs.nixVersions.latest;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    # channel.enable = false;

    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      flake-registry = "";
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };
  };
}
