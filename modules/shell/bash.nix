{ pkgs, ... }:
{
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        # if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        #    exec dbus-run-session sway --unsupported-gpu
        #  fi
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec dbus-run-session Hyprland
         fi
      '';
      shellAliases = {
        p = "cd /mnt/Programming";
        e_up = "p; cd employes; docker-compose up app";
        e_bash = "p; cd employes; docker-compose exec app bash";
        ec_up = "p; cd employes; docker-compose up capacitor";
        ec_bash = "p; cd employes; docker-compose exec capacitor bash";
        ew_up = "p; cd employes; docker-compose up web";
        ew_bash = "p; cd employes docker-compose exec web bash";
        eo_up = "p; cd employes; docker-compose up office";
        eo_bash = "p; cd employes; docker-compose exec office";
        es_up = "p; cd employes-style; docker-compose up";
        es_bash = "p; cd employes-style; docker-compose exec style";
        p_up = "p; cd paperless; docker-compose up storybook";
        p_bash = "p; cd paperless; docker-compose exec storybook bash";
        p_act = "p; cd paperless; act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04";
        pn_up = "p; cd paperless; docker-compose up ng-playground";
        pn_bash = "p; cd paperless; docker-compose exec ng-playground bash";
        nrs = "cd ~/Flakes; sudo nixos-rebuild switch --flake '.?submodules=true#laptop'";
      };
    };
  };
}