{ pkgs, lib, ...}: {
  xdg.configFile = {
    "tmuxp/localhost.json" = {
      enable = true;
      text = lib.generators.toJSON { } {
        session_name = "localhost";
        windows = [
          {
            window_name = "main";
            focus = true;
            panes = [
              { shell_command = [ "yy" ]; }
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
