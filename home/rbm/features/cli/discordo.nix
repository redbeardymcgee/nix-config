{pkgs, ...}: {
  ## TODO: Wait for upstream flake to be fixed
  home.packages = [pkgs.discordo];
  xdg.configFile."discordo/config.toml" = {
    enable = true;

    source = (pkgs.formats.toml {}).generate "discordo/config.toml" {
      notifications = {
        sound = {
          enabled = false;
        };
      };
      theme = {
        guilds_tree = {
          auto_expand_folders = false;
        };
      };
    };
  };
  # programs.discordo = {
  #   enable = true;
  #
  #   settings = {
  #     notifications = {
  #       sound = {
  #         enabled = false;
  #       };
  #     };
  #     theme = {
  #       guilds_tree = {
  #         auto_expand_folders = false;
  #       };
  #     };
  #   };
  # };
}
