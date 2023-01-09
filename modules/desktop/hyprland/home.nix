{ config, lib, pkgs, ... }:

{
  imports = [ ../../environment/hypr-variables.nix ];

  home = {
    packages = with pkgs; [
      swaybg
      swaylock-effects
      pamixer
    ];
  };
  home.file = {
    ".config/hypr/scripts/brightness.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        msgId="69"
        xbacklight -fps 60 "$@"
        curr="$(xbacklight -get)"
        dunstify -a "changeBrightness" -i ~/.config/dunst/icons/brightness.png -u low -r "$msgId" "Brightness: $curr%"
      '';
    };
    ".config/hypr/scripts/volume.sh" = {
      executable = true;
      text =
        let
          pamixer = "${pkgs.pamixer}/bin/pamixer";
        in
        ''
          #!/usr/bin/env bash
          msgId="69"
          ${pamixer} $@ > /dev/null
          if [ $(${pamixer} --get-mute) = true ] && [ ! $@ = '-t' ]; then
                ${pamixer} -t
          fi
          volume=$(${pamixer} --get-volume)
          mute=$(${pamixer} --get-mute)
          if [ $volume = 0 ] || [ $mute = true ]; then
              dunstify -a "changeVolume" -i ~/.config/dunst/icons/muted.png -u low -r "$msgId" "Volume: muted" 
          else
              dunstify -a "changeVolume" -i ~/.config/dunst/icons/volume.png -u low -r "$msgId" "Volume: $volume%"
          fi
        '';
    };
    ".config/hypr/hyprland.conf".text =
        let
          swaylock = "${pkgs.swaylock-effects}/bin/swaylock --clock --timestr '%l:%M %p' --datestr '%a, %d %b %Y' --indicator --indicator-radius 100 --indicator-thickness 12 --ring-color 0a0a0a --key-hl-color b0b0b0 --effect-blur 12x12";
        in
        ''
           input {
              kb_layout = us
              kb_variant =
              kb_model =
              kb_options = caps:escape
              kb_rules =
              follow_mouse = 2 # 0|1|2|3
              float_switch_override_focus = 2
              numlock_by_default = true
              touchpad {
              natural_scroll = yes
              }
              sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            }

            general {
              gaps_in = 3
              gaps_out = 5
              border_size = 3
              col.active_border = rgb(3d3d3d)
              col.inactive_border = rgba(0f0f0f)
              layout = dwindle # master|dwindle 
            }

            dwindle {
              no_gaps_when_only = false
              force_split = 0 
              special_scale_factor = 0.8
              split_width_multiplier = 1.0 
              use_active_for_splits = true
              pseudotile = yes 
              preserve_split = yes 
            }

            master {
              new_is_master = true
              special_scale_factor = 0.8
              new_is_master = true
              no_gaps_when_only = false
            }

            # cursor_inactive_timeout = 0
            decoration {
              multisample_edges = true
              active_opacity = 1.0
              inactive_opacity = 1.0
              fullscreen_opacity = 1.0
              rounding = 0
              blur = no 
              blur_size = 3
              blur_passes = 1
              blur_new_optimizations = true
              drop_shadow = false
              shadow_range = 4
              shadow_render_power = 3
              shadow_ignore_window = true
            # col.shadow = 
            # col.shadow_inactive
            # shadow_offset
              dim_inactive = false
            # dim_strength = #0.0 ~ 1.0
              blur_ignore_opacity = false
              col.shadow = rgba(1a1a1aee)
            }
      
            # animations {
            #   enabled = yes
            #
            #   bezier = easeOutElastic, 0.05, 0.9, 0.1, 1.05
            #   # bezier=overshot,0.05,0.9,0.1,1.1
            #
            #   animation = windows, 1, 5, easeOutElastic
            #   animation = windowsOut, 1, 5, default, popin 80%
            #   animation = border, 1, 8, default
            #   animation = fade, 1, 5, default
            #   animation = workspaces, 1, 6, default
            # }
            animations {
              enabled=1
              bezier = overshot, 0.13, 0.99, 0.29, 1.1
              animation = windows, 1, 4, overshot, slide
              animation = windowsOut, 1, 5, default, popin 80%
              animation = border, 1, 5, default
              animation = fade, 1, 8, default
              animation = workspaces, 1, 6, overshot, slidevert
            }

            gestures {
              workspace_swipe = true
              workspace_swipe_fingers = 3
              workspace_swipe_distance = 250
              workspace_swipe_invert = true
              workspace_swipe_min_speed_to_force = 15
              workspace_swipe_cancel_ratio = 0.5
              workspace_swipe_create_new = false
            }

            misc {
              disable_autoreload = true
              disable_hyprland_logo = true
              always_follow_on_dnd = true
              layers_hog_keyboard_focus = true
              animate_manual_resizes = false
              enable_swallow = true
              swallow_regex =
              focus_on_activate = true
            }

            device:epic mouse V1 {
              sensitivity = -0.5
            }

            monitor = e-DP1,2560x1440@60,auto,1
            workspace = ,1
            
            windowrule = float,^(nm-connection-editor)$
            windowrulev2 = float,class:^(telegramdesktop)$,title:^(Media viewer)$

            bind = SUPER,RETURN,exec,footclient
            bind = SUPER,D,exec,rofi -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/apps.rasi
            bind = SUPER,X,exec,rofi -show power-menu -modi power-menu:~/.config/rofi/scripts/rofi-power-menu -theme ~/.config/rofi/power-menu.rasi
            bind = SUPER,Q,killactive,
            bind = SUPER,left,movefocus,l
            bind = SUPER,right,movefocus,r
            bind = SUPER,up,movefocus,u
            bind = SUPER,down,movefocus,d
            bind = SUPER_SHIFT,left,movewindow,l
            bind = SUPER_SHIFT,right,movewindow,r
            bind = SUPER_SHIFT,up,movewindow,u
            bind = SUPER_SHIFT,down,movewindow,d
            bind = SUPER,1,workspace,1
            bind = SUPER,2,workspace,2
            bind = SUPER,3,workspace,3
            bind = SUPER,4,workspace,4
            bind = SUPER,5,workspace,5
            bind = SUPER,6,workspace,6
            bind = SUPER,7,workspace,7
            bind = SUPER,8,workspace,8
            bind = SUPER,9,workspace,9
            bind = SUPER,0,workspace,10
            bind = SUPER_SHIFT,1,movetoworkspacesilent,1
            bind = SUPER_SHIFT,2,movetoworkspacesilent,2
            bind = SUPER_SHIFT,3,movetoworkspacesilent,3
            bind = SUPER_SHIFT,4,movetoworkspacesilent,4
            bind = SUPER_SHIFT,5,movetoworkspacesilent,5
            bind = SUPER_SHIFT,6,movetoworkspacesilent,6
            bind = SUPER_SHIFT,7,movetoworkspacesilent,7
            bind = SUPER_SHIFT,8,movetoworkspacesilent,8
            bind = SUPER_SHIFT,9,movetoworkspacesilent,9
            bind = SUPER_SHIFT,0,movetoworkspacesilent,10

            binde = SUPER_CTRL,right,resizeactive,10 0
            binde = SUPER_CTRL,left,resizeactive,-10 0
            binde = SUPER_CTRL,up,resizeactive,0 -10
            binde = SUPER_CTRL,down,resizeactive,0 10

            bind = SUPER_SHIFT,Q,exit,
            bind = SUPER,F,togglefloating,
            bind = SUPER,M,fullscreen,
            bind = SUPER,PRINT,exec,${pkgs.hyprwm-contrib-packages.grimblast}/bin/grimblast --notify copysave area ~/Pictures/Screenshots/$(date +'%s_screenshot.png')
            bind = SUPER,L,exec,${swaylock} --screenshots --effect-scale 0.3
            bind = ,XF86MonBrightnessUp,exec,~/.config/hypr/scripts/brightness.sh -inc 2
            bind = ,XF86MonBrightnessDown,exec,~/.config/hypr/scripts/brightness.sh -dec 2
            bind = ,XF86AudioMute,exec,~/.config/hypr/scripts/volume.sh -t
            bind = ,XF86AudioRaiseVolume,exec,~/.config/hypr/scripts/volume.sh -i 5
            bind = ,XF86AudioLowerVolume,exec,~/.config/hypr/scripts/volume.sh -d 5

            bindl = ,switch:Lid Switch,exec,${swaylock} --image ~/Pictures/Wallpapers/default --effect-scale 0.1

            bindm = SUPER,mouse:272,movewindow
            bindm = SUPER,mouse:273,resizewindow

            exec-once = dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP
            exec-once = ${pkgs.gammastep}/bin/gammastep -l 19:72
            exec-once = ${pkgs.swaybg}/bin/swaybg -o \* -i "${./background/default.png}" -m fill
            exec-once = TERM='xterm-256color' waybar
            exec-once = foot -s
            exec-once = dunst
            exec-once = thunar --daemon
            exec-once = wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store
            exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
        '';
  };
}
