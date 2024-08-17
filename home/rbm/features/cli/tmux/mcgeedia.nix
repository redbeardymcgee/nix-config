{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/mcgeedia.yaml" = {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "mcgeedia.yaml" {
        session_name = "srv  ";
        shell_command_before = "ssh mcgeedia";
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
            panes = [{shell_command = ["btm"];}];
          }

          {
            inherit options;
            window_name = "host";
            panes = [{shell_command = ["yazi"];}];
          }

          {
            inherit options layout;
            window_name = "docker";
            focus = true;
            panes = [
              "blank"
              {
                shell_command = [
                  "cd /opt/containers"
                  "nvim ."
                ];
              }
            ];
          }

          # {
          #   inherit options layout;
          #   window_name = "cfg";
          #   panes = [
          #     "blank"
          #     {
          #       shell_command = [
          #         "cd ~/nix-config"
          #         "nvim ."
          #       ];
          #     }
          #   ];
          # }
        ];
      };
    };
  };
}
