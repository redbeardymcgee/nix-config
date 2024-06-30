{lib, ...}: {
  programs.yambar = {
    enable = true;
    settings = with lib.lists; let
      mantle = "181825FF";
      red = "F38BA8FF";
      text = "CDD6F4FF";
      subtext0 = "A6ADC8FF";

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
              text = "󰽟";
            };
          };
          "id == 2" = {
            string = {
              text = "";
            };
          };
          "id == 3" = {
            string = {
              text = "󰮃";
            };
          };
        };

      bg_default = {
        stack = [
          {background = {color = mantle;};}
          {
            underline = {
              color = subtext0;
              size = 4;
            };
          }
        ];
      };

      font_default = "FiraCode Nerd Font:size=12";
    in {
      bar = let
        river_base = {
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

          default = {
            empty = {};
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

        center = [
          {
            clock = {
              time-format = "%H:%M";
              content = [
                {
                  string = {
                    text = "󰸗";
                    right-margin = 3;
                  };
                }
                {
                  string = {
                    text = "{date}";
                    right-margin = 5;
                  };
                }
                {
                  string = {
                    text = "";
                    right-margin = 5;
                  };
                }
                {
                  string = {
                    text = "{time}";
                    right-margin = 5;
                  };
                }
              ];
            };
          }
        ];

        right = [
          {
            removables = {
              content = {
                map = {
                  conditions = {
                    "~mounted".string = {
                      text = "{label}";
                      max = 8;
                      right-margin = 3;
                    };
                    "mounted" = {
                      string = {
                        text = "{label}";
                        max = 8;
                        right-margin = 5;
                        deco.underline = {
                          size = 2;
                          color = subtext0;
                        };
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
