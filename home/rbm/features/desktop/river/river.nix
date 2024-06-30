{lib, ...}: {
  wayland.windowManager.river = {
    enable = true;

    settings = {
      declare-mode = [
        "locked"
        "normal"
        "passthrough"
        "windowmove"
      ];

      default-layout = "rivertile";
      focus-follows-cursor = "normal";

      input = {
        pointer-main = {
          accel-profile = "flat";
          events = true;
          tap = false;
        };
      };

      map = with lib.lists; let
        allTagsMask = toString ((pow2 32) - 1);
        pow2 = n:
          if n == 0
          then 1
          else 2 * (pow2 (n - 1));
        tagMappings = fold (a: b: a // b) {} (
          forEach (range 1 9) (
            i: let
              tagmask = toString (pow2 (i - 1));
              num = toString i;
            in {
              "Super ${num}" = "set-focused-tags ${tagmask}";
              "Super+Shift ${num}" = "set-view-tags ${tagmask}";
              "Super+Control ${num}" = "toggle-focused-tags ${tagmask}";
              "Super+Shift+Control ${num}" = "toggle-view-tags ${tagmask}";
            }
          )
        );

        mediaKeys = {
          "None XF86AudioMute" = "spawn 'swayosd-client --output-volume mute-toggle'";
          "None XF86AudioLowerVolume" = "spawn 'swayosd-client --output-volume lower'";
          "None XF86AudioRaiseVolume" = "spawn 'swayosd-client --output-volume raise'";

          "None XF86AudioMedia" = "spawn 'playerctl play-pause'";
          "None XF86AudioNext" = "spawn 'playerctl next'";
          "None XF86AudioPlay" = "spawn 'playerctl play-pause'";
          "None XF86AudioPrev" = "spawn 'playerctl previous'";
        };
      in {
        normal =
          tagMappings
          // mediaKeys
          // {
            "Super R" = "enter-mode windowmove";
            "Super F11" = "enter-mode passthrough";

            "Super F" = "toggle-fullscreen";
            "Super+Shift F" = "toggle-float";
            "Super Return" = "zoom";
            "Super Q" = "close";

            "Super Period" = "focus-output next";
            "Super Comma" = "focus-output previous";
            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";

            "Super H" = "focus-view left";
            "Super J" = "focus-view down";
            "Super K" = "focus-view up";
            "Super L" = "focus-view right";

            "Super+Shift H" = "swap left";
            "Super+Shift J" = "swap down";
            "Super+Shift K" = "swap up";
            "Super+Shift L" = "swap right";

            "Super 0" = "set-focused-tags ${allTagsMask}";
            "Super+Shift 0" = "set-view-tags ${allTagsMask}";
          };

        locked = mediaKeys;

        passthrough = {
          "Super F11" = "enter-mode normal";
        };

        windowmove = {
          "None Return" = "enter-mode normal";

          "None H" = "resize horizontal -100";
          "None J" = "resize vertical 100";
          "None K" = "resize vertical -100";
          "None L" = "resize horizontal 100";

          "Super H" = "move left 100";
          "Super J" = "move down 100";
          "Super K" = "move up 100";
          "Super L" = "move right 100";

          "Super+Shift H" = "snap left";
          "Super+Shift J" = "snap down";
          "Super+Shift K" = "snap up";
          "Super+Shift L" = "snap right";
        };
      };

      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
          "Super BTN_MIDDLE" = "toggle-float";
        };
      };

      rule-add = {
        "-title" = {
          "Picture-in-Picture" = "float";
        };
      };

      set-cursor-warp = "on-focus-change";
      set-repeat = "50 300";

      spawn = [
        "'way-displays > $XDG_RUNTIME_DIR/way-displays.log 2>&1'"
        "xdg-user-dirs-update"

        "'riverctl focus-output DP-3'"
        "yambar"
        "firefox"
        "vesktop"

        "'riverctl focus-output DVI-D-1'"
        "yambar"
        "'foot tmuxp load -y localhost'"

        "'rivertile -view-padding 6 -outer-padding 6'"
      ];
    };
  };
}
