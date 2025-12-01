{
  programs.smug = {
    enable = true;

    projects = {
      localhost = {
        root = "~/src/redbeardymcgee/nix-config";
        windows = [
          {
            name = "nix";
            layout = "main-vertical";
            selected = true;
            commands = [
              "redvim"
            ];
          }
        ];
      };

      notes = {
        root = "$XDG_DOCUMENTS_DIR/Notebooks";
        windows = [
          {
            name = "notes";
            layout = "main-vertical";
          }
        ];
      };

      chat = {
        windows = [
          {
            name = "signal";
            layout = "main-vertical";
            commands = [
              "gurk"
            ];
          }
          {
            name = "matrix";
            layout = "main-vertical";
            commands = [
              "iamb"
            ];
          }
          {
            name = "discord";
            layout = "main-horizontal";
            selected = true;
            commands = [
              "discordo"
            ];
          }
        ];
      };

      projects = {
        root = "~/src/redbeardymcgee";
        windows = [
          {
            name = "nixcats";
            root = "nixcats";
            layout = "main-vertical";
            commands = [
              "redvim"
            ];
          }
          {
            name = "pwf";
            root = "pwf";
            layout = "main-vertical";
            selected = true;
            commands = [
              "redvim"
            ];
          }
          {
            name = "bitburner";
            root = "bitburner";
            layout = "main-vertical";
            commands = [
              "redvim"
            ];
          }
          {
            name = "leetcode";
            root = "leetcode";
            layout = "main-vertical";
            commands = [
              "redvim -c Leet"
            ];
          }
          {
            name = "advent of code";
            root = "aoc";
            layout = "main-vertical";
            commands = [
              "redvim"
            ];
          }
        ];
      };

      perseus = {
        root = "~/src/redbeardymcgee";
        windows = [
          {
            name = "quadlet-store";
            root = "quadlet-store";
            layout = "main-vertical";
            selected = true;
            commands = [
              "redvim"
            ];
          }
          {
            name = "dox";
            root = "podbox-docs";
            layout = "main-vertical";
            commands = [
              "redvim"
            ];
          }
          {
            name = "perseus";
            root = "~";
            layout = "main-vertical";
            commands = [
              "ssh perseus"
              "tmux attach || tmux"
            ];
          }
        ];
      };

      mcgeedia = {
        windows = [
          {
            name = "monitor";
            layout = "main-vertical";
            commands = [
              "ssh mcgeedia"
              "btm"
            ];
          }
          {
            name = "docker";
            layout = "main-vertical";
            selected = true;
            commands = [
              "ssh mcgeedia"
              "cd /opt/containers"
              "yazi"
            ];
          }
          {
            name = "notes";
            root = "$XDG_DOCUMENTS_DIR/Notebooks/McGeedia";
            layout = "main-vertical";
            commands = [
              "redvim"
            ];
          }
        ];
      };
    };
  };
}
