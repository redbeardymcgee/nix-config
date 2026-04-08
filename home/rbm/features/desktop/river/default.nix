{
  imports = [
    ../wayland
    ../../desktop
    ./river.nix

    ../apps/fnott.nix
    ../apps/foot.nix
    # ../apps/gradia.nix
    ../apps/satty.nix
    ../apps/swaylock.nix
    ../apps/way-displays.nix
    ../apps/wezterm
    ../apps/wofi.nix
    ../apps/wlogout.nix

    ../../services/cliphist.nix
    # ../../services/easyeffects.nix
    # ../../services/gammastep.nix
    # ../../services/lorri.nix
    ../../services/mpris-proxy.nix
    ../../services/playerctld.nix
    ../../services/ssh-agent.nix
    ../../services/swayidle.nix
    ../../services/swayosd.nix
    ../../services/udiskie.nix
  ];
}
