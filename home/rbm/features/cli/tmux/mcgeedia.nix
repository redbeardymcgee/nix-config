{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/mcgeedia.yaml" = {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "mcgeedia.yaml" {
        session_name = "mcg  ";
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
            panes = [
              {
                shell_command = [
                  "ssh mcgeedia"
                  "btm"
                ];
              }
            ];
          }

          {
            inherit layout options;
            window_name = "notes";
            focus = true;
            panes = [
              {
                shell_command = ["ssh mcgeedia"];
              }

              {
                start_directory = "$XDG_DOCUMENTS_DIR/Notebooks/McGeedia";
                focus = true;
                shell = "~/.nix-profile/bin/redvim .";
              }
            ];
          }

          {
            inherit options;
            window_name = "host";
            panes = [
              {
                shell_command = [
                  "ssh mcgeedia"
                  "yazi"
                ];
              }
            ];
          }

          {
            inherit options layout;
            window_name = "docker";
            panes = [
              {
                shell_command = [
                  "ssh mcgeedia"
                ];
              }

              {
                shell_command = [
                  "ssh mcgeedia"
                  "cd /opt/containers"
                  "nvim ."
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
