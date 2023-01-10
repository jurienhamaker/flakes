{ config, lib, pkgs, user, secrets, impermanence, ... }:

with import <home-manager/modules/lib/dag.nix> { inherit lib; };

{
  imports =
    # [ (import ../../modules/desktop/sway/home.nix) ] ++
    [ (import ../../modules/desktop/hyprland/home.nix) ] ++
    [ (import ../../modules/scripts/home.nix) ] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    (import ../../modules/theme) ++
    (import ../../modules/devlop);

  home = {
    username = "jurien";
    homeDirectory = "/home/jurien";
    file = {
      ".ssh/id_rsa".text = secrets.jurien.sshKeys.private;
      ".ssh/id_rsa.pub".source = ../../secrets/id_rsa.pub;
    };
  };

  home.activation.copySSHKey = dagEntryAfter ["writeBoundary"] ''
      install -D -m600 ${../../secrets/id_rsa} $HOME/.ssh/id_rsa
  '';

  home.activation.authorizedKeys = dagEntryAfter ["writeBoundary"] ''
      install -D -m600 ${../../secrets/id_rsa.pub} $HOME/.ssh/authorized_keys
  '';

  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = "22.11";
}
