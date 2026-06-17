{pkgs, ...}: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-storm.yaml";
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/qz/wallhaven-qzelxl.jpg";
      hash = "sha256-WVXnEV/SHMZ0idEsLe/gdSM4gS29xsx+r9SnSnI56ts=";
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        # package = pkgs.nerdfonts.override {fonts=["FiraCode"];};
        name = "FiraCode Nerd Font Mono";
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
