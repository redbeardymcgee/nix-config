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

  officialPluginsSrc = pkgs.fetchgit {
    url = "https://github.com/yazi-rs/plugins.git";
    sparseCheckout = map (p: "${p}.yazi") officialPluginsNames;
    rev = "3783ea0feb98842c09bd6eb75c06f8ab814050e2";
    hash = "sha256-rzt4r7zIC9GdYafetOF3oCThbtymmoDHTuZ6H2r/ui4=";
  };

  officialPlugins = lib.lists.fold (a: b: {${a} = "${officialPluginsSrc}/${a}.yazi";} // b) {} officialPluginsNames;
in
  with pkgs;
    officialPlugins
    // {
      # UI
      # yaziline = fetchFromGitHub {
      #   owner = "llanosrocas";
      #   repo = "yaziline.yazi";
      #   rev = "b22e2e8962c6fc8a27f8510a29a186b764577c1a";
      #   hash = "sha256-kLK4EvECzE43cAVcdHGhKvbJ+pS0jvd2ggW5XTq7jWc=";
      # };
      #^ UI

      # Features
      augment-command = fetchFromGitHub {
        owner = "hankertrix";
        repo = "augment-command.yazi";
        rev = "3268704750711db2c23ae79dc916e4b488dc4a9f";
        hash = "sha256-7QLdMEUSCJVh9avOa7dboWg8lZs1J3XGcaXdScJ/lyU=";
      };

      searchjump = fetchgit {
        url = "https://gitee.com/DreamMaoMao/searchjump.yazi";
        rev = "520f34d4f29460005710da8ffec2da473212841f";
        hash = "sha256-aZcz63x0c0+ZnA2UrmraLYrH+RG4aF8c9G3LD4owH4c=";
      };

      yamb = fetchFromGitHub {
        owner = "h-hg";
        repo = "yamb.yazi";
        rev = "3636c80f94448347f8047cfbfc1ca6099dcd4d71";
        hash = "sha256-81rrxjdWlpICQ12EfOcvXpvnWXeWgA5GYBfoHXxBe1g=";
      };
      #^ Features

      # Previewers
      allmytoes = fetchFromGitHub {
        owner = "Sonico98";
        repo = "allmytoes.yazi";
        rev = "e5329138a19615e63bff6a581eb69d1d1eb5d4fe";
        hash = "sha256-S9O8jgTjdOxf/Zybmgm7nGBkd2Ipt2DtQ+Be2uawyNA=";
      };

      exifaudio = fetchFromGitHub {
        owner = "Sonico98";
        repo = "exifaudio.yazi";
        rev = "94329ead8b3a6d3faa2d4975930a3d0378980c7a";
        hash = "sha256-jz6fVtcLHw9lsxFWECbuxE7tEBttE08Fl4oJSTifaEc=";
      };

      glow = fetchFromGitHub {
        owner = "Reledia";
        repo = "glow.yazi";
        rev = "536185a4e60ac0adc11d238881e78678fdf084ff";
        hash = "sha256-NcMbYjek99XgWFlebU+8jv338Vk1hm5+oW5gwH+3ZbI=";
      };

      hexyl = fetchFromGitHub {
        owner = "Reledia";
        repo = "hexyl.yazi";
        rev = "64daf93a67d75eff871befe52d9013687171ffad";
        hash = "sha256-B2L3/Q1g0NOO6XEMIMGBC/wItbNgBVpbaMMhiXOYcrI=";
      };

      miller = fetchFromGitHub {
        owner = "Reledia";
        repo = "miller.yazi";
        rev = "75f00026a0425009edb6fedcfbe893f3d2ddedf4";
        hash = "sha256-u8xadj6/s16xXUAWGezYBqnygKaFMnRUsqtjMDr6DZA=";
      };

      ouch = fetchFromGitHub {
        owner = "ndtoan96";
        repo = "ouch.yazi";
        rev = "fe6b0a60ce6b7b9a573b975fe3c0dfc79c0b2ac6";
        hash = "sha256-Sc0TGzrdyQh61Pkc2nNUlk8jRLjVNaCJdFqZvgQ/Cp8=";
      };

      torrent-preview = fetchFromGitHub {
        owner = "kirasok";
        repo = "torrent-preview.yazi";
        rev = "76970b6f9d6f3031e9cd57c8595a53e9f9f48c18";
        hash = "sha256-QPdtoCU7CyS7sx1aoGHNHv1NxWMA/SxSuy+2SLDdCeU=";
      };
      #^ Previewers
    }
