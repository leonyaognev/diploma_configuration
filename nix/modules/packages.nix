{ pkgs, inputs, ... }:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    ranger
    gnumake
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
    dysk
    restic
    sops
    age
    amneziawg-tools
    amneziawg-go
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
