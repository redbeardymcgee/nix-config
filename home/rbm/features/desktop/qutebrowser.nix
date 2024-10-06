{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-cli
    keyutils
  ];

  programs.qutebrowser = {
    enable = true;

    greasemonkey = [
      (pkgs.fetchFromGitHub {
        owner = "pparker1930";
        repo = "TwitterYoutubeHelper";
        rev = "ad4c9df258802d83c9f5a7d15a2d943852781fd8";
        hash = "sha256-XlECtKJKwAC0zARlPHkxJsJJlMVPySvQYbG/QaBz8fc=";
      })
      (pkgs.fetchFromGitHub {
        owner = "iamfugui";
        repo = "youtube-adb";
        rev = "dc0eaad136e8db36ebe6b9aca71045af00b606dd";
        hash = "sha256-6s5OS3AzzF/CkYRV3Eblw3CQ+nXhwdHcCZMlyx0XCPU=";
      })
    ];

    keyBindings = {
      normal = {
        ",p" = "spawn --userscript qute-bitwarden -d 'wofi -d -p Bitwarden' -p 'wofi -d -P'";
        ",m" = "hint links spawn umpv {hint-url}";
        ",M" = "hint --rapid links spawn umpv {hint-url}";
      };
    };

    searchEngines = {
      DEFAULT = "https://www.qwant.com/?q={}";
      amazon = "https://www.amazon.com/s/?field-keywords={}";
      crates = "https://crates.io/search?q={}";
      ddg = "https://duckduckgo.com/html?q={}";
      deb = "https://packages.debian.org/search?keywords={}&searchon=names&suite=all&section=all";
      fdroid = "https://search.f-droid.org/?q={}";
      flathub = "https://flathub.org/apps/search?q=%s";
      github = "https://github.com/search?utf8=%E2%9C%93&q={}&ref=simplesearch";
      nixoptions = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      nixwiki = "https://wiki.nixos.org/w/index.php?search={}&title=Special%3ASearch&wprov=acrw1_-1";
      nixpkgs = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      homemanager = "https://home-manager-options.extranix.com/?query={}&release=master";
      gentoo = "https://wiki.gentoo.org/index.php?title=Special%3ASearch&profile=default&search={}&fulltext=Search";
      imdb = "https://www.imdb.com/find?q={}";
      javascript = "https://developer.mozilla.org/en-US/search?q={}&topic=api&topic=js";
      npm = "https://www.npmjs.com/search?q={}";
      maps = "https://www.openstreetmap.org/search?query={}";
      protondb = "https://www.protondb.com/search?q={}";
      python = "https://docs.python.org/3/search.html?q={}";
      qwant = "https://www.qwant.com/?q={}";
      reddit = "https://old.reddit.com/r/{}";
      rust = "https://doc.rust-lang.org/std/index.html?search={}";
      searx = "https://searx.me/?q={}&categories=general&language=en-US";
      steam = "https://store.steampowered.com/search/?term={}";
      tmuxp = "https://tmuxp.git-pull.com/search.html?q={}&check_keywords=yes&area=default#";
      openproject = "https://openproject.mcgee.network/search?q={}&work_packages=1&scope=all";
      wikipedia = "https://en.wikipedia.org/w/index.php?search={}&title=Special%3ASearch";
      youtube = "https://www.youtube.com/results?search_query={}";
    };

    settings = {
      colors.webpage = {
        darkmode.enabled = true;
        preferred_color_scheme = "dark";
      };
      content.site_specific_quirks.enabled = true;
      hints.mode = "number";
      keyhint.delay = 300;
      new_instance_open_target = "window";
      scrolling.smooth = true;
      statusbar.show = "in-mode";
      tabs.show = "never";
      url = {
        open_base_url = true;
        start_pages = [
          "https://qwant.com"
        ];
      };
      window.hide_decoration = true;
    };
  };
}
