{ ... }: {
  wayland.windowManager.river = {
    enable = true;

    extraConfig = ''
      for i in $(seq 1 9)
      do
        tags=$((1 << ($i - 1)))
        riverctl map normal Super $i set-focused-tags $tags
        riverctl map normal Super+Shift $i set-view-tags $tags
        riverctl map normal Super+Control $i toggle-focused-tags $tags
        riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
      done

      all_tags=$(((1 << 32) - 1))
      riverctl map normal Super 0 set-focused-tags $all_tags
      riverctl map normal Super+Shift 0 set-view-tags $all_tags

      for mode in normal locked
      do
        riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
        riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
        riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

        riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
        riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
        riverctl map $mode None XF86AudioNext  spawn 'playerctl next'
      done

      way-displays > "/tmp/way-displays.$XDG_VTNR.$USER.log" 2>&1 &

      rivertile -view-padding 6 -outer-padding 6 &
    '';

    settings = {
      declare-mode = [
        "locked"
	      "normal"
	      "passthrough"
      ];
      default-layout = "rivertile";
      focus-follows-cursor = "always";
      input = {
        pointer-main = {
      	  accel-profile = "flat";
      	  events = true;
      	  tap = false;
      	};
      };
      map = {
        normal = {
	        "Super+Shift Return" = "spawn 'footclient'";
          "Super D" = "spawn '$(tofi-drun)'";
          "Super+Shift D" = "spawn '$(tofi-run)'";

          "Super N" = "spawn 'fnottctl dismiss'";
          "Super+Alt N" = "spawn 'fnottctl dismiss all'";
          "Super+Shift N" = "spawn 'fnottctl actions'";

          "Super F" = "toggle-fullscreen";
          "Super+Shift F" = "toggle-float";
	        "Super Q" = "close";
	        "Super Return" = "zoom";

          "Super Period" = "focus-output next";
          "Super Comma" = "focus-output previous";
	        "Super+Shift Period" = "send-to-output next";
	        "Super+Shift Comma" = "send-to-output previous";

	        "Super H" = "focus-view left";
	        "Super J" = "focus-view down";
	        "Super K" = "focus-view up";
	        "Super L" = "focus-view right";

          "Super+Alt H" = "resize horizontal -100";
          "Super+Alt J" = "resize vertical 100";
          "Super+Alt K" = "resize vertical -100";
          "Super+Alt L" = "resize horizontal 100";

          "Super+Alt+Control H" = "snap left";
          "Super+Alt+Control J" = "snap down";
          "Super+Alt+Control K" = "snap up";
          "Super+Alt+Control L" = "snap right";

	        "Super+Alt+Shift H" = "move left 100";
	        "Super+Alt+Shift J" = "move down 100";
	        "Super+Alt+Shift K" = "move up 100";
	        "Super+Alt+Shift L" = "move right 100";

	        "Super+Shift H" = "swap left";
	        "Super+Shift J" = "swap down";
	        "Super+Shift K" = "swap up";
	        "Super+Shift L" = "swap right";

          "Super F11" = "enter-mode passthrough";
	      };
        passthrough  = {
          "Super F11" = "enter-mode normal";
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
        "systemctl --user import-environment"
        "footclient"
        "firefox"
        "vesktop"
      ];
    };
  };
}
