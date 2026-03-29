{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    # ===[ Git Lab ]===

    virtualHosts."chlenify.ru" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-Ssl on;
        '';
      };

      locations."/socket" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-Ssl on;
        '';
      };
    };

    # ===[ Git Lab ]===

    virtualHosts."git.osfb.dev" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-Ssl on;
        '';
      };
    };

    virtualHosts."registry.git.osfb.dev" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:5050";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-Ssl on;
          client_max_body_size 200M;
        '';
      };
    };

    virtualHosts."test.osfb.dev" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:5000";
        proxyWebsockets = true;
      };
    };

    # ===[ Culty ]===
    virtualHosts."culty.space" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8081";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-Ssl on;
        '';
      };

      locations."/api" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_ssl_server_name on;
          proxy_pass_header Authorization;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-Ssl on;
        '';
      };
    };
  };
}
