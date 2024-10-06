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

            "Super Return" = "toggle-focused-tags ${scratchTagString}";
            "Super+Shift Return" = "set-view-tags ${scratchTagString}";
            "Super S" = "spawn 'kitty --app-id notesterm tmuxp load notes'";
            "Super+Shift S" = "spawn 'kitty --app-id scratchterm'";

            "Super Z" = "zoom";

            "Super H" = "focus-view left";
            "Super J" = "focus-view down";
            "Super K" = "focus-view up";
            "Super L" = "focus-view right";

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

      rule-add = {
        "-app-id" = {
          # "firefox_ultrawide" = "output DP-1";
          # "*firefox_ultrawide" = "tags ${toString (pow2 0)}";

          "zen-alpha" = "output DP-1";
          "*zen-alpha" = "tags ${toString (pow2 0)}";

          "thunderbird" = "output DP-1";
          "*thunderbird" = "tags ${toString (pow2 4)}";

          "ch.proton.bridge-gui" = "output DP-1";
          "*ch.proton.bridge-gui" = "tags ${toString (pow2 4)}";

          "Vivaldi-stable" = "output DP-1";
          "*Vivaldi-stable" = "tags ${toString (pow2 4)}";

          "Slack" = "output DP-1";
          "*Slack" = "tags ${toString (pow2 4)}";

          "terminal_*" = "output DVI-D-1";
          "terminal_localhost" = "tags ${toString (pow2 0)}";
          "terminal_projects" = "tags ${toString (pow2 1)}";
          "terminal_mcgeedia" = "tags ${toString (pow2 2)}";
          "terminal_perseus" = "tags ${toString (pow2 3)}";
          "terminal_notes" = "tags ${toString (pow2 4)}";
          "terminal_work" = "tags ${toString (pow2 5)}";

          "scratchterm" = "tags ${scratchTagString}";
          "*scratchterm" = "float";

          "notesterm" = "tags ${scratchTagString}";
          "*notesterm" = "float";

          "vesktop" = "output DP-1";
          "*vesktop" = "tags ${toString (pow2 0)}";

          "xdg-desktop-portal-*" = "float";
          "Xdg-desktop-portal-*" = "float";

          "org.remmina.Remmina" = "output DP-1";
          "*org.remmina.Remmina" = "tags ${toString (pow2 8)}";

          "org.qbittorrent.qBittorrent" = "output DVI-D-1";
          "*org.qbittorrent.qBittorrent" = "tags ${toString (pow2 8)}";

          "com.moonlight_stream.Moonlight" = "output DVI-D-1";
          "*com.moonlight_stream.Moonlight" = "tags ${toString (pow2 4)}";

          "steam" = "float";
          "*steam_app_*" = "tags ${toString (pow2 4)}";
          "steam_app_*" = "output DVI-D-1";
        };

        "-title" = {
          "Picture-in-Picture" = "float";

          "Loop Hero" = "tags ${toString (pow2 4)}";
          "*Loop Hero" = "float";

          "qBittorrent *" = "no-float";

          "Steam" = "tags ${toString (pow2 6)}";
          "*Steam*" = "float";

          "Vivaldi Settings:*" = "float";
        };
      };

      spawn = [
        # NOTE: Inner quotes are required
        #       This is mostly like `sh -c '$spawn_cmd'`

        # TODO: Convert to systemd user units

        # TODO: riverguile seems to have more features
        "'rivercarro -outer-gaps 0'"
        '''way-displays > "$XDG_RUNTIME_DIR/way-displays.$XDG_SEAT.log" 2>&1' ''
        "wpaperd"
        "yambar"
        "vesktop"
        # "'firefox --name firefox_ultrawide'"
        "protonmail-bridge-gui"
        "thunderbird"
        "flatpak --user run io.github.zen_browser.zen"
        "qbittorrent"

        "${pkgs.writeShellScript "wayland-session-autostart-terminals" ''
          for sesh in localhost mcgeedia projects notes perseus work
          do
            # wezterm start --always-new-process --class terminal_$sesh -- tmuxp load -y $sesh &
            kitty --app-id terminal_$sesh tmuxp load -y $sesh &
            sleep 1
          done
        ''}"

        "${pkgs.writeShellScript "wayland-session-autostart-work" ''
          flatpak --user run com.vivaldi.Vivaldi &
          sleep 1
          slack
        ''}"
      ];
    };
  };
}
