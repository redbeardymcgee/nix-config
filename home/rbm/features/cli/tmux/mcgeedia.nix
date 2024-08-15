{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/mcgeedia.yaml" = let
      opts = {
        automatic-rename = false;
        remain-on-exit = true;
      };
    in {
      enable = true;
      source = (pkgs.formats.yaml {}).generate "mcgeedia.yaml" {
        session_name = "srv  ";
        # shell_command_before = "ssh mcgeedia";
        windows = [
          {
            window_name = "host";
            options = opts;
            # panes = [{shell_command = ["yazi"];}];
            panes = [{shell_command = ["ssh mcgeedia"];}];
          }
          {
            window_name = "vm";
            options = opts;
            panes = [{shell_command = ["ssh stopgap"];}];
          }
          # {
          #   window_name = "cfg";
          #   options = opts;
          #   panes = [
          #     {
          #       shell_command = [
          #         "cd ~/nix-config"
          #         "nvim ."
          #       ];
          #     }
          #   ];
          # }
          # {
          #   window_name = "docker";
          #   focus = true;
          #   options = opts;
          #   panes = [
          #     {
          #       shell_command = [
          #         "cd /opt/containers"
          #         "nvim ."
          #       ];
          #     }
          #   ];
          # }
          # {
          #   window_name = "monitor";
          #   window_index = 0;
          #   options = opts;
          #   panes = [{shell = ["~/.nix-profile/bin/btm"];}];
          # }
        ];
      };
    };
  };
}
