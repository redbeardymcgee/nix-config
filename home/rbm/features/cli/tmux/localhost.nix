{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/localhost.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "localhost.yaml" {
        session_name = "home  ";
        windows = let
          layout = "7723,174x42,0,0{61x42,0,0,6,112x42,62,0,13}";
          options = {
            automatic-rename = false;
            remain-on-exit = true;
          };
        in [
          {
            inherit options;
            window_name = "monitor";
            window_index = 0;
            panes = [{shell = "~/.nix-profile/bin/btm";}];
          }

          {
            inherit options;
            window_name = "main";
            panes = [{shell = "~/.nix-profile/bin/yazi";}];
          }

          {
            inherit layout options;
            window_name = "flake";
            start_directory = "/mnt/2tb/nix-config";
            focus = true;
            panes = [
              "blank"
              {
                shell = "~/.nix-profile/bin/redvim .";
                focus = true;
              }
            ];
          }
        ];
      };
    };
  };
}
