{pkgs, ...}: {
  systemd.user.services.mpris-proxy = {
    Unit = {
      Description = "Mpris proxy";
    };
    Install = {
      After = ["network.target" "sound.target"];
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      Restart = "on-failure";
      Type = "exec";
    };
    startServices = "sd-switch";
  };
}
