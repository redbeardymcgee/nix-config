{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    enableAllFirmware = true;
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      prime.offload.enable = false;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio = {
      enable = false;
      configFile = pkgs.writeText "default.pa" ''
        load-module module-bluetooth-policy
        load-module module-bluetooth-discover
      '';
      extraConfig = ''
        load-module module-switch-on-connect
      '';
      package = pkgs.pulseaudioFull;
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.hostName = "rbmpc";

  networking.networkmanager.enable = true;

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  nixpkgs = {
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
    config = {
      allowUnfree = true;
    };
  };

  programs.dconf.enable = true;

  security.rtkit.enable = true;
  services = {
    blueman.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --asterisks \
            --cmd ${pkgs.river}/bin/river \
            --remember \
            --remember-user-session 
            --time \
            --user-menu
          '';
          user = "greeter";
        };
      };
    };
    kanata = {
      enable = true;
      keyboards."rbm".config = ''
        (defsrc caps)
	
        (deflayermap (default-layer)
          caps (tap-hold 100 100 caps lctl))
      '';
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    pipewire = {
      enable = true;
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
        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };
    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  system = {
    autoUpgrade.enable = true;
    stateVersion = "24.11"; # Did you read the comment?
  };

  time.timeZone = "America/Chicago";

  users.users = {
    rbm = {
      description = "josh";
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
