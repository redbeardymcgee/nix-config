{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/yazi-plugins.yaml" = let
      opts = {
        automatic-rename = false;
        remain-on-exit = true;
      };
    in {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "yazi-plugins.yaml" {
        session_name = "yazi-plugins  ";
        windows = [
          {
            window_name = "main";
            start_directory = "/mnt/2tb/repos/yazi-plugins/";
            options = opts;
            panes = [{shell_command = ["nvim ."];}];
          }
        ];
      };
    };
  };
}
