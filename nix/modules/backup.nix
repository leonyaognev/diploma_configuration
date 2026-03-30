{ config, inputs, pkgs, ... }:

{
  imports =
    [ inputs.sops-nix.nixosModules.sops ];

  services.restic.backups.localtest = {
    initialize = true;

    paths = [
      "/tb_storage/gitlab"
    ];
    passwordFile = config.sops.secrets."restic/repo_password".path;
    repositoryFile = config.sops.secrets."restic/server_url".path;


    pruneOpts = [
      "--keep-hourly 24"
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 3"
    ];
    timerConfig = {
      OnCalendar = "hourly";
    };
  };
}
