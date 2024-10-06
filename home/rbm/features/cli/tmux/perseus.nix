{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/perseus.yaml" = {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "perseus.yaml" {
        session_name = "srv  ";
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
                  "ssh perseus"
                ];
              }
            ];
          }

          {
            inherit layout options;
            window_name = "host";
            panes = [
              {
                shell_command = ["ssh perseus"];
              }

              {
                focus = true;
                shell_command = ["ssh perseus"];
              }
            ];
          }

          {
            inherit layout options;
            window_name = "notes";
            panes = [
              {
                shell_command = ["ssh perseus"];
              }

              {
                start_directory = "$XDG_DOCUMENTS_DIR/Notebooks/Perseus";
                focus = true;
                shell = "~/.nix-profile/bin/redvim .";
              }
            ];
          }
        ];
      };
    };
  };
}
