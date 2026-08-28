{ self, inputs, ... }: {
  flake.nixosModules.mainFrameConfiguration = { config, pkgs, ... }: {
    imports = [
      self.nixosModules.mainFrameHardwareConfiguration

      self.nixosModules.boot
      self.nixosModules.security
      self.nixosModules.users
      self.nixosModules.packages
      self.nixosModules.nginx
      self.nixosModules.backup
      self.nixosModules.homeManager
    ];

    networking.hostName = "nixos-virtual";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Moscow";

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

    swapDevices = [
      {
        device = "/swapfile";
      }
    ];

    system.stateVersion = "24.05"; # DO NOT TOUCH
  };
}
