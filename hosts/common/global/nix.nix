{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    # package = lib.mkDefault pkgs.nixVersions.latest;
    # TODO: Make sure this works with channel disabled from fresh install
    #       It may be necessary to add something to the registry
    #       ❯ nix run 'nixpkgs#nix-index' --extra-experimental-features 'nix-command flakes'
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;

    nixPath = let
      path = toString ../../../.;
    in
      lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs
      ++ ["repl=${path}/repl.nix" "nixpkgs=${inputs.nixpkgs}"];

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
