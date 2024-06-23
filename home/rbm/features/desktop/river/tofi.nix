{ pkgs, ... }:
let
  nerdfont = "${pkgs.nerdfonts}";
in {
  programs.tofi = {
    enable = true;
    settings = {
      ascii-input = true;
      auto-accept-single = false;
      fuzzy-match = true;
      matching-algorithm = "fuzzy";

      font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/FiraCodeNerdFontMono-Regular.ttf";
      font-size = 16;
      hide-cursor = true;
      hint-font = false;
      outline-width = 0;
      border-width = 0;
      padding-left = "4%";
      padding-top = "2%";
      padding-right = 0;
      padding-bottom = 0;

      width = "45%";
      height = "40%";
    };
  };
}
