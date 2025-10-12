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
            window_name = "monitor";
            window_index = 0;
            panes = [
              {shell = "~/.nix-profile/bin/btm";}
            ];
          }

          # {
          #   inherit layout options;
          #   window_name = "poddox";
          #   start_directory = "/mnt/2tb/repos/redbeardymcgee/poddox";
          #   panes = [
          #     {
          #       focus = true;
          #       shell_command = [
          #         "redvim ."
          #       ];
          #     }
          #     # {
          #     #   shell_command = [
          #     #     "npm start"
          #     #   ];
          #     # }
          #   ];
          # }

          {
            inherit layout options;
            window_name = "nixcats";
            start_directory = "~/src/redbeardymcgee/nixcats";
            focus = true;
            panes = [
              {
                focus = true;
                shell_command = [
                  "sleep 1"
                  "redvim ."
                ];
              }
              "blank"
            ];
          }

          {
            inherit layout options;
            window_name = "bitburner";
            start_directory = "~/src/redbeardymcgee/bitburner";
            panes = [
              {
                focus = true;
                shell_command = [
                  "sleep 1"
                  "redvim ."
                ];
              }
              {
                shell_command = [
                  "npm run dev"
                ];
              }
            ];
          }

          # {
          #   inherit layout options;
          #   window_name = "ags";
          #   start_directory = "~/.config/ags";
          #   panes = [
          #     {
          #       focus = true;
          #       shell_command = [
          #         "sleep 1"
          #         "redvim ."
          #       ];
          #     }
          #     "blank"
          #   ];
          # }
        ];
      };
    };
  };
}
