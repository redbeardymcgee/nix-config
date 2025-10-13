{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./locale.nix
      ./kernel.nix
      ./nix.nix
      ./qemu.nix
      ./sudo.nix
      ./systemd-initrd.nix

      ../services/libinput.nix
      ../services/openssh.nix
      ../services/pipewire.nix
      ../services/ssd.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  environment = {
    systemPackages = with pkgs; [
      libnotify
      netscanner
      rsync
      slack
    ];

    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };

  fonts.fontDir.enable = true;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
  };

  programs = {
    fish.enable = true;
    dconf.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };

  services = {
    avahi.enable = true;
    blueman.enable = true;
  };

  system = {
    autoUpgrade.enable = false;
    stateVersion = "24.05";
  };

  xdg.terminal-exec = {
    enable = true;

    settings = {
      default = [
        "com.mitchellh.ghostty.desktop"
        "kitty.desktop"
        "org.codeberg.dnkl.foot.desktop"
        "org.wezfurlong.wezterm.desktop"
      ];
    };
  };
}
