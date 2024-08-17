{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/projects.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "projects.yaml" {
        session_name = "proj  ";

        windows = let
          layout = "7723,174x42,0,0{61x42,0,0,6,112x42,62,0,13}";
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

          {
            inherit layout options;
            window_name = "bookworm";
            start_directory = "/mnt/2tb/repos/justaguylinux/bookworm-scripts";
            panes = [
              "blank"
              {shell_command = ["nvim ."];}
            ];
          }

          {
            inherit layout options;
            window_name = "sway";
            start_directory = "/mnt/2tb/repos/justaguylinux/sway";
            panes = [
              "blank"
              {shell_command = ["nvim ."];}
            ];
          }

          {
            inherit layout options;
            window_name = "kixvim";
            start_directory = "/mnt/2tb/repos/kixvim";
            panes = [
              "blank"
              {shell_command = ["nvim ."];}
            ];
          }

          {
            inherit layout options;
            focus = true;
            window_name = "bitburner";
            start_directory = "/mnt/2tb/repos/bitburner-scripts";
            panes = [
              {shell_command = ["npm start"];}
              {
                focus = true;
                shell_command = ["nvim ."];
              }
            ];
          }
        ];
      };
    };
  };
}
