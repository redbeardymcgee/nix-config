{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./features/cli
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home = {
    homeDirectory = "/home/rbm";
    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER="sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT="-c";
      NODE_PATH = "~/.local/lib/node_modules";
      # NIXOS_OZONE_WL = "1";
      VISUAL = "nvim";
    };
    stateVersion = "24.05";
    username = "rbm";
  };

  news.display = "silent";

  home.packages = with pkgs; [
    gcc
    unzip
  ];

  programs.eww = {
    # enable = true;
    # configDir = ./eww;
  };
  programs.foot.enable = true;
  programs.firefox.enable = true;
  programs.home-manager.enable = true;

  services = {
    home-manager.autoUpgrade = {
      enable = true;
      frequency = "weekly";
    };
    remmina.enable = true;
    ssh-agent.enable = true;
  };

  systemd.user = {
    startServices = "sd-switch";
  };

  targets.genericLinux.enable = true;

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

      rivertile -view-padding 6 -outer-padding 6 &
    '';
    extraSessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
    settings = {
      background-color = "0x002b36";
      border-color-focused = "0x93a1a1";
      border-color-unfocused = "0x586e75";
      declare-mode = [
        "locked"
	"normal"
	"passthrough"
      ];
      default-layout = "rivertile";
      input = {
        pointer-main = {
	  accel-profile = "flat";
	  events = true;
	  tap = false;
	};
      };
      map = {
        normal = {
	  "Super+Shift Return" = "spawn 'foot'";
	  "Super Q" = "close";
          "Super+Shift E" = "exit";
	  "Super J" = "focus-view next";
	  "Super K" = "focus-view previous";
          "Super+Shift J" = "swap next";
          "Super+Shift K" = "swap previous";
	  "Super Period" = "focus-output next";
	  "Super Comma" = "focus-output previous";
	  "Super+Shift Period" = "send-to-output next";
	  "Super+Shift Comma" = "send-to-output previous";
	  "Super Return" = "zoom";
          "Super H" = ''send-layout-cmd rivertile "main-ratio -0.05"'';
          "Super L" = ''send-layout-cmd rivertile "main-ratio +0.05"'';
          "Super+Shift H" = ''send-layout-cmd rivertile "main-count +1"'';
          "Super+Shift L" = ''send-layout-cmd rivertile "main-count -1"'';
          "Super+Alt H" = "move left 100";
          "Super+Alt J" = "move down 100";
          "Super+Alt K" = "move up 100";
          "Super+Alt L" = "move right 100";
          "Super+Alt+Control H" = "snap left";
          "Super+Alt+Control J" = "snap down";
          "Super+Alt+Control K" = "snap up";
          "Super+Alt+Control L" = "snap right";
          "Super+Alt+Shift H" = "resize horizontal -100";
          "Super+Alt+Shift J" = "resize vertical 100";
          "Super+Alt+Shift K" = "resize vertical -100";
          "Super+Alt+Shift L" = "resize horizontal 100";
          "Super Space" = "toggle-float";
          "Super F" = "toggle-fullscreen";
          "Super Up" = ''send-layout-cmd rivertile "main-location top"'';
          "Super Right" = ''send-layout-cmd rivertile "main-location right"'';
          "Super Down" = ''send-layout-cmd rivertile "main-location bottom"'';
          "Super Left" = ''send-layout-cmd rivertile "main-location left"'';
          "Super F11" = "enter-mode passthrough";
	};
      };
      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
          "Super BTN_MIDDLE" = "toggle-float";
	};
      };
      passthrough  = {
        "Super F11" = "enter-mode normal";
      };
      rule-add = {
        "-app-id" = {
          "'bar'" = "csd";
          "'float*'" = {
            "-title" = {
              "'foo'" = "float";
            };
          };
        };
      };
      set-repeat = "50 300";
    };
  };

  xdg = {
    mimeApps.enable = true;
    # portal.enable = true;
  };
}
