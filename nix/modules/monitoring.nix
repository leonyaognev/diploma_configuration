{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "grafana" ];
    ensureUsers = [
      {
        name = "grafana";
        ensureDBOwnership = true;
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      server.http_addr = "0.0.0.0";
      database = {
        type = "postgres";
        host = "/run/postgresql";
        user = "grafana";
        name = "grafana";
      };
      security = {
        admin_user = "admin";
        admin_password = config.sops.secrets."grafana/grafana_password".path;
        cookie_secure = true;
        cookie_samesite = "strict";
        content_security_policy = true;
        content_security_policy_template = ''
          script-src 'self' 'unsafe-eval' 'unsafe-inline' 'strict-dynamic' $NONCE;object-src 'none';font-src 'self';style-src 'self' 'unsafe-inline' blob:;img-src * data:;base-uri 'self';connect-src 'self' grafana.com ws://$ROOT_PATH wss://$ROOT_PATH;manifest-src 'self';media-src 'none';form-action 'self';
        '';
        secret_key = "SW2YcwTIb9zpOOhoPsMm";
      };
      analytics.reporting_enabled = false;
      "auth.anonymous".hide_version = true;
    };
    provision = {
      enable = true;
      dashboards.settings = {
        apiVersion = 1;
        providers = [
          {
            name = "default";
            options.path = ./grafana;
          }
        ];
      };
      datasources.settings = {
        apiVersion = 1;
        datasources = [
          {
            name = "InfluxDB";
            type = "influxdb";
            uid = "influxdb2";
            access = "proxy";
            url = "http://localhost:8086";
            secureJsonData = {
              token = "$__file{${influxDBTokenPath}}";
            };
            jsonData = {
              version = "Flux";
              organization = "home";
              defaultBucket = "hass";
              tlsSkipVerify = true;
            };
          }
        ];
      };
    };
  };
}
