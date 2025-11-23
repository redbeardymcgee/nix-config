{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/localhost.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "localhost.yaml" {
        session_name = "home  ";
        windows = let
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
            window_name = "flake";
            start_directory = "~/src/redbeardymcgee/nix-config";
            focus = true;
            panes = [
              {
                focus = true;
                shell = "~/.nix-profile/bin/redvim";
              }
            ];
          }
        ];
      };
    };
  };
}
