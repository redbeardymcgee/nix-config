{
  pkgs,
  lib,
  niri,
  ...
}: {
  imports = [
    ../../wayland
    ../../../desktop

    ## NOTE: This includes launcher and other utilities
    ../../dank-material-shell

    ## Niri settings
    ./animations.nix
    ./environment.nix
    ./keybinds.nix
    ./layer-rules.nix
    ./layout.nix
    ./outputs.nix
    ./overview.nix
    # ./recent-windows.nix
    ./spawn-at-startup.nix
    ./window-rules.nix
    ./workspaces.nix

    ../../apps/foot.nix
    ../../apps/wezterm

    ../../../services/cliphist.nix
    ../../../services/ssh-agent.nix
    ../../../services/udiskie.nix
  ];

  # systemd.user.services.niri-flake-polkit.enable = false;

  programs.niri = let
    xwayland-satellite = niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable;
  in {
    enable = true;
    package = pkgs.niri-unstable;

    settings = {
      config-notification = {
        disable-failed = true;
      };
      xwayland-satellite = {
        path = lib.getExe xwayland-satellite;
      };
      gestures = {
        hot-corners.enable = false;
      };
      hotkey-overlay = {
        skip-at-startup = true;
      };
      input = {
        focus-follows-mouse.enable = true;
        keyboard = {
          repeat-delay = 300;
          xkb.layout = "us";
        };
        workspace-auto-back-and-forth = true;
      };
      prefer-no-csd = true;
    };
  };
}
