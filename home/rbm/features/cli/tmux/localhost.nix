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
        session_name = "home  ";
        windows = [
          {
            window_name = "main";
            options = opts;
            panes = [{shell = "~/.nix-profile/bin/yazi";}];
          }
          {
            window_name = "flake";
            start_directory = "/mnt/2tb/nix-config";
            focus = true;
            layout = "7723,174x42,0,0{61x42,0,0,6,112x42,62,0,13}";
            options = opts;
            panes = [
              "blank"
              {
                shell = "~/.nix-profile/bin/nvim .";
                focus = true;
              }
            ];
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
