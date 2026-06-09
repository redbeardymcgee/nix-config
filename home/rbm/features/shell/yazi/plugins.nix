{
  lib,
  pkgs,
  ...
}: let
  officialPluginsNames = [
    "chmod"
    "diff"
    "full-border"
    "smart-filter"
  ];

  officialPluginsSrc = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "600614a9dc59a12a63721738498c5541c7923873";
    hash = "sha256-cdPeIhtTzSYhJZ3v3Xlq8J3cOmR7ZiOGl5q48Qgthyk=";
  };

  officialPlugins = lib.lists.fold (a: b: {${a} = "${officialPluginsSrc}/${a}.yazi";} // b) {} officialPluginsNames;
in
  with pkgs;
    officialPlugins
    // {
      augment-command = fetchFromGitHub {
        owner = "hankertrix";
        repo = "augment-command.yazi";
        rev = "6a367dbdfc4c2f1247ed516f5f3db31345f6865d";
        hash = "sha256-Jp/isfUNDM08EdZCKgZKNFwkPubzQSUdQYt/u5hx77E=";
      };
      allmytoes = fetchFromGitHub {
        owner = "sonico98";
        repo = "allmytoes.yazi";
        rev = "a9870513d935680c2d59da7d59b3f91660e2729d";
        hash = "sha256-ZV7WB5ylYzmC98ORP2Cb5aO6l6vwGEnYsZhHGSPQdIQ=";
      };
      exifaudio = fetchFromGitHub {
        owner = "sonico98";
        repo = "exifaudio.yazi";
        rev = "d7946141c87a23dcc6fb3b2730a287faf3154593";
        hash = "sha256-nXBxPG6PVi5vstvVMn8dtnelfCa329CTIOCdXruOxT4=";
      };
      glow = fetchFromGitHub {
        owner = "reledia";
        repo = "glow.yazi";
        rev = "5ce76dc92ddd0dcef36e76c0986919fda3db3cf5";
        hash = "sha256-UljcrXXO5DZbufRfavBkiNV3IGUNct31RxCujRzC9D4=";
      };
      hexyl = fetchFromGitHub {
        owner = "reledia";
        repo = "hexyl.yazi";
        rev = "39d3d4e23ad7cec8888f648ddf55af4386950ce7";
        hash = "sha256-nsnnL3GluKk/p1dQZTZ/RwQPlAmTBu9mQzHz1g7K0Ww=";
      };
      miller = fetchFromGitHub {
        owner = "reledia";
        repo = "miller.yazi";
        rev = "40e02654725a9902b689114537626207cbf23436";
        hash = "sha256-GXZZ/vI52rSw573hoMmspnuzFoBXDLcA0fqjF76CdnY=";
      };
      ouch = fetchFromGitHub {
        owner = "ndtoan96";
        repo = "ouch.yazi";
        rev = "b8698865a0b1c7c1b65b91bcadf18441498768e6";
        hash = "sha256-eRjdcBJY5RHbbggnMHkcIXUF8Sj2nhD/o7+K3vD3hHY=";
      };
      torrent-preview = fetchFromGitHub {
        owner = "kirasok";
        repo = "torrent-preview.yazi";
        rev = "c9e67df81cb62759bd84a2fad5a0d9b6713bd595";
        hash = "sha256-GKUQaZtywigV6NAd6pjYRYl4UsUKeJHaBTLpMG7xxME=";
      };
      yamb = fetchFromGitHub {
        owner = "h-hg";
        repo = "yamb.yazi";
        rev = "108347b0392fc819af04506dd0405fb744dfca68";
        hash = "sha256-/BU/jVWgLK7JmPQpCHXhPCH+LrLy7RIYyIX0TYbTpuk=";
      };
      lazygit = fetchFromGitHub {
        owner = "Lil-Dank";
        repo = "lazygit.yazi";
        rev = "c82794fb410cca36b23b939d32126a6a9705f94d";
        hash = "sha256-m2zITkjGrUjaPnzHnnlwA6d4ODIpvlBfIO0RZCBfL0E=";
      };
    }
