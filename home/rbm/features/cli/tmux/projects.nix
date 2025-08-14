{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/projects.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "projects.yaml" {
        session_name = "proj  ";

        windows = let
          # layout = "7723,174x42,0,0{61x42,0,0,6,112x42,62,0,13}";
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
          #   window_name = "bookworm";
          #   start_directory = "/mnt/2tb/repos/justaguylinux/bookworm-scripts";
          #   panes = [
          #     {
          #       focus = true;
          #       shell_command = ["redvim ."];
          #     }
          #     "blank"
          #   ];
          # }

          {
            inherit layout options;
            window_name = "poddox";
            start_directory = "/mnt/2tb/repos/redbeardymcgee/poddox";
            panes = [
              {
                focus = true;
                shell_command = [
                  "redvim ."
                ];
              }
              # {
              #   shell_command = [
              #     "npm start"
              #   ];
              # }
            ];
          }

          {
            inherit layout options;
            window_name = "nixcats";
            start_directory = "/mnt/2tb/repos/nixcats";
            focus = true;
            panes = [
              {
                focus = true;
                shell_command = ["redvim ."];
              }
              "blank"
            ];
          }

          {
            inherit layout options;
            window_name = "bitburner";
            start_directory = "/mnt/2tb/repos/bitburner-scripts";
            panes = [
              {
                focus = true;
                shell_command = ["redvim ."];
              }
              {shell_command = ["npm start"];}
            ];
          }

          {
            inherit layout options;
            window_name = "ags";
            start_directory = "~/.config/ags";
            panes = [
              {
                focus = true;
                shell_command = ["redvim ."];
              }
              "blank"

            ];
          }
          {
            inherit layout options;
            window_name = "wolf";
            start_directory = "/mnt/2tb/repos/wolf";
            panes = [
              {
                focus = true;
                shell_command = ["redvim ."];
              }
              "blank"
            ];
          }
        ];
      };
    };
  };
}
