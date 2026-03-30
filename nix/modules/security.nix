{ lib, sopsFile, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 8000 8080 ];
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

  security.acme = {
    acceptTerms = true;
    defaults.email = "penguin.ognev@gmail.com";
  };

  sops = {
    age.keyFile = "/etc/sops-key.txt";
    age.generateKey = true;
    defaultSopsFile = sopsFile;
    secrets = {
      "restic/repo_password" = { };
      "restic/server_url" = { };
      "grafana/grafana_password" = { };
      "grafana/influx_DB_Token" = { };
    };
  };
}
