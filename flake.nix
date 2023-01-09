{
  description = "My Personal NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      rust-overlay.url = "github:oxalica/rust-overlay";
      impermanence.url = "github:nix-community/impermanence";
      nur.url = "github:nix-community/NUR";
      hyprpicker.url = "github:hyprwm/hyprpicker";
      hypr-contrib.url = "github:hyprwm/contrib";
      flake-utils.url = "github:numtide/flake-utils";
      nixpkgs-review.url = "github:Mic92/nixpkgs-review";
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprwm-contrib = {
        url = "github:hyprwm/contrib";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, hyprland, impermanence, rust-overlay, hyprpicker, hypr-contrib, flake-utils, ... }:
    let
      user = "jurien";
      domain = "yugen-laptop";
      secrets = import ./secrets/secrets.nix;
    in
    flake-utils.lib.eachSystem [ "x86_64-linux" ]
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
            ];
          };
        in
        {
          devShells = {
            #run by `nix devlop .#<name>`
            blog = with pkgs; mkShell {
              nativeBuildInputs = [
                hugo
              ];
              shellHook = ''
                export PS1="\e[0;32m(Blog)\$ \e[m" 
                cd ./blog
                cp -r ./static/hugo-theme-stack ./themes/
                #hugo server --buildDrafts --forceSyncStatic
              '';
            };
            secret = with pkgs; mkShell {
              nativeBuildInputs = [
              ];
              shellHook = ''
                export PS1="\e[0;31m(Secret)\$ \e[m" 
              '';
            };
          };
        }
      )
    // {
      nixosConfigurations = (
        # NixOS configurations
        import ./hosts {
          # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit secrets;
          inherit inputs nixpkgs home-manager nur user hyprland hyprwm-contrib impermanence rust-overlay hypr-contrib hyprpicker;
        }
      );
    };
}
