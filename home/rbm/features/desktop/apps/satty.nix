{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    grim
    satty
    slurp
  ];

  wayland.windowManager.river.settings.map.normal = {
    "None Print" = ''spawn 'grim -g "$(slurp -o -r -c "#ff0000ff")" - | satty --filename -' '';
  };

  # TODO: 25.11 should have a module available
  xdg.configFile."satty/config.toml" = {
    enable = true;
    source = (pkgs.formats.toml {}).generate "config.toml" {
      general = {
        fullscreen = true;
        early-exit = true;
        initial-tool = "crop";
        output-filename = "${config.home.homeDirectory}/Pictures/Screenshots/satty-%Y-%m-%d_%H:%M:%S.png";
        save-after-copy = true;
      };
    };
  };
}
