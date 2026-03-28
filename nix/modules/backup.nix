{ config, pkgs, ... }:

{
  services.restic.backups.localtest = {
    initialize = true;

    # ЧТО бэкапим
    paths = [
      "/tb_storage/gitlab"
    ];

    # КУДА бэкапим (локальная папка)
    repository = "/tb_storage/backup-gitlab";

    # Пароль (да, прямо в конфиге, тебе же “пофиг на безопасность”)
    password = "1234";

    # Как часто
    timerConfig = {
      OnCalendar = "hourly"; # можно daily, weekly, etc
    };
  };
}
