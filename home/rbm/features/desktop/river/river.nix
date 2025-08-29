{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.rivercarro];

  wayland.windowManager.river = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };

    settings = let
      pow2 = n:
        if n == 0
        then 1
        else 2 * (pow2 (n - 1));
      scratchTag = pow2 20;
      scratchTagString = toString scratchTag;
    in {
      set-cursor-warp = "on-focus-change";
      set-repeat = "50 300";
      default-layout = "rivercarro";
      focus-follows-cursor = "normal";
      hide-cursor.when-typing = "enabled";

      declare-mode = [
        "layout"
        "locked"
        "move"
        "normal"
        "passthrough"
      ];

      input = {
        pointer-main = {
          accel-profile = "flat";
          events = true;
          tap = false;
        };
      };

      map = let
        allTagsMask = toString ((pow2 32) - 1);
        tagMappings = with lib.lists;
          fold (a: b: a // b) {} (
            forEach (range 1 9) (
              i: let
                tagmask = toString (pow2 (i - 1));
                num = toString i;
              in {
                "Super ${num}" = "set-focused-tags ${tagmask}";
                "Super+Shift ${num}" = "set-view-tags ${tagmask}";
                "Super+Control ${num}" = "toggle-focused-tags ${tagmask}";
                "Super+Alt ${num}" = "toggle-view-tags ${tagmask}";
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

        winSwapKeys = {
          "Super+Shift H" = "swap left";
          "Super+Shift J" = "swap down";
          "Super+Shift K" = "swap up";
          "Super+Shift L" = "swap right";
        };
      in {
        normal =
          mediaKeys
          // winSwapKeys
          // tagMappings
          // {
            "Super Backspace" = "enter-mode passthrough";
            "Super R" = "enter-mode layout";
            "Super W" = "enter-mode move";

            "Super Q" = "close";
            "Super+Control+Shift Q" = "riverctl exit";

            "Super F" = "toggle-fullscreen";
            "Super+Shift F" = "toggle-float";

            "Super S" = "toggle-focused-tags ${scratchTagString}";
            "Super+Shift S" = "set-view-tags ${scratchTagString}";

            "Super Space" = ''spawn 'ghostty --class=ghostty.localhost -e tmuxp load -y localhost' '';
            "Super Return" = ''spawn 'ghostty --class=ghostty.scratchterm' '';
            "Super N" = ''spawn 'ghostty --class=ghostty.notesterm -e tmuxp load -y notes' '';

            "Super H" = "focus-view left";
            "Super J" = "focus-view down";
            "Super K" = "focus-view up";
            "Super L" = "focus-view right";

            "Super Z" = "zoom";

            "Super Tab" = "focus-output next";
            "Super+Shift Tab" = "send-to-output next";

            "Super 0" = "set-focused-tags ${allTagsMask}";
            "Super+Shift 0" = "set-view-tags ${allTagsMask}";
          };

        locked =
          mediaKeys
          // {
            "None Return" = "enter-mode normal";
            "None Escape" = "enter-mode normal";
          };

        passthrough = {
          "Super Escape" = "enter-mode normal";
          "Super Backspace" = "enter-mode normal";
        };

        layout =
          winSwapKeys
          // {
            "None Return" = "enter-mode normal";
            "None Escape" = "enter-mode normal";

            "Alt H" = "resize horizontal -50";
            "Alt J" = "resize vertical 50";
            "Alt K" = "resize vertical -50";
            "Alt L" = "resize horizontal 50";

            "None H" = "resize horizontal -100";
            "None J" = "resize vertical 100";
            "None K" = "resize vertical -100";
            "None L" = "resize horizontal 100";

            "Control H" = "resize horizontal -500";
            "Control J" = "resize vertical 500";
            "Control K" = "resize vertical -500";
            "Control L" = "resize horizontal 500";

            "Super K" = "send-layout-cmd rivercarro 'main-location top'";
            "Super L" = "send-layout-cmd rivercarro 'main-location right'";
            "Super J" = "send-layout-cmd rivercarro 'main-location bottom'";
            "Super H" = "send-layout-cmd rivercarro 'main-location left'";
          };

        move = {
          "None Return" = "enter-mode normal";
          "None Escape" = "enter-mode normal";

          "Alt H" = "move left 50";
          "Alt J" = "move down 50";
          "Alt K" = "move up 50";
          "Alt L" = "move right 50";

          "None H" = "move left 100";
          "None J" = "move down 100";
          "None K" = "move up 100";
          "None L" = "move right 100";

          "Control H" = "move left 500";
          "Control J" = "move down 500";
          "Control K" = "move up 500";
          "Control L" = "move right 500";

          "Shift H" = "snap left";
          "Shift J" = "snap down";
          "Shift K" = "snap up";
          "Shift L" = "snap right";
        };
      };

      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
          "Super BTN_MIDDLE" = "toggle-float";
        };
      };

      rule-add = let
        benq = "BNQ BenQ XL2420Z 41E09757SL0";
        samsung = "Samsung Electric Company SE790C Unknown";
      in {
        "-app-id" = {
          # "firefox_ultrasamsung" = "output DP-1";
          # "*firefox_ultrasamsung" = "tags ${toString (pow2 0)}";

          "zen" = samsung;
          "*zen" = "tags ${toString (pow2 1)}";

          "qutebrowser_ultrawide" = samsung;
          "*qutebrowser_ultrawide" = "tags ${toString (pow2 0)}";

          # "thunderbird" = samsung;
          # "*thunderbird" = "tags ${toString (pow2 5)}";

          "org.mozilla.Thunderbird" = samsung;
          "*org.mozilla.Thunderbird" = "tags ${toString (pow2 4)}";

          # "ch.proton.bridge-gui" = samsung;
          # "*ch.proton.bridge-gui" = "tags ${toString (pow2 5)}";

          "Slack" = samsung;
          "*Slack" = "tags ${toString (pow2 4)}";

          "*com.moonlight_stream.Moonlight" = "tags ${toString (pow2 6)}";
          "com.moonlight_stream.Moonlight" = benq;

          "Nextcloud Talk" = samsung;
          "*Nextcloud Talk" = "tags ${toString (pow2 2)}";

          # "terminal_*" = benq;
          # "terminal_localhost" = "tags ${toString (pow2 0)}";
          # "terminal_notes" = "tags ${toString (pow2 1)}";
          # "terminal_perseus" = "tags ${toString (pow2 2)}";
          # "terminal_mcgeedia" = "tags ${toString (pow2 3)}";
          # "terminal_projects" = "tags ${toString (pow2 4)}";
          # "terminal_work" = "tags ${toString (pow2 5)}";

          # "scratchterm" = "tags ${scratchTagString}";
          # "*scratchterm" = "float";

          # "ghostty.*" = benq;
          "ghostty.localhost" = "tags ${toString (pow2 0)}";
          "ghostty.localhost*" = benq;
          "ghostty.notes" = "tags ${toString (pow2 1)}";
          "ghostty.notes*" = benq;
          "ghostty.perseus" = "tags ${toString (pow2 2)}";
          "ghostty.perseus*" = benq;
          "ghostty.mcgeedia" = "tags ${toString (pow2 3)}";
          "ghostty.mcgeedia*" = benq;
          "ghostty.projects" = "tags ${toString (pow2 7)}";
          "ghostty.projects*" = benq;

          "ghostty.notesterm" = "tags ${scratchTagString}";
          "ghostty.scratchterm" = "tags ${scratchTagString}";

          "notesterm" = "tags ${scratchTagString}";
          "*notesterm" = "float";

          "floating_editor" = "float";
          "ghostty.floating_editor" = "float";

          "vesktop" = samsung;
          "*vesktop" = "tags ${toString (pow2 1)}";

          "org.gnome.Fractal" = samsung;
          "*org.gnome.Fractal" = "tags ${toString (pow2 1)}";

          "Signal" = samsung;
          "*Signal" = "tags ${toString (pow2 2)}";

          "xdg-desktop-portal-*" = "float";
          "Xdg-desktop-portal-*" = "float";

          "org.remmina.Remmina" = samsung;
          "*org.remmina.Remmina" = "tags ${toString (pow2 8)}";

          "org.qbittorrent.qBittorrent" = samsung;
          "*org.qbittorrent.qBittorrent" = "tags ${toString (pow2 8)}";
        };

        "-title" = {
          "Picture-in-Picture" = "float";

          "qBittorrent *" = "no-float";
        };
      };

      spawn = [
        ## NOTE: Inner quotes are required
        ##       This is mostly like `sh -c '$spawn_cmd'`

        ## TODO: Convert to systemd user units

        ## TODO: riverguile seems to have more features
        '''rivercarro -outer-gaps 0 -per-tag -main-location right' ''
        ## TODO: These both have a real service/config in hm 25.05
        '''way-displays > "$XDG_RUNTIME_DIR/way-displays.$XDG_VTNR.log" 2>&1' ''
        "wpaperd"
        "vesktop"
        # "'firefox --name firefox_ultrawide'"
        '''flatpak run org.mozilla.Thunderbird' ''
        '''flatpak run app.zen_browser.zen' ''
        "qbittorrent"
        # '''qutebrowser --desktop-file-name qutebrowser_ultrawide' ''
        # "qutebrowser"

        '''ghostty --class=ghostty.localhost -e tmuxp load -y localhost' ''
        '''ghostty --class=ghostty.notes -e tmuxp load -y notes' ''
        '''ghostty --class=ghostty.perseus -e tmuxp load -y perseus' ''
        '''ghostty --class=ghostty.mcgeedia -e tmuxp load -y mcgeedia' ''
        '''ghostty --class=ghostty.projects -e tmuxp load -y projects' ''
        # '''ghostty --class=ghostty.work -e tmuxp load -y work' ''

        "slack"
      ];
    };
  };
}
