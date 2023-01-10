{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      weston
    ];
  };
  home.file = {
    ".config/weston.ini".text = ''
          [libinput]
          enable-tap=true
          natural-scroll=true
          [shell]
          panel-position=none
          background-image=/home/jurien/.config/weston/background.jpg
        '';
        ".config/weston/background.jpg".source = ./background.jpg;
  };
}