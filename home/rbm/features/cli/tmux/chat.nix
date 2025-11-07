{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/chat.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "chat.yaml" {
        session_name = "chat 󰭹 ";
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
            panes = [{shell = "~/.nix-profile/bin/btm";}];
          }

          {
            inherit options;
            window_name = "host";
            panes = [{shell = "~/.nix-profile/bin/yazi";}];
          }

          {
            inherit layout options;
            window_name = "chat";
            focus = true;
            panes = [
              {
                shell = "~/.nix-profile/bin/iamb";
              }
              {
                shell = "~/.nix-profile/bin/gurk";
                focus = true;
              }
            ];
          }
        ];
      };
    };
  };
}
