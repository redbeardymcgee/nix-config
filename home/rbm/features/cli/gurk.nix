{pkgs, ...}: {
  home.packages = [pkgs.gurk-rs];

  xdg.configFile."gurk/gurk.toml" = {
    enable = true;

    source = (pkgs.formats.toml {}).generate "gurk.toml" {
      default_bindings = true;
    };
  };
}
