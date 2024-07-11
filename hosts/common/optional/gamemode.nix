{pkgs, ...}: {
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
    "fs.file-max" = 524288;
  };

  programs.gamemode = {
    enable = true;

    settings = {
      general = {
        renice = 10;
        softrealtime = "auto";
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 2;
        nv_powermizer_mode = 1;
      };

      cpu = {
        park_cores = "yes";
        pin_cores = "yes";
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
}
