{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-storm.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCode Nerd Font";
      };

      sizes = {
        applications = 12;
        terminal = 10;
        desktop = 14;
        popups = 13;
      };
    };
  };
}
