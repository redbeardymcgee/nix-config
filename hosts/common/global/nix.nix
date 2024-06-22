{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    channel.enable = false;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +5";
    };
    package = pkgs.nixVersions.latest;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      flake-registry = "";
      warn-dirty = false;
    };
    trusted-users = [
      "root"
      "@wheel"
    ];
  };
}
