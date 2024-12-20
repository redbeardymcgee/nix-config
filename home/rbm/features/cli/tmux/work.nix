{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/work.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "work.yaml" {
        session_name = "work 󱚾";
        windows = let
          # layout = "7723,174x42,0,0{61x42,0,0,6,112x42,62,0,13}";
          layout = "fd95,212x55,0,0{105x55,0,0,38,106x55,106,0,39}";
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
            inherit layout options;
            # inherit options;
            window_name = "alta";
            start_directory = "/mnt/2tb/alta";
            focus = true;
            panes = [
              {
                shell = "~/.nix-profile/bin/redvim .";
                focus = true;
              }
              "blank"
            ];
          }
        ];
      };
    };
  };
}
