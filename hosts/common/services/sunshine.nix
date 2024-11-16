{
# networking.firewall = {
#   enable = true;
#   allowedTCPPorts = [ 47984 47989 47990 48010 ];
#   allowedUDPPortRanges = [
#     { from = 47998; to = 48000; }
#     { from = 8000; to = 8010; }
#   ];
# };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    # settings = {
    #   sunshine_name = "arcturus";
    #   back_button_timeout = 2000;
    # };
  };
}
