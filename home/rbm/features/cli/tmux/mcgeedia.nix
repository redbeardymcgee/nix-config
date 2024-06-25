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
            start_directory = "~/nix-config";
            panes = [
              {
                shell_command = [
                  "${pkgs.neovim}/bin/nvim ."
                ];
              }
            ];
          }
          {
            window_name = "docker";
            start_directory = "/opt/containers";
            panes = [
              {
                shell_command = [
                  "${pkgs.neovim}/bin/nvim ."
                ];
              }
            ];
          }
          {
            window_name = "cfg";
            window_index = "0";
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
