{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/localhost.yaml" = let
      opts = {
        automatic-rename = false;
        remain-on-exit = true;
      };
    in {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "localhost.yaml" {
        session_name = "localhost";
        windows = [
          {
            window_name = "main";
            options = opts;
            panes = [{shell = "~/.nix-profile/bin/yazi";}];
          }
          {
            window_name = "cfg";
            start_directory = "~/nix-config";
            focus = true;
            options = opts;
            panes = [{shell = "~/.nix-profile/bin/nvim .";}];
          }
          {
            window_name = "monitor";
            window_index = 0;
            options = opts;
            panes = [{shell = "~/.nix-profile/bin/btm";}];
          }
        ];
      };
    };
  };
}
