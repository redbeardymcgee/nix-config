{
  programs.iamb = {
    enable = true;

    settings = {
      default_profile = "rbm";
      profiles.rbm = {
        user_id = "@redbeardy_mcgee:matrix.org";
      };
      layout = {
        style = "restore";
      };
      settings = {
        default_room = "#podman:matrix.org";
        image_preview = {
          protocol = {
            type = "kitty";
          };
        };
        typing_notice_send = false;
      };
    };
  };
}
