{
  programs.iamb = {
    enable = true;

    settings = {
      profiles.rbm = {
        user_id = "@redbeardy_mcgee:matrix.org";
      };
      layout = {
        style = "restore";
      };
      settings = {
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
