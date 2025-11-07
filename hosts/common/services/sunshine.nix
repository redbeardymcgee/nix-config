{
  services.sunshine = let
    asus = "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817";
  in {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    settings = {
      ## General
      global_prep_cmd =
        builtins.toJSON
        [
          {
            do = "riverctl focus-output DP-4";
          }
          {
            do = "riverctl set-focused-tags 256";
            undo = "riverctl set-focused-tags 1";
          }
          {
            do = ''sh -c "way-displays -d scale '${asus}'"'';
            undo = ''sh -c "way-displays -s scale '${asus}' 1.5"'';
          }
        ];

      ## Input
      back_button_timeout = 3000;

      ## Audio/Video
      output_name = 1;
    };

    applications = {
      apps = let
        res = width: height: refresh: [
          {
            do = ''sh -c "way-displays -s mode '${asus}' ${toString width} ${toString height} ${toString refresh}"'';
            undo = ''sh -c "way-displays -s mode '${asus}' 2560 1440 180"'';
          }
        ];
        bigPicture = ["setsid steam steam://open/bigpicture"];
      in [
        {
          name = "FHD";
          image = "desktop.png";
          prep-cmd = res 1920 1080 60;
          detached = bigPicture;
        }

        {
          name = "Deck";
          image = "steam.png";
          prep-cmd = res 1280 800 60;
          detached = bigPicture;
        }
      ];
    };
  };
}
