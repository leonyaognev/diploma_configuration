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
      settings = {
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = false;
        ChallengeResponseAuthentication = false;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
      };
    };

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  documentation.man.enable = false;
  documentation.info.enable = false;
  documentation.doc.enable = false;

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    webuiPort = 8372;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 8d";
    };
  };

  environment.systemPackages = with pkgs; [
    mesa
    mesa.drivers
    vulkan-tools
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    host = "0.0.0.0";
  };

  swapDevices = [
    {
      device = "/swapfile";
    }
  ];
}
