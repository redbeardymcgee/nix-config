{
  pkgs,
  pkgs-unstable,
  config,
  ...
}: {
  home.packages = [pkgs-unstable.gurk-rs];

  sops.templates."gurk" = {
    path = "${config.xdg.configHome}/gurk/gurk.toml";
    file = (pkgs.formats.toml {}).generate "gurk.toml" {
      default_keybindings = true;

      user = {
        name = "Josh";
        phone_number = "${config.sops.placeholder.phone_number}";
      };

      keybindings = {
        normal = {
          "ctrl-n" = "select_channel next";
          "ctrl-p" = "select_channel previous";
          "ctrl-j" = "select_message next entry";
          "ctrl-k" = "select_message previous entry";
        };
      };
    };
  };
}
