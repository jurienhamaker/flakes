{ config, pkgs, ... }:

{
  programs = {
    mako = {
      font = "Iosevka Nerd Font 12";
      defaultTimeout = 5000;
      ignoreTimeout = true;
      sort = "+time";
      width = 256;
      height = 500;
      margin = "10";
      padding = "5";
      borderSize = 3;
      borderRadius = 3;
      backgroundColor = "#0a0a0a";
      borderColor = "#0a0a0a";
      progressColor = "over #4a4a4a";
      textColor = "#b0b0b0";
      extraConfig = ''
        text-alignment=left
        [urgency=high]
        border-color=#a54242
      '';
    };
  };
}
