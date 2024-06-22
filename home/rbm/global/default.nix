{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      # inputs.impermanence.nixosModules.home-manager.impermanence
      inputs.catppuccin.homeManagerModules.catppuccin

    ./cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    packages = with pkgs; [
      gcc
      unzip
    ];
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [
      "$HOME/.local/lib/node_modules/bin"
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      NODE_PATH = "~/.local/lib/node_modules";
      VISUAL = "nvim";
    };
    username = lib.mkDefault "rbm";
  };

  news.display = "silent";

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
  };

  services = {
    playerctld.enable = true;
    remmina.enable = true;
    ssh-agent.enable = true;
  };

  systemd.user = {
    services = {
        mpris-proxy = {
          Unit = {
            Description = "Mpris proxy";
          };
          Install = {
            After = [ "network.target" "sound.target" ];
            WantedBy = [ "default.target" ];
          };
          Service = {
            ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
            Restart = "on-failure";
            Type = "exec";
          };
        };
      };
    startServices = "sd-switch";
    };

  xdg = {
    mimeApps.enable = true;
    portal.enable = true;
  };
}
