{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."osfb.dev" = {
      listen = [ 80 ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8000";
        proxySetHeader = {
          Host = "$host";
          X-Real-IP = "$remote_addr";
          X-Forwarded-For = "$proxy_add_x_forwarded_for";
          X-Forwarded-Proto = "$scheme";
        };
      };
    };
  };
}
