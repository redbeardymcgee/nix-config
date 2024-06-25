# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' iirectory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    yazi = prev.yazi.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "sxyazi";
          repo = "yazi";
          rev = "f1cf136df435bc07ca28e4c45af36ede0903af5f";
          hash = "sha256-UCzZvuqguZNhOSOB96sfthPSsm71RRpj551VNVFZhws=";
        };
      });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
