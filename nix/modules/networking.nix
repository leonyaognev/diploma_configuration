{ lib, ... }:

{
  networking.hostName = "nixos-virtual";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Novosibirsk";
}
