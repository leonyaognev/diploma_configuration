{ inputs, ... }: {
  flake.nixosModules.packages = { pkgs, ... }: {
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
      vulkan-tools
      mesa-demos
      radeontop
      iperf3
      inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
      wget
      curl
    ];

    documentation.man.enable = false;
    documentation.info.enable = false;
    documentation.doc.enable = false;
  };
}