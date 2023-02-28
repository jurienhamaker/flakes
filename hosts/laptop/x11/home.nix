{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    # [ (import ../../../modules/desktop/bspwm/home.nix) ] ++
    [ (import ../../../modules/desktop/xmonad/home.nix) ] ++
    [ (import ../../../modules/scripts) ] ++
    (import ../../../modules/shell) ++
    (import ../../../modules/editors) ++
    (import ../../../modules/programs/x11) ++
    (import ../../../modules/theme/nord/x11) ++
    (import ../../../modules/devlop);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    file = {
      ".ssh/id_rsa.pub".source = ../../secrets/id_rsa.pub;
    };
  };

  home.activation.copySSHKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
      install -D -m600 ${../../secrets/id_rsa} $HOME/.ssh/id_rsa
  '';
  home.activation.authorizedKeys = lib.hm.dag.entryAfter ["writeBoundary"] ''
      install -D -m600 ${../../secrets/id_rsa.pub} $HOME/.ssh/authorized_keys
  '';

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
