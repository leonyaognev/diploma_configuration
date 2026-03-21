{ config, pkgs, ... }:

{
  home.username = "ognev";
  home.homeDirectory = "/home/ognev";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
