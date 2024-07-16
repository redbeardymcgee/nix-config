{pkgs, ...}: {
  services.kmscon = {
    # FIXME:
    # … while calling the 'concatStringsSep' builtin
    #   at /nix/store/j4jzjbr302cw5bl0n3pch5j9bh5qwmaj-source/nixos/modules/services/ttys/kmscon.nix:108:10:
    #   107|         fonts = optional (cfg.fonts != null) "font-name=${lib.concatMapStringsSep ", " (f: f.name) cfg.fonts}";
    #   108|       in lib.concatStringsSep "\n" (xkb ++ render ++ fonts);
    #       |          ^
    #   109|
    # error: attempt to call something which is not a function but a list: [ ]
    # at /nix/store/j4jzjbr302cw5bl0n3pch5j9bh5qwmaj-source/nixos/modules/services/ttys/kmscon.nix:100:15:
    #     99|       let
    #   100|         xkb = optionals cfg.useXkbConfig
    #       |               ^
    #   101|           lib.mapAttrsToList (n: v: "xkb-${n}=${v}") (

    enable = false;
    extraConfig = ''
      "font-size=10"
    '';
    fonts = [
      {
        name = "FiraCode Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
      }
    ];
    hwRender = true;
    useXkbConfig = true;
  };
}
