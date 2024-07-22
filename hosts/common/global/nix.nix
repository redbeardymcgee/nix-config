{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    # TODO: Switch back to regular nix if `lix` goes sour
    # package = lib.mkDefault pkgs.nixVersions.latest;

    # NOTE: Useful tools like having channels and I like having tools that work
    #       without switching to my browser for documentation every time
    channel.enable = true;
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
