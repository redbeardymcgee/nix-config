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
            window_name = "notes";
            panes = [
              {
                start_directory = "$XDG_DOCUMENTS_DIR/Notebooks/McGeedia";
                shell = "~/.nix-profile/bin/redvim";
              }
            ];
          }

          {
            inherit options layout;
            window_name = "docker";
            focus = true;
            panes = [
              {
                shell_command = [
                  "ssh mcgeedia"
                  "cd /opt/containers"
                  "nvim ."
                ];
              }

              {
                focus = true;
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
