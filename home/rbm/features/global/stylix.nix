{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };

      sizes = {
        applications = 13;
        terminal = 11;
        desktop = 14;
        popups = 14;
      };
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/qz/wallhaven-qzelxl.jpg";
      hash = "sha256-WVXnEV/SHMZ0idEsLe/gdSM4gS29xsx+r9SnSnI56ts=";
    };

    opacity = {
      terminal = 0.95;
    };
  };
}
