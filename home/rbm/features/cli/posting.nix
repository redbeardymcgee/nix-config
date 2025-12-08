{
  programs.posting = {
    enable = true;
    # package = inputs.posting.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      animation = "full";
      theme = "oxocarbon";
    };
    themes = [
      {
        name = "oxocarbon";
        # base08
        primary = "#3ddbd9";
        # base0F
        secondary = "#82cfff";
        # base0C
        accent = "#ff7eb6";
        # base00
        background = "#161616";
        # base02
        surface = "#393939";
        # base0A
        error = "#ee5396";
        # base0D
        success = "#42be65";
        # base0E
        warning = "#be95ff";
      }
    ];
  };
}
