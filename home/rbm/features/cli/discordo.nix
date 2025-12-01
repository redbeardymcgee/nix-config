{pkgs, ...}: {
  ## TODO: Upstream simple home-manager module?
  ## The dev retired their flake support with included module
  home.packages = [pkgs.discordo];

  xdg.configFile."discordo/config.toml" = {
    enable = true;

    source = (pkgs.formats.toml {}).generate "discordo/config.toml" {
      notifications = {
        sound = {
          enabled = false;
        };
      };
    };
  };
}
