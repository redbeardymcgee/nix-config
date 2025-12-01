{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/projects.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "projects.yaml" {
        session_name = "proj  ";

        windows = let
          layout = "fd95,212x55,0,0{105x55,0,0,38,106x55,106,0,39}";
          options = {
            automatic-rename = false;
            remain-on-exit = true;
          };
        in [
          {
            inherit layout options;
            window_name = "nixcats";
            start_directory = "~/src/redbeardymcgee/nixcats";
            # focus = true;
            panes = [
              {
                focus = true;
                shell = "~/.nix-profile/bin/redvim";
              }
            ];
          }

          {
            inherit layout options;
            window_name = "pwf";
            start_directory = "~/src/redbeardymcgee/pwf";
            focus = true;
            panes = [
              {
                focus = true;
                shell = "~/.nix-profile/bin/redvim";
              }
            ];
          }

          {
            inherit layout options;
            window_name = "bitburner";
            start_directory = "~/src/redbeardymcgee/bitburner";
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
