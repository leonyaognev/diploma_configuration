{ lib, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowedUDPPorts = [ ];

  services.fail2ban.enable = true;

  services.fail2ban.jails.sshd = {
    settings = {
      enabled = true;
      port = "ssh";
      filter = "sshd";
      logpath = "/var/log/auth.log";
      maxretry = 5;
      bantime = "1h";
    };
  };
}
