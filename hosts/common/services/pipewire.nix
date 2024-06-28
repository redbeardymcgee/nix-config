{...}: {
  security = {
    rtkit.enable = true;
    pam.loginLimits = [
      {
        domain = "@wheel";
        item = "nofile";
        type = "soft";
        value = "524288";
      }
      {
        domain = "@wheel";
        item = "nofile";
        type = "hard";
        value = "1048576";
      }
    ];
  };
  services = {
    pipewire = {
      enable = true;
      # alsa = {
      #   enable = true;
      #   support32bit = true;
      # };
      extraConfig.pipewire."92-low-latency" = {
        context = {
          modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse = {
                  default.req = "32/48000";
                  min = {
                    req = "32/48000";
                    quantum = "32/48000";
                  };
                  max = {
                    req = "32/48000";
                    quantum = "32/48000";
                  };
                };
              };
            }
          ];
          properties = {
            default.clock = {
              rate = 48000;
              quantum = 32;
              min-quantum = 32;
              max-quantum = 32;
            };
          };
        };
        stream.properties = {
          node.latency = "32/48000";
          resample.quality = 1;
        };
      };
      pulse.enable = true;
      wireplumber.extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
        };
      };
    };
  };
}
