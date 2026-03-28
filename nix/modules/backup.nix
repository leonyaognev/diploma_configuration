{ config, inputs, pkgs, sopsFile, ... }:

{
  imports =
    [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    age.keyFile = "../sops/keys.txt";
    defaultSopsFile = sopsFile;
    secrets = {
      "restic/repo_password" = { };
      "restic/server_url" = { };
    };
  };

  services.restic.backups.localtest = {
    initialize = true;

    paths = [
      "/tb_storage/gitlab"
    ];
    passwordFile = config.sops.secrets."restic/repo_password".path;
    repositoryFile = config.sops.secrets."restic/server_url".path;


    pruneOpts = [
      "--keep-daily 2"
    ];
    timerConfig = {
      OnCalendar = "hourly";
    };
  };
}
