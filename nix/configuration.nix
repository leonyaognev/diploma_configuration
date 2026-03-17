{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.ognev = import ./home.nix;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-virtual";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Novosibirsk";

  services.libinput.enable = true;
  services.openssh.enable = true;
  virtualisation.docker.enable = true;


  users.users.ognev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  programs.fish = {
    enable = true;
  };

  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    ranger
    curl
    git
    python3
    uv
    tmux
    ripgrep
    fzf
    fish
    zoxide
    gcc
    zip
    unzip
    eza
    bash
    pokemon-colorscripts
    fastfetch
    neofetch
    killall
    htop
    btop
    ncdu
    kitty
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 8d";
    };
  };
}
