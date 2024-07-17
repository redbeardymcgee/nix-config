{lib, ...}: {
  programs.yambar = {
    enable = true;
    settings = with lib.lists; let
      mantle = "181825FF";
      overlay0 = "6C7086FF";
      red = "F38BA8FF";
      text = "CDD6F4FF";
      # subtext0 = "A6ADC8FF";

      scratchTags = fold (a: b: a // b) {} (
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

      anchors =
        scratchTags
        // {
          "id == 1" = {
            string = {
              text = "󱄄";
            };
          };

          "id == 2" = {
            string = {
              text = "";
            };
          };

          "id == 3" = {
            string = {
              text = "󰢹";
            };
          };

          "id == 4" = {
            string = {
              text = "󰍹";
            };
          };

          "id == 5" = {
            string = {
              text = "";
            };
          };

          "id == 6" = {
            string = {
              text = "󰮃";
            };
          };
        };

      font_default = "FiraCode Nerd Font:size=12";
    in {
      bar = let
        riverBase = {
          left-margin = 10;
          right-margin = 10;

          conditions =
            anchors
            // {
              "id == 32" = {
                string = {
                  text = "";
                };
              };
            };
        };
      in {
        font = font_default;
        height = 30;
        location = "top";
        margin = 0;
        left-margin = 5;
        right-margin = 5;
        layer = "bottom";
        foreground = text;
        background = mantle;

        left = [
          # {
          #   removables = {
          #     content = {
          #       map = {
          #         conditions = {
          #           "~mounted".string = {
          #             text = "{label}";
          #             max = 8;
          #             right-margin = 3;
          #           };
          #
          #           "mounted" = {
          #             string = {
          #               text = "{label}";
          #               max = 8;
          #               right-margin = 5;
          #             };
          #           };
          #         };
          #       };
          #     };
          #   };
          # }
        ];

        center = [
          {
            river = {
              anchors = [
                {
                  base = riverBase;
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
                        riverBase
                        // {
                          deco = {
                            underline = {
                              color = red;
                              size = 1;
                            };
                          };
                        };
                    };

                    "state == visible && occupied" = {
                      map =
                        riverBase;
                    };

                    "state == visible && ~occupied" = {
                      map =
                        riverBase;
                    };

                    "state == invisible && occupied" = {
                      map =
                        riverBase
                        // {
                          deco = {
                            underline = {
                              color = overlay0;
                              size = 1;
                            };
                          };
                        };
                    };

                    "state == invisible && ~occupied" = {
                      map =
                        riverBase;
                    };

                    "state == unfocused" = {
                      map = riverBase;
                    };

                    "state == urgent" = {
                      map =
                        riverBase
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

        right = [
          {
            clock = {
              time-format = "%H:%M";
              content = [
{
                  string = {
                    text = "{date}";
                    right-margin = 5;
                  };
                }
                {
                  string = {
                    text = "󰸗";
                    right-margin = 3;
                  };
                }
                {
                  string = {
                    text = "{time}";
                    right-margin = 5;
                  };
                }
                {
                  string = {
                    text = "";
                    right-margin = 5;
                  };
                }
              ];
            };
          }
        ];
      };
    };
  };
}
