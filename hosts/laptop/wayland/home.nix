{ config, lib, pkgs, user, impermanence, ... }:

{
  imports =
    # [ (import ../../../modules/desktop/sway/home.nix) ] ++
    [ (import ../../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../../modules/scripts) ] ++
    (import ../../../modules/shell) ++
    (import ../../../modules/editors) ++
    (import ../../../modules/programs/wayland) ++
    # (import ../../../modules/theme/catppuccin-dark/wayland) ++
    # (import ../../../modules/theme/catppuccin-light/wayland) ++
    # (import ../../../modules/theme/nord/wayland) ++
    (import ../../../modules/theme/yugen/wayland) ++
    (import ../../../modules/devlop);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    file = {
      ".ssh/id_rsa.pub".source = ../../../secrets/id_rsa.pub;
    };
  };

  home.activation.copySSHKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
      install -D -m600 ${../../../secrets/id_rsa} $HOME/.ssh/id_rsa
  '';
  home.activation.authorizedKeys = lib.hm.dag.entryAfter ["writeBoundary"] ''
      install -D -m600 ${../../../secrets/id_rsa.pub} $HOME/.ssh/authorized_keys
  '';
  
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
