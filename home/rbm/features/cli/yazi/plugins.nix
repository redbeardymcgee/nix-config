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
    rev = "38418ddc9247de206645ed284c804b5e179452a1";
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
        rev = "fe145acca9ef83be3756444d37ff7fa764eaab59"; hash = "sha256-Bwi2KMvsoYajzzBsGgY8jDr9QPEP9vZXSNWf0ZZyd+Y=";
      };
      allmytoes = fetchFromGitHub {
        owner = "sonico98";
        repo = "allmytoes.yazi";
        rev = "e5329138a19615e63bff6a581eb69d1d1eb5d4fe";
        hash = "sha256-S9O8jgTjdOxf/Zybmgm7nGBkd2Ipt2DtQ+Be2uawyNA=";
      };
      exifaudio = fetchFromGitHub {
        owner = "sonico98";
        repo = "exifaudio.yazi";
        rev = "855ff055c11fb8f268b4c006a8bd59dd9bcf17a7";
        hash = "sha256-8f1iG9RTLrso4S9mHYcm3dLKWXd/WyRzZn6KNckmiCc=";
      };
      glow = fetchFromGitHub {
        owner = "reledia";
        repo = "glow.yazi";
        rev = "388e847dca6497cf5903f26ca3b87485b2de4680";
        hash = "sha256-fKJ5ld5xc6HsM/h5j73GABB5i3nmcwWCs+QSdDPA9cU=";
      };
      hexyl = fetchFromGitHub {
        owner = "reledia";
        repo = "hexyl.yazi";
        rev = "ccc0a4a959bea14dbe8f2b243793aacd697e34e2";
        hash = "sha256-9rPJcgMYtSY5lYnFQp3bAhaOBdNUkBaN1uMrjen6Z8g=";
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
        rev = "db1488358941a2bc9918fa91c304d6724a0bb608";
        hash = "sha256-fEfsHEddL7bg4z85UDppspVGlfUJIa7g11BwjHbufrE=";
      };
      torrent-preview = fetchFromGitHub {
        owner = "kirasok";
        repo = "torrent-preview.yazi";
        rev = "76970b6f9d6f3031e9cd57c8595a53e9f9f48c18";
        hash = "sha256-QPdtoCU7CyS7sx1aoGHNHv1NxWMA/SxSuy+2SLDdCeU=";
      };
      yamb = fetchFromGitHub {
        owner = "h-hg";
        repo = "yamb.yazi";
        rev = "0598b8defc21ac7231e584115c3aa330f0310db4";
        hash = "sha256-Mw+CUyy8sN76NJNy+Xt0HwH6tD/gxqNvyIYKqpWUKMs=";
      };
      lazygit = fetchFromGitHub {
        owner = "Lil-Dank";
        repo = "lazygit.yazi";
        rev = "c82794fb410cca36b23b939d32126a6a9705f94d";
        hash = "sha256-m2zITkjGrUjaPnzHnnlwA6d4ODIpvlBfIO0RZCBfL0E=";
      };
    }
