{
  boot.kernelParams = [
    "video=DP-8:1920x1080@60"
    "video=DP-7:1280x800@60"
  ];

  services.sunshine = let
    asus = "ASUSTek COMPUTER INC VG27AQ3A T6LMAV005817";
  in {
    enable = true;
    autoStart = true;
    capSysAdmin = false;
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
            undo = "riverctl focus-output DP-4";
          }

          {
            do = "riverctl set-focused-tags 256";
            undo = "riverctl set-focused-tags 1";
          }

          {
            # do = "steam -shutdown";
            undo = "steam -shutdown";
          }

          {
            do = "riverctl enter-mode passthrough";
            undo = "riverctl enter-mode normal";
          }

          {
            undo = "systemctl --user restart way-displays";
          }
        ];

      ## Input
      back_button_timeout = 3000;

      ## Audio/Video
      output_name = 1;
      virtual_sink = "sink-sunshine-stereo";
    };

    applications = {
      apps = let
        bigPicture = width: height:
        ## FIXME: gamescope crashes when launched with any program
        # "setsid gamescope -W ${toString width} -H ${toString height} -- gamemoderun steam -bigpicture"
        "setsid gamemoderun steam -bigpicture";
        enableDisableOutput = output: [
          {
            do = "way-displays --delete DISABLED ${output}";
          }

          {
            do = "riverctl focus-output ${output}";
          }
        ];
      in [
        {
          name = "FHD";
          image = "desktop.png";
          ## FIXME: Virtual displays seem to be missing
          # prep-cmd = enableDisableOutput "DP-8";
          prep-cmd = [
            {
              do = "riverctl focus-output DP-4";
            }

            {
              do = "riverctl set-focused-tags 256";
            }

            {
              do = ''sh -c 'way-displays -s mode "${asus}" 1920 1080 60'';
            }
          ];
          detached = [(bigPicture 1280 800)];
        }

        {
          name = "Deck";
          image = "steam.png";
          ## FIXME: Virtual displays seem to be missing
          # prep-cmd = enableDisableOutput "DP-7";
          prep-cmd = [
            {
              do = ''sh -c "way-displays -s mode '${asus}' 1280 720 60" '';
            }
          ];
          detached = [(bigPicture 1280 800)];
        }
      ];
    };
  };
}
