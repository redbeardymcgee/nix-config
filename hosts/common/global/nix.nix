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
    channel.enable = false;

    # nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    nixPath = let path = toString ./.; in ["repl=${path}/repl.nix" "nixpkgs=${inputs.nixpkgs}"];
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;

    settings = {
      auto-optimise-store = lib.mkDefault true;
      flake-registry = "";
      warn-dirty = false;

      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
