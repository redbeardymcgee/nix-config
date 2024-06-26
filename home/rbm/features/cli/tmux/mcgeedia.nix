{ pkgs, lib, ... }: {
 xdg.configFile = {
    "tmuxp/mcgeedia.json" = {
      enable = true;
      text = lib.generators.toJSON { } {
        session_name = "mcgeedia";
        shell_command_before = "ssh mcgeedia";
        windows = [
          {
            window_name = "main";
            focus = true;
            options = {
              remain-on-exit = true;
            };
            panes = [
              {
                shell_command = [
                  "yy"
                ];
              }
            ];
          }
          {
            window_name = "cfg";
            options = {
              remain-on-exit = true;
            };
            panes = [
              {
                shell_command = [
                  "cd ~/nix-config"
                  "${pkgs.neovim}/bin/nvim ."
                ];
              }
            ];
          }
          {
            window_name = "docker";
            panes = [
              {
                shell_command = [
                  "cd /opt/containers"
                  "${pkgs.neovim}/bin/nvim ."
                ];
              }
            ];
          }
          {
            window_name = "cfg";
            window_index = "0";
            options = {
              remain-on-exit = true;
            };
            panes = [
              {
                shell = "${pkgs.bottom}/bin/btm";
              }
            ];
          }
        ];
      };
    };
  };
}
