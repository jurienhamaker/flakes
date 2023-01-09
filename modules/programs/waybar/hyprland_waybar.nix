{ config, lib, pkgs, ... }:

let
  user = "jurien";
in
{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  nixpkgs.overlays = [
    (final: prev: {
      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
          waybarPatchFile = import ./workspace-patch.nix { inherit pkgs hyprctl; };
        in
        prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
        });
    })
  ];

  home-manager.users.${user} = {
    # Home-manager waybar config
    programs.waybar = {
      enable = true;
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
        settings = [{
          position = "top";
          margin = "8 5 8 5";
          height = 16;
          modules-left = [ "wlr/workspaces" ];
          modules-center = [ "clock" "clock#time" ];
          modules-right = [ "network" "pulseaudio" "custom/bluetooth" "battery" "custom/power" ];
          "clock" = {
            format = "{:%a, %d %b %Y}";
            interval = 3600;
          };
          "clock#time" = {
            format = "{:%H:%M}";
            interval = 60;
          };
          "network" = {
            format = "";
            on-click = "~/.config/rofi/scripts/rofi-wifi-menu";
            tooltip = false;
          };
          "pulseaudio" = {
            format = "{icon}";
            format-muted = "<span color=\"#4a4a4a\"></span>";
            format-icons = [ "" "" "" ];
            on-click = "pamixer -t";
            tooltip = false;
          };
          "battery" = {
            format = "{icon}  {capacity}%";
            format-charging = "  {capacity}%";
            format-icons = [ "" "" "" "" "" ];
            tooltip = false;
          };
          "custom/power" = {
            format = "";
            on-click = "rofi -show power-menu -modi power-menu:~/.config/rofi/scripts/rofi-power-menu -theme ~/.config/rofi/power-menu.rasi";
            tooltip = false;
          };
          "custom/bluetooth" = {
            exec = "~/.config/rofi/scripts/rofi-bluetooth --status";
            interval = 1;
            on-click = "~/.config/rofi/scripts/rofi-bluetooth";
            tooltip = false;
          };
        }];
      style = ''
          * {
            min-height: 0;
            padding: 0;
            margin: 0;
            border: 0;
          }
          #waybar {
            background: transparent;
          }
          #workspaces, #workspaces button, #battery, #bluetooth, #network, #clock, #clock.time, #pulseaudio, #custom-bluetooth, #custom-power {
            font-family: "NotoSans", "FontAwesome6Free";
            font-weight: bolder;
            font-size: 10px;
            color: #b0b0b0;
            background-color: #0a0a0a;
            border-radius: 0;
            transition: none;
            padding: 0 8px;
          }
          #custom-power, #clock.time, #workspaces button.active {
            background-color: #b0b0b0;
            color: #0a0a0a;
            border-radius: 0 8px 8px 0;
          }
          #custom-power {
            background-color: #a54242;
            padding: 0 12px 0 8px;
          }
          #clock, #network {
            border-radius: 8px 0 0 8px;
          }
          #workspaces {
            border-radius: 8px;
            padding: 2px 2px;
          }
          #workspaces button {
            padding: 4px;
            margin: 1px;
          }
          #workspaces button.active {
            border-radius: 50%;
          }
          #network.disconnected {
            color: #4a4a4a;
          }
      '';
    };
  };
}
