{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.ghostty.packages.x86_64-linux.default
  ];

  xdg.configFile."ghostty/config" = {
    enable = true;

    source = pkgs.writeText "ghostty-config" ''
    font-family = FiraCode Nerd Font
    window-decoration = false
    gtk-titlebar = false
  '';
  };
}
