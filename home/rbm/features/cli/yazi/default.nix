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
      augment-command = mkYaziPlugin {
        pname = "augment-command";
        version = "v25.5.31-or-lower";

        src = pkgs.fetchFromGitHub {
          owner = "hankertrix";
          repo = "augment-command.yazi";
          rev = "v25.5.31-or-lower";
          # rev = "f0e6f4468606ac7545b7695decd2c3e7212c23f6";
          hash = "sha256-HRs/wVEg1fEkMtpT0k4W2rzz/NXbXgBWk3/qhWeZHH0=";
        };

        meta = {
          description = "A plugin to augment some Yazi commands.";
          homepage = "https://github.com/hankertrix/augment-command.yazi";
          license = lib.licenses.agpl3Only;
          maintainers = ["redbeardymcgee"];
        };
      };

      bunny = mkYaziPlugin {
        pname = "bunny";
        version = "v1.3.2";

        src = pkgs.fetchFromGitHub {
          owner = "stelcodes";
          repo = "bunny.yazi";
          rev = "v1.3.2";
          hash = "sha256-HnzuR12c4wJaI7dzZrf/Zdc6yCjvsfhPEcnzNNgcLnA=";
        };

        meta = {
          description = "Bookmarks menu for yazi with persistent and ephemeral bookmarks, fuzzy searching, previous directory, directory from another tab";
          homepage = "https://github.com/stelcodes/bunny.yazi";
          license = lib.licenses.mit;
          maintainers = ["redbeardymcgee"];
        };
      };

      cd-git-root = mkYaziPlugin {
        pname = "cd-git-root";
        version = "none";

        src = pkgs.fetchFromGitHub {
          owner = "ciarandg";
          repo = "cd-git-root.yazi";
          rev = "a0e0f4bef420c392f599569dda770f1827569855";
          hash = "sha256-W2ByLHTFN8aMv1d3UfS7FfU7hkKU97rIKWJAHPyKLy0=";
        };

        meta = {
          description = "Changes directory to the root of the git repository you are currently in.";
          homepage = "https://github.com/ciarandg/cd-git-root.yazi";
          license = lib.licenses.gpl3;
          maintainers = ["redbeardymcgee"];
        };
      };

      pref-by-location = mkYaziPlugin {
        pname = "pref-by-location";
        version = "none";

        src = pkgs.fetchFromGitHub {
          owner = "boydaihungst";
          repo = "pref-by-location.yazi";
          rev = "a2fbb054c0e1adc1099833c93a31855b119fbbba";
          hash = "sha256-IbORmKW6JjKmMl9Mzh7j4SCP7WkDQEm67AXXKmxTL7U=";
        };

        meta = {
          description = "This is a Yazi plugin that save linemode, sort, show_hidden preferences by location.";
          homepage = "https://github.com/boydaihungst/pref-by-location.yazi";
          license = lib.licenses.mit;
          maintainers = ["redbeardymcgee"];
        };
      };

      chmod = chmod;
      diff = diff;
      full-border = full-border;
      mediainfo = mediainfo;
      mount = mount;
      duckdb = duckdb;
      ouch = ouch;
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
