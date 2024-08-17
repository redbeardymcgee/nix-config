{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.rivercarro];
  # xdg.desktopEntries."river" = {
  #   name = "River";
  #   comment = "A dynamic tiling Wayland compositor";
  #   exec = "river";
  #   type = "Application";
  # };

  wayland.windowManager.river = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["-all"];
    };

    settings = let
      pow2 = n:
        if n == 0
        then 1
        else 2 * (pow2 (n - 1));
    in {
      set-cursor-warp = "on-focus-change";
      set-repeat = "50 300";
      default-layout = "rivercarro";
      # focus-follows-cursor = "normal";
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
                "None F${num}" = "set-focused-tags ${tagmask}";
                "Super F${num}" = "set-view-tags ${tagmask}";
                "Super+Shift F${num}" = "toggle-focused-tags ${tagmask}";
                "Super+Control F${num}" = "toggle-view-tags ${tagmask}";
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

            "Super Return" = "send-layout-cmd rivercarro 'main-location-cycle left,down,right,up,monocle'";
            "Super Z" = "zoom";

            "Super H" = "focus-view left";
            "Super J" = "focus-view down";
            "Super K" = "focus-view up";
            "Super L" = "focus-view right";

            "Super Period" = "focus-output next";
            "Super Comma" = "focus-output previous";
            "Super+Shift Period" = "send-to-output next";
            "Super+Shift Comma" = "send-to-output previous";

            "Super F10" = "set-focused-tags ${allTagsMask}";
            "Super+Shift F10" = "set-view-tags ${allTagsMask}";
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
          "xdg-desktop-portal-*" = "float";
          "Xdg-desktop-portal-*" = "float";
          "terminal_*" = "output DVI-D-1";
          "terminal_localhost" = "tags ${toString (pow2 0)}";
          "terminal_projects" = "tags ${toString (pow2 1)}";
          "terminal_mcgeedia" = "tags ${toString (pow2 2)}";
          "firefox_ultrawide" = "output DP-1";
          "*firefox_ultrawide" = "tags ${toString (pow2 0)}";
          "vesktop" = "output DP-1";
          "*vesktop" = "tags ${toString (pow2 0)}";

          "org.remmina.Remmina" = "output DP-1";
          "*org.remmina.Remmina" = "tags ${toString (pow2 8)}";

          "org.qBittorrent.qBittorrent" = "output DVI-D-1";
          "*org.qBittorrent.qBittorrent" = "tags ${toString (pow2 8)}";
          "org.qBittorrent.qBittorrent*" = "float";

          "com.moonlight_stream.Moonlight" = "output DVI-D-1";
          "*com.moonlight_stream.Moonlight" = "tags ${toString (pow2 4)}";

          "*steam_app" = "";
          "steam_app_*" = "output DVI-D-1";

          "firefox_incr-*" = "output DP-1";
          "firefox_incr-ngsc " = "tags ${toString (pow2 7)}"; # NGSC
          "firefox_incr-evolve " = "tags ${toString (pow2 7)}"; # Evolve

          "cs2" = "tags ${toString (pow2 4)}"; # Counter-Strike 2

          "steam_app_1877960" = "output DVI-D-1"; # Trimps
          "*steam_app_1877960" = "tags ${toString (pow2 7)}";

          "steam_app_610080" = "output DP-1"; # Realm Grinder
          "*steam_app_610080" = "tags ${toString (pow2 7)}";

          "steam_app_1147690" = "output DP-1"; # NGU
          "steam_app_1147690*" = "float";
          "*steam_app_1147690" = "tags ${toString (pow2 6)}";

          "steam_app_2373630" = "output DVI-D-1"; # Moonring
          "*steam_app_2373630" = "tags ${toString (pow2 4)}";
        };

        "-title" = {
          "Picture-in-Picture" = "float";

          "Loop Hero" = "tags ${toString (pow2 4)}";
          "*Loop Hero" = "float";

          "qBittorrent *" = "no-float";

          "Steam" = "tags ${toString (pow2 6)}";
          "*Steam*" = "float";
        };
      };

      spawn = [
        # NOTE: Inner quotes are required
        #       This is mostly like `sh -c '$spawn_cmd'`

        # FIXME: This shouldn't be necessary because of systemd.variables = ["-all"];
        "'dbus-update-activation-environment --all --systemd'"

        # TODO: riverguile seems to have more features
        "'rivercarro -outer-gaps 0'"

        '''way-displays > "$XDG_RUNTIME_DIR/way-displays.$XDG_SEAT.log" 2>&1' ''
        "yambar"
        "vesktop"
        "'firefox --name firefox_ultrawide'"
        # FIXME: Firefox refuses to launch new instances of the same profile
        # "'firefox --new-instance --name firefox_incr-ngsc https://ngsc.freddecgames.com/'"

        "${pkgs.writeShellScript "wayland-terminal-session-launch" ''
          for sesh in localhost mcgeedia projects
          do
            # wezterm start --always-new-process --class terminal_$sesh -- tmuxp load -y $sesh &
            foot --app-id=terminal_$sesh tmuxp load -y $sesh & sleep 1
          done
        ''}
        "
      ];
    };
  };
}
