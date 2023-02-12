{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/dwm-variables.nix)
  ];
  services.wlsunset.systemdTarget = ''
    graphical-session.target
  '';
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  startx
        fi
      '';
    };
  };
  home.file = {
    ".xinitrc".text = ''
      if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval $(dbus-launch --exit-with-session --sh-syntax)
      fi
      systemctl --user import-environment DISPLAY XAUTHORITY
      if command -v dbus-update-activation-environment >/dev/null 2>&1; then
       dbus-update-activation-environment DISPLAY XAUTHORITY
      fi
       ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
         Xcursor.theme: Catppuccin-Frappe-Dark
        ''}
      exec dwm 
    '';
  };
}
