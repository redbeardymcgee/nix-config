{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/perseus.yaml" = {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "perseus.yaml" {
        session_name = "srv  ";
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
            panes = [
              {
                shell_command = [
                  "ssh perseus"
                ];
              }
            ];
          }

          {
            inherit layout options;
            # inherit options;
            window_name = "host";
            panes = [
              {
                shell_command = ["ssh perseus"];
              }

              {
                shell_command = ["ssh perseus"];
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
                start_directory = "$XDG_DOCUMENTS_DIR/Notebooks/Perseus";
                shell = "~/.nix-profile/bin/redvim .";
              }

              {
                focus = true;
                shell_command = ["ssh perseus"];
              }
            ];
          }
        ];
      };
    };
  };
}
