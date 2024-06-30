{pkgs, ...}: {
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = "";
      yy = {
        body = ''
          set tmp (mktemp -p $XDG_RUNTIME_DIR yazi-cwd.XXXXXX)
          yazi $argv --cwd-file=$tmp
          if set cwd (cat -- $tmp); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd "$cwd"
          end
        '';
        wraps = "yazi";
      };
    };

    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
    ];

    shellAbbrs = rec {
      gp = "gtrash put";
      rm = "gtrash put";

      "--help" = {
        position = "anywhere";
        expansion = "--help 2>&1 | bathelp";
      };

      hm = "home-manager --flake .";
      hmb = "home-manager --flake . build";
      hms = "home-manager --flake . switch";
      nhb = "nh home build";
      nhs = "nh home switch";
      nob = "nh os build";
      nos = "nh os switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";

      vim = "nvim";
      vi = vim;
      v = vim;
    };

    shellAliases = {
      dps = ''
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.State}}\t{{.CreatedAt}}"
      '';
    };
  };

  home.packages = with pkgs; [
    grc
  ];
}
