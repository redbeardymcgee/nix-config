{
  programs.vdirsyncer = {
    enable = true;
  };

  services.vdirsyncer = {
    enable = true;
  };

  accounts.contact.accounts = {
    nextcloud.vdirsyncer = {
      enable = true;
    };
  };
}
