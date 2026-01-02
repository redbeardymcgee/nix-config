{
  lib,
  inputs,
  pkgs,
  ...
}: {
  programs.fish.functions = {
    y = {
      wraps = "yazi";
      body =
        # fish
        ''
          builtin cd -- "$(command yazi $argv --cwd-file /dev/stdout)"
        '';
    };
  };

  home.packages = with pkgs; [
    eject
    exiftool
    file
    fzf
    glow
    hexyl
    imagemagick
    mediainfo
    miller
    ouch
    p7zip
    poppler
    ripdrag
    trash-cli
    udisks
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    initLua = ./init.lua;
    keymap = import ./keymap.nix;
    plugins = with pkgs.yaziPlugins; {
      augment-command = "${inputs.augment-command-yazi}";
      bunny = "${inputs.bunny-yazi}";
      cd-git-root = "${inputs.cd-git-root-yazi}";
      chmod = chmod;
      diff = diff;
      full-border = full-border;
      mediainfo = mediainfo;
      mount = mount;
      duckdb = duckdb;
      ouch = ouch;
      pref-by-location = "${inputs.pref-by-location-yazi}";
      smart-filter = smart-filter;
      recycle-bin = recycle-bin;
      restore = restore;
      wl-clipboard = wl-clipboard;
      # zoom = zoom; ## TODO: Not in nixpkgs 25.11
    };

    settings = {
      mgr = {
        ratio = [1 3 4];
        scrolloff = 10;
        sort_dir_first = true;
      };

      tasks = {
        image_alloc = 1073741824;
      };

      plugin = {
        prepend_preloaders = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
          {
            name = "*.csv";
            run = "duckdb";
            multi = false;
          }
          {
            name = "*.tsv";
            run = "duckdb";
            multi = false;
          }
          {
            name = "*.json";
            run = "duckdb";
            multi = false;
          }
          {
            name = "*.parquet";
            run = "duckdb";
            multi = false;
          }
          {
            name = "*.xlsx";
            run = "duckdb";
            multi = false;
          }
        ];

        prepend_previewers = [
          {
            name = "*.csv";
            run = "duckdb";
          }
          {
            name = "*.tsv";
            run = "duckdb";
          }
          {
            name = "*.json";
            run = "duckdb";
          }
          {
            name = "*.parquet";
            run = "duckdb";
          }
          {
            name = "*.xlsx";
            run = "duckdb";
          }
          {
            name = "*.db";
            run = "duckdb";
          }
          {
            name = "*.duckdb";
            run = "duckdb";
          }

          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
          {
            mime = "application/*zip";
            run = "ouch";
          }
          {
            mime = "application/x-tar";
            run = "ouch";
          }
          {
            mime = "application/x-bzip2";
            run = "ouch";
          }
          {
            mime = "application/x-7z-compressed";
            run = "ouch";
          }
          {
            mime = "application/x-rar";
            run = "ouch";
          }
          {
            mime = "application/vnd.rar";
            run = "ouch";
          }
          {
            mime = "application/x-xz";
            run = "ouch";
          }
          {
            mime = "application/xz";
            run = "ouch";
          }
          {
            mime = "application/x-zstd";
            run = "ouch";
          }
          {
            mime = "application/zstd";
            run = "ouch";
          }
          {
            mime = "application/java-archive";
            run = "ouch";
          }
        ];
      };
    };
  };
}
