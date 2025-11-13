{pkgs, ...}: {
  xdg.configFile = {
    "tmuxp/leetcode.yaml" = {
      enable = true;

      source = (pkgs.formats.yaml {}).generate "leetcode.yaml" {
        session_name = "leet 󱃖 ";

        windows = let
          layout = "fd95,212x55,0,0{105x55,0,0,38,106x55,106,0,39}";
          options = {
            automatic-rename = false;
            remain-on-exit = true;
          };
        in [
          {
            inherit layout options;
            window_name = "leetcode";
            start_directory = "~/src/redbeardymcgee/leetcode";
            focus = true;
            panes = [
              {
                focus = true;
                shell_command = [
                  "redvim -c Leet"
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
