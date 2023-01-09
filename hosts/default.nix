{ lib, inputs, nixpkgs, home-manager, nur, user, hyprland, hyprwm-contrib, impermanence, hyprpicker, hypr-contrib, secrets, ... }:

let
  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
  laptop = lib.nixosSystem {
    # Laptop profile
    inherit system;
    specialArgs = { inherit inputs secrets user; };
    modules = [
      ./laptop
      impermanence.nixosModules.impermanence
      ./system.nix
      nur.nixosModules.nur
      ../modules/programs/nurpkgs.nix
      hyprland.nixosModules.default
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user secrets; };
        home-manager.users.${user} = {
          imports = [ (import ./laptop/home.nix) ];
        };
        nixpkgs = {
          overlays = [
            # (final: prev: {
            #   catppuccin-cursors = prev.callPackage ../overlays/catppuccin-cursors.nix { };
            #   catppuccin-gtk = prev.callPackage ../overlays/catppuccin-gtk.nix { };
            # })
            (import ../overlays)
            (self: super: {
              hyprwm-contrib-packages = hyprwm-contrib.packages.${system};
            })
            inputs.rust-overlay.overlays.default
          ];
        };
      }
    ];
  };

}
