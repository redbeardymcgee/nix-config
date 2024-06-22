{
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;

  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  # hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
    };

    # hostKeys = [
    #   {
    #     path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
    #     type = "ed25519";
    #   }
    # ];
  };

  programs.ssh = {
    knownHosts = lib.genAttrs hosts (hostname: {
      publicKeyFile = ../../${hostname}/ed25519_key.pub;
      extraHostNames =
        [
          "${hostname}.home.local"
        ]
        ++
        # Alias for localhost if it's the same host
        (lib.optional (hostname == config.networking.hostName) "localhost") ;
    });
  };

  # Passwordless sudo when SSH'ing with keys
  security = {
    pam.services.sudo = {config, ...}: {
    sudo.extraConfig = ''
      Defaults env_keep+=SSH_AUTH_SOCK
    '';
    rules.auth.rssh = {
      order = config.rules.auth.ssh_agent_auth.order - 1;
      control = "sufficient";
      modulePath = "${pkgs.pam_rssh}/lib/libpam_rssh.so";
      settings.authorized_keys_command =
        pkgs.writeShellScript "get-authorized-keys"
        ''
          cat "/etc/ssh/authorized_keys.d/$1"
        '';
      };
    };
  };
}
