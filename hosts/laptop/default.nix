{ config, pkgs, user, inputs, secrets, ... }:

{
  imports =
    [ (import ./hardware-configuration.nix) ] ++
    # [ (import ../../modules/desktop/sway/default.nix) ] ++
    [ (import ../../modules/desktop/hyprland/default.nix) ] ++
    [ (import ../../modules/programs/fcitx5/fcitx5.nix) ] ++
    [ (import ../../modules/programs/gpg.nix) ] ++
    [ (import ../../modules/fonts/fonts.nix) ] ++
    (import ../../modules/hardware) ++
    (import ../../modules/virtualisation);

  security = {
    rtkit.enable = true;
    pam.services.swaylock = { };
  };
  
  users.mutableUsers = false;
  users.users.root.initialHashedPassword = secrets.jurien.password;
  users.users.${user} = {
    initialHashedPassword = secrets.jurien.password;
    # shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];
    packages = with pkgs; [
      feishu
      pkgs.sway-contrib.grimshot
      imagemagick
      rofi-wayland
      wl-clipboard
    ];
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  programs = {
    dconf.enable = true;
    light.enable = true;
  };
  environment = {
    persistence."/nix/persist/" = {
      directories = [
        "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
        "/etc/NetworkManager"
        "/etc/v2raya"
        "/var/log"
        "/var/lib"
      ];
      users.jurien = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".cache"
          ".config"
          "Flakes"
          "Kvm"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".local"
          ".mozilla"
        ];
        files = [
          ".npmrc"
        ];
      };
    };
    systemPackages = with pkgs; [
      libnotify
      wl-clipboard
      wlr-randr
      wireplumber
      pipewire-media-session
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      pkgs.xorg.xeyes
      glfw-wayland
      xwayland
      pkgs.qt6.qtwayland
      cinnamon.nemo
      networkmanagerapplet
      wev
      wf-recorder
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      ntfs3g
      pkgs.rust-bin.stable.latest.default
      blender
      (writeScriptBin "sudo" ''exec doas "$@"'')
      (writeScriptBin "sudoedit" ''exec ${doasedit-git}/doasedit "$@"'')
    ];
  };

  services = {
    getty.autologinUser = "jurien";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
    };
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = false;
    extraConfig = ''
      jurien ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

}
