{pkgs, ...}: {
  systemd.user.services.mpris-proxy = {
    Unit = {
      Description = "Mpris proxy";
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      Restart = "on-failure";
      Type = "exec";
    };
  };
}
