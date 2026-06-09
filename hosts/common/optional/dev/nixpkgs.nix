{lib, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "jocalsend"
      "steam"
      "steam-unwrapped"
      "via"
    ];
}
