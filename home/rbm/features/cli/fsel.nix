{pkgs, ...}: {
  home.packages = [pkgs.fsel];

  xdg.configFile."fsel/config.toml" = {
    enable = true;

    source = (pkgs.formats.toml {}).generate "config.toml" {
      terminal_launcher = "ghostty -e";
    };
  };
}
