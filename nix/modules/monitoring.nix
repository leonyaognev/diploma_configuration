{ config, pkgs, ... }:

{
  services.grafana = {
    enable = true;
    package = pkgs.grafana;
    adminUser = "admin";
    adminPassword = "penis";
    enableLoginForm = true;
    httpPort = 3000;
  };
}
