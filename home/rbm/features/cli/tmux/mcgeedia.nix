{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/mcgeedia.yaml" = {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "mcgeedia.yaml" {
        session_name = "mcg  ";
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
            inherit layout options;
            # inherit options;
            window_name = "notes";
            focus = true;
            panes = [
              {
                start_directory = "$XDG_DOCUMENTS_DIR/Notebooks/McGeedia";
                shell_command = [
                  "sleep 1"
                  "redvim ."
                ];
              }

              {
                focus = true;
                shell_command = ["ssh mcgeedia"];
              }
            ];
          }

          {
            inherit options layout;
            # inherit options;
            window_name = "docker";
            panes = [
              {
                shell_command = [
                  "ssh mcgeedia"
                  "cd /opt/containers"
                  "nvim ."
                ];
              }

              {
                shell_command = [
                  "ssh mcgeedia"
                  "cd /opt/containers"
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
