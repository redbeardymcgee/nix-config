{
  inputs,
  pkgs,
  ...
}: let
  fsel = inputs.fsel.packages.${pkgs.system}.default;
in {
  home.packages = [fsel];

  xdg.configFile."fsel/config.toml" = {
    enable = true;

    source = (pkgs.formats.toml {}).generate "config.toml" {
      terminal_launcher = "ghostty -e";
    };
  };

  # wayland.windowManager.river.settings.map.normal = {
  #   "None Menu" = "spawn 'ghostty --class=ghostty.fsel -e fsel'";
  # };
}
