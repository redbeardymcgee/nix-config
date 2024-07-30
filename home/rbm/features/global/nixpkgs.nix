# This file should be included when using hm standalone
{
  outputs,
  lib,
  inputs,
  pkgs,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nix = {
    package = lib.mkDefault pkgs.nix;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
      flake-registry = "";
    };
  };

  home.sessionVariables = {
    NIX_PATH = lib.concatStringsSep ":" (lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs);
  };

  nixpkgs = {
    overlays =
      builtins.attrValues outputs.overlays;
    # ++ nur.overlay
    # ++ builtins.attrValues inputs.kixvim.overlays;

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
