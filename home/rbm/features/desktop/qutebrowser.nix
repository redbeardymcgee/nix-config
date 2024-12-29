{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-cli
    keyutils
  ];

  home.sessionVariables = {
    QT_SCALE_FACTOR = 1.5;
  };

  programs.qutebrowser = {
    enable = true;

    settings = {
      colors.webpage = {
        darkmode.enabled = true;
        preferred_color_scheme = "dark";
      };
      content = {
        cookies.accept = "no-3rdparty";
        default_encoding = "utf-8";
        notifications.enabled = false;
        prefers_reduced_motion = true;
        site_specific_quirks.enabled = true;
        dns_prefetch = false;
        pdfjs = true;

        blocking = {
          adblock.lists = [
            "https://easylist.to/easylist/easylist.txt"
            "https://easylist.to/easylist/easyprivacy.txt"
            "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt"
            "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
          ];
        };
      };
      qt = {
        highdpi = true;
        # workarounds.disable_hangouts_extension = true;
      };
      # editor.command = ["kitty" "--app-id" "floating_editor" "redvim" "+call cursor({line}, {column})" "{file}"];
      editor.command = [
        "ghostty"
        "--class"
        "ghostty.floating_editor"
        "-e"
        "redvim"
        "+call cursor({line}, {column})"
        "{file}"
      ];
      fonts = {
        default_family = lib.mkForce "FiraCode Nerd Font";
        web.size.minimum = 14;
      };
      hints.mode = "number";
      keyhint.delay = 300;
      new_instance_open_target = "window";
      scrolling.smooth = true;
      session.lazy_restore = true;
      statusbar.show = "in-mode";
      tabs.show = "never";
      url = {
        start_pages = [
          "https://mcgee.red"
        ];
        default_page = "https://mcgee.red";
      };
      window.hide_decoration = true;
    };

    keyBindings = {
      normal = {
        ",p" = "spawn --userscript qute-bitwarden -d 'wofi -d' -p 'wofi -d -P'";
        ",m" = "hint links spawn umpv {hint-url}";
        ",M" = "hint --rapid links spawn umpv {hint-url}";
      };
    };

    quickmarks = {
      gh = "https://github.com";
      hm = "https://github.com/nix-community/home-manager";
      no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages";
      np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages";
      nw = "https://wiki.nixos.org/";
      yt = "https://youtube.com";

      dc = "https://digitalcore.club";
      ipt = "https://iptorrents.com";
      mam = "https://myanonamouse.net";
      ot = "https://oldtoons.world";
      tl = "https://torrentleech.org";

      # audiobookshelf
      bazarr = "https://services.mcgee.network/bazarr";
      gotify = "https://notifications.mcgee.network";
      media = "https://media.mcgee.network";
      op = "https://openproject.mcgee.network";
      prowlarr = "https://services.mcgee.network/prowlarr";
      qb = "https://services.mcgee.network/qbt";
      radarr = "https://services.mcgee.network/radarr";
      request = "https://request.mcgee.network";
      sonarr-anime = "https://services.mcgee.network/sonarr-anime";
      sonarr = "https://services.mcgee.network/sonarr";
      stats = "https://stats.mcgee.network";
      tdarr = "https://tdarr.mcgee.network";
      threadfin = "https://threadfin.mcgee.network";
      wizarr = "https://wizarr.mcgee.network";
    };

    searchEngines = {
      DEFAULT = "https://www.qwant.com/?q={}";

      amazon = "https://www.amazon.com/s/?field-keywords={}";
      crates = "https://crates.io/search?q={}";
      ddg = "https://duckduckgo.com/html?q={}";
      deb = "https://packages.debian.org/search?keywords={}&searchon=names&suite=all&section=all";
      fdroid = "https://search.f-droid.org/?q={}";
      fh = "https://flathub.org/apps/search?q={}";
      gentoo = "https://wiki.gentoo.org/index.php?title=Special%3ASearch&profile=default&search={}&fulltext=Search";
      gh = "https://github.com/search?utf8=%E2%9C%93&q={}&ref=simplesearch";
      hm = "https://home-manager-options.extranix.com/?query={}&release=master";
      imdb = "https://www.imdb.com/find?q={}";
      js = "https://developer.mozilla.org/en-US/search?q={}&topic=api&topic=js";
      maps = "https://www.openstreetmap.org/search?query={}";
      no = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      npm = "https://www.npmjs.com/search?q={}";
      nw = "https://wiki.nixos.org/w/index.php?search={}&title=Special%3ASearch&wprov=acrw1_-1";
      op = "https://openproject.mcgee.network/search?q={}&work_packages=1&scope=all";
      protondb = "https://www.protondb.com/search?q={}";
      python = "https://docs.python.org/3/search.html?q={}";
      qwant = "https://www.qwant.com/?q={}";
      reddit = "https://old.reddit.com/r/{}";
      rust = "https://doc.rust-lang.org/std/index.html?search={}";
      searx = "https://searx.me/?q={}&categories=general&language=en-US";
      steam = "https://store.steampowered.com/search/?term={}";
      tmuxp = "https://tmuxp.git-pull.com/search.html?q={}&check_keywords=yes&area=default#";
      w = "https://en.wikipedia.org/w/index.php?search={}&title=Special%3ASearch";
      yt = "https://www.youtube.com/results?search_query={}";
    };

    greasemonkey = [
      # (pkgs.fetchFromGitHub {
      #   owner = "iamfugui";
      #   repo = "youtube-adb";
      #   rev = "dc0eaad136e8db36ebe6b9aca71045af00b606dd";
      #   hash = "sha256-6s5OS3AzzF/CkYRV3Eblw3CQ+nXhwdHcCZMlyx0XCPU=";
      # })

      (pkgs.writeText "yt-adzoom.js" ''
        // ==UserScript==
        // @name Skip YouTube ads
        // @description Skips the ads in YouTube videos
        // @run-at document-start
        // @include *.youtube.com/*
        // ==/UserScript==

        document.addEventListener('load', () => {
            const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button-modern')
            if (btn) {
                btn.click()
            }
            const ad = [...document.querySelectorAll('.ad-showing')][0];
            if (ad) {
                document.querySelector('video').currentTime = 9999999999;
            }
        }, true);
      '')

      (pkgs.fetchurl {
        url = "https://codeberg.org/ltGuillaume/yt2invidio/raw/master/yt2invidio.user.js";
        sha256 = "sha256-j90cJQESIiAVN2qKd2D097WkvVeB4I8NbTePwNW387Q=";
      })

      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/gardenshade/mam-plus/master/release/mam-plus.user.js";
        sha256 = "sha256-Jj5OTGpcicLGib7ftyzovcHi+yOldHYKQNEB6zGuqkE=";
      })

      (pkgs.fetchurl {
        url = "https://update.greasyfork.org/scripts/417852/MAM%20Site%20Store%20Fix.user.js";
        sha256 = "sha256-Lm4qc066fPS0MMO7C5OkJyd+wz3amRx7dDRWndMS5nc=";
      })

      (pkgs.fetchurl {
        url = "https://update.greasyfork.org/scripts/451080/MAM%20Total%20Torrents.user.js";
        sha256 = "sha256-vBaNnyD6hTecGrmqK4ekU4iOyv0dy+bC9rRSChtect4=";
      })

      (pkgs.fetchurl {
        url = "https://update.greasyfork.org/scripts/485525/Remove%20Seeding.user.js";
        sha256 = "sha256-nbtcx6sQnc4ynpEGabvTo3NjiGVQB9J0wbf+Nv2CzMQ=";
      })

      (pkgs.fetchurl {
        url = "https://github.com/tophf/mpiv/raw/master/script.user.js";
        sha256 = "sha256-+RNwuynSR3Wo7snLWVHvgDkORP8iqLDa9nuYZaGsF8Q=";
      })
    ];
  };
}
