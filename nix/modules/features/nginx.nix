{ ... }: {
  flake.nixosModules.nginx = { config, pkgs, ... }: {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;

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

      virtualHosts."torrent.osfb.dev" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:8372";
          proxyWebsockets = true;
        };
      };

      virtualHosts."matrix.osfb.dev" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:8008";
          proxyWebsockets = true;
        };
      };

      virtualHosts."web.matrix.osfb.dev" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:8083";
          proxyWebsockets = true;
        };
      };

      virtualHosts."cloud.osfb.dev" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:9090";
          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 5G;
          '';
        };
      };
    };
  };
}
