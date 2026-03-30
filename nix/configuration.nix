{ config, lib, pkgs, inputs, sopsFile, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/boot.nix
      ./modules/networking.nix
      ./modules/security.nix
      ./modules/users.nix
      ./modules/packages.nix
      ./modules/nginx.nix
      ./modules/backup.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.ognev = import ./home/home.nix;

  services.libinput.enable = true;
  services.openssh =
    {
      enable = true;
      ports = [ 8822 ];
    };

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  documentation.man.enable = false;
  documentation.info.enable = false;
  documentation.doc.enable = false;

  programs.amnezia-vpn.enable = true;

  systemd.services.amnezia-vpn = {
    description = "AmneziaVPN Service";
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.amnezia-vpn}/bin/AmneziaVPN-service";
      Restart = "always";
      User = "ognev";
    };
    wantedBy = [ "multi-user.target" ];
  };

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    user = "ognev";
    group = "users";
    webuiPort = 8372;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 8d";
    };
  };
}
