{lib, ...}: {
  programs.yambar = {
    enable = true;
    settings = with lib.lists; let
      red = "F38BA8FF";
      mantle = "181825FF";
      overlay1 = "7F849CFF";
      subtext1 = "BAC2DEFF";

      anchors = fold (a: b: a // b) {} (
        forEach (range 1 9) (i: let
          num = toString i;
        in {
          "id == ${num}" = {
            string = {
              text = "${num}";
            };
          };
        })
      );

      bg_default = {
        stack = [
          {background = {color = mantle;};}
          {
            underline = {
              color = subtext1;
              size = 4;
            };
          }
        ];
      };

      font_default = "FiraCode Nerd Font:size=10";
    in {
      bar = let
        river_base = {
          left-margin = 10;
          right-margin = 13;

          conditions =
            anchors
            // {
              "id == 10" = {
                string = {
                  text = "scratch";
                };
              };
            };

          default = {
            string = {
              text = "";
            };
          };
        };
      in {
        font = font_default;
        height = 20;
        location = "top";
        margin = 0;
        layer = "bottom";
        foreground = overlay1;
        background = mantle;

        left = [
          {
            river = {
              anchors = [
                {
                  base = river_base;
                }
              ];

              content = {
                map = {
                  on-click = {
                    left = "sh -c 'riverctl set-focused-tags $((1 << ({id} - 1)))'";
                    middle = "sh -c 'riverctl toggle-focused-tags $((1 << ({id} - 1)))'";
                    right = "sh -c 'riverctl toggle-view-tags $((1 << ({id} - 1)))'";
                  };

                  conditions = {
                    "state == focused" = {
                      map =
                        river_base
                        // {
                          deco = bg_default;
                        };
                    };

                    "state == visible && occupied" = {
                      map =
                        river_base
                        // {
                          deco = bg_default;
                        };
                    };

                    "state == visible && ~occupied" = {
                      map = river_base;
                    };

                    "state == invisible && occupied" = {
                      map =
                        river_base
                        // {
                          deco = {
                            underline = {
                              color = red;
                              size = 3;
                            };
                          };
                        };
                    };

                    "state == invisible && ~occupied" = {
                      empty = {};
                    };

                    "state == unfocused" = {
                      map = river_base;
                    };

                    "state == urgent" = {
                      map =
                        river_base
                        // {
                          deco = {background = {color = red;};};
                        };
                    };
                  };
                };
              };
            };
          }
        ];
      };
    };
  };
}
