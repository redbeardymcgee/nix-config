{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.gurk-rs];

  xdg.configFile."gurk/gurk.toml" = let
    cfg = config.sops.templates.gurk.path;
    cfgSource = config.lib.file.mkOutOfStoreSymlink cfg;
  in {
    enable = true;

    source = cfgSource;
  };

  sops.templates."gurk" = {
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
