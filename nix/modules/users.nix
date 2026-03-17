{ pkgs, ... }:

{
  users.users.ognev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  users.defaultUserShell = pkgs.fish;
}
