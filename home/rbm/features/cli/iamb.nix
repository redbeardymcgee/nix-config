{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.iamb.packages.${pkgs.system}.default
  ];

  xdg.configFile."iamb/config.toml" = {
    enable = true;

    source = (pkgs.formats.toml {}).generate "config.toml" {
      profiles.user = {
        user_id = "@redbeardy_mcgee:matrix.org";
        layout = {
          style = "restore";
        };
      };
      settings = {
        image_preview = {
          protocol = {
            type = "kitty";
          };
        };
        typing_notice_send = false;
      };
    };
  };
}
