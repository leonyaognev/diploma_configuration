{ config, pkgs, ... }:

let
  influxTokenPath = "/etc/influxdb/grafana.token";
in
{
  services.influxdb = {
    enable = true;
    package = pkgs.influxdb_2;

    config = {
      http.bind-address = ":8086";
      auth-enabled = true;
      initial-username = "grafana";
      initial-password = "supersecret";
      initial-org = "home";
      initial-bucket = "hass";
      token-file = influxTokenPath;
      report-disabled = true;
    };
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
        admin_password = "supersecret_admin"; # sops
      };
      analytics.reporting_enabled = false;
    };

    provision = {
      enable = true;
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
              token = "$__file{${influxTokenPath}}";
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
