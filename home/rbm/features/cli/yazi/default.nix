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
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    enableFishIntegration = true;
    initLua = ./init.lua;
    keymap = import ./keymap.nix;

    plugins = let
      officialPluginsNames = [
        "chmod"
        "diff"
        "full-border"
        # "git"
        # "jump-to-char"
        # "lsar"
        # "mactag" # NOTE: MacOS only
        # "mime-ext"
        "mount"
        # "no-status"
        # "piper"
        # "smart-enter"
        "smart-filter"
        # "smart-paste"
        # "toggle-pane" # TODO: This is worth adding
        # "vcs-files"
        "zoom"
      ];

      officialPluginsSrc = pkgs.fetchgit {
        url = "https://github.com/yazi-rs/plugins.git";
        sparseCheckout = map (p: "${p}.yazi") officialPluginsNames;
        rev = "2301ff803a033cd16d16e62697474d6cb9a94711";
        hash = "sha256-89Y3v/fAaZA1Im4OR6KwwbK1N7THsmU90JYpxfWsD1A=";
      };

      officialPlugins =
        lib.lists.fold (
          a: b:
            {
              ${a} = "${officialPluginsSrc}/${a}.yazi";
            }
            // b
        )
        {}
        officialPluginsNames;
    in
      officialPlugins
      // {
        augment-command = "${inputs.augment-command-yazi}";
        bunny = "${inputs.bunny-yazi}";
        cd-git-root = "${inputs.cd-git-root-yazi}";
        mediainfo = "${inputs.mediainfo-yazi}";
        duckdb = "${inputs.duckdb-yazi}";
        ouch = "${inputs.ouch-yazi}";
        pref-by-location = "${inputs.pref-by-location-yazi}";
        recycle-bin = "${inputs.recycle-bin-yazi}";
        restore = "${inputs.restore-yazi}";
        wl-clipboard = "${inputs.wl-clipboard-yazi}";
      };

    settings = {
      mgr = {
        ratio = [1 2 5];
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
