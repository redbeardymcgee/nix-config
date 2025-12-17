{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-cli
    keyutils
  ];

  # home.sessionVariables = {
  #   QT_SCALE_FACTOR = 1.5;
  # };

  programs.qutebrowser = {
    enable = true;

    settings = {
      auto_save = {
        interval = 10000;
        session = true;
      };
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
            "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
            "https://easylist.to/easylist/fanboy-social.txt"
          ];
        };
      };
      qt = {
        highdpi = true;
        # workarounds.disable_hangouts_extension = true;
      };
      editor.command = [
        "ghostty"
        "--class=ghostty.floating_editor"
        "-e"
        "redvim"
        "+call cursor({line}, {column})"
        "{file}"
      ];
      fonts = {
        web.size.minimum = 12;
        web.family = {
          cursive = lib.mkForce "Victor Mono Nerd Font Italic";
          # fantasy = "";
        };
      };
      hints = {
        auto_follow_timeout = 500;
        mode = "number";
      };
      keyhint.delay = 300;
      new_instance_open_target = "window";
      scrolling.smooth = true;
      session.lazy_restore = true;
      statusbar.show = "in-mode";
      tabs.show = "never";
      url = {
        start_pages = [
          "https://search.mcgee.red"
        ];
        default_page = "https://search.mcgee.red";
      };
      window.hide_decoration = true;
    };

    keyBindings = {
      normal = {
        ",m" = "hint links spawn umpv {hint-url}";
        ",M" = "hint --rapid links spawn umpv {hint-url}";
      };
    };

    quickmarks = {
      gh = "https://github.com";
      hm = "https://github.com/nix-community/home-manager";

      aither = "https://aither.cc";
      at = "https://animetorrents.me";
      dc = "https://digitalcore.club";
      fnp = "https://fearnopeer.com";
      ipt = "https://iptorrents.com";
      mam = "https://myanonamouse.net";
      otw = "https://oldtoons.world";
      tl = "https://torrentleech.org";

      bazarr = "https://services.mcgee.network/bazarr";
      git = "https://git.mcgee.red";
      gotify = "https://notifications.mcgee.network";
      media = "https://media.mcgee.network";
      prowlarr = "https://services.mcgee.network/prowlarr";
      qb = "https://services.mcgee.network/qbt";
      radarr = "https://services.mcgee.network/radarr";
      request = "https://request.mcgee.network";
      sonarr = "https://services.mcgee.network/sonarr";
      sonarr-anime = "https://services.mcgee.network/sonarr-anime";
      stats = "https://stats.mcgee.network";
      tdarr = "https://tdarr.mcgee.network";
      wizarr = "https://wizarr.mcgee.network";
    };

    searchEngines = {
      DEFAULT = "https://search.mcgee.red/?q={}&categories=general&language=en-US";

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
      protondb = "https://www.protondb.com/search?q={}";
      python = "https://docs.python.org/3/search.html?q={}";
      qwant = "https://www.qwant.com/?q={}";
      reddit = "https://old.reddit.com/r/{}";
      rust = "https://doc.rust-lang.org/std/index.html?search={}";
      searx = "https://search.mcgee.red/?q={}&categories=general&language=en-US";
      steam = "https://store.steampowered.com/search/?term={}";
      tmuxp = "https://tmuxp.git-pull.com/search.html?q={}&check_keywords=yes&area=default#";
      w = "https://en.wikipedia.org/w/index.php?search={}&title=Special%3ASearch";
      yt = "https://www.youtube.com/results?search_query={}";
    };

    greasemonkey = [
      (pkgs.fetchurl {
        ## MAM FancyFreeleech
        url = "https://gist.githubusercontent.com/WirlyWirly/f13255697e47864b743e8320651e2c18/raw/MAM%2520-%2520FancyFreeleech.user.js";
        sha256 = "sha256-HFs1IhuXWbuaiNjF8laBBvUT4X/S51PIaVSKGL9KkJg=";
      })

      (pkgs.fetchurl {
        ## MAM Plus
        url = "https://raw.githubusercontent.com/gardenshade/mam-plus/master/release/mam-plus.user.js";
        sha256 = "sha256-/vtRui3YA/gFHnoAoCgvPmw1zDVfLGi9WJPFSCNUjQs=";
      })

      (pkgs.fetchurl {
        ## MAM Ratio Protect
        url = "https://update.greasyfork.org/scripts/416189/MAM%20Ratio%20Protect.user.js";
        sha256 = "sha256-UHWUwaVjl9Axl5bb7A0S9d8nYTui0pq9XVcAq5HcDiU=";
      })

      (pkgs.fetchurl {
        ## MAM WedgeWaster
        url = "https://gist.githubusercontent.com/WirlyWirly/e599ca9e293558ec014d0e806914b936/raw/MAM%2520-%2520WedgeWaster.user.js";
        sha256 = "sha256-IXUR3f8uzoh/f4vVSoPNjySQfzCMsP9twXf2Xu7tKjA=";
      })

      (pkgs.fetchurl {
        ## MAM Ignore Torrents
        url = "https://raw.githubusercontent.com/TheRealHumdinger/MAM-Ignore-Torrents/main/MAMIgnoreTorrents.user.js";
        sha256 = "sha256-JlVjON5Z6PmEIXcNdbELkyRsMVHDW6N61ZAjsbFLIFI=";
      })

      (pkgs.fetchurl {
        ## MAM Site Store Fix
        url = "https://update.greasyfork.org/scripts/417852/MAM%20Site%20Store%20Fix.user.js";
        sha256 = "sha256-Lm4qc066fPS0MMO7C5OkJyd+wz3amRx7dDRWndMS5nc=";
      })

      (pkgs.fetchurl {
        ## MAM Total Torrents
        url = "https://update.greasyfork.org/scripts/451080/MAM%20Total%20Torrents.user.js";
        sha256 = "sha256-vvbbCvIJLOAU/1bK5I5h/A/kWib4kkMUjly2wnzcDVA=";
      })

      (pkgs.fetchurl {
        ## MAM Remove Seeding Torrents
        url = "https://update.greasyfork.org/scripts/485525/Remove%20Seeding.user.js";
        sha256 = "sha256-nbtcx6sQnc4ynpEGabvTo3NjiGVQB9J0wbf+Nv2CzMQ=";
      })

      (pkgs.fetchurl {
        ## Mouseover Popup Image Viewer
        url = "https://github.com/tophf/mpiv/raw/master/script.user.js";
        sha256 = "sha256-i/+xsbL5aPgiijFLHA/M7Ex+G+0WORce9LV0myTCYMI=";
      })
    ];
  };
}
