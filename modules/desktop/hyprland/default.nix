{ config, lib, pkgs, inputs, ... }:

let
  default_wall = pkgs.writeShellScript "default_wall" ''
    killall dynamic_wallpaper
    ${pkgs.swww}/bin/swww img "${../../theme/yugen/common/wall/default.png}"
  '';
in

{
  imports = [ ../../programs/wayland/waybar/hyprland_waybar.nix ];

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    swww
    swaylock-effects
    pamixer
  ];

  systemd.user.services.swww = {
    description = "Efficient animated wallpaper daemon for wayland";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    before = [ "default_wall.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.swww}/bin/swww-daemon
      '';
      ExecStop = "${pkgs.swww}/bin/swww kill";
      Restart = "on-failure";
    };
  };
  systemd.user.services.default_wall = {
    description = "default wallpaper";
    requires = [ "swww.service" ];
    after = [ "swww.service" "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    script = ''${default_wall}'';
    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
    };
  };


  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

}
