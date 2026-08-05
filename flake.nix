{
  description = "Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-system.url = "github:nixos/nixpkgs/5aaed40d22f0d9376330b6fa413223435ad6fee5";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    evans = {
      url = "github:ktr0731/evans/v0.10.9";
      flake = false;
    };
    earthly = {
      url = "github:earthly/earthly/v0.7.0-rc1";
      flake = false;
    };

    kafkactl = {
      url = "github:deviceinsight/kafkactl/v2.3.0";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-stable-darwin,
      nixpkgs-system,
      home-manager,
      fenix,
      ...
    }@inputs:
    let
      inherit (nixpkgs.lib)
        attrValues
        makeOverridable
        optionalAttrs
        singleton
        ;
      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
        };
        overlays =
          attrValues self.overlays;
      };

      pkgsForSystem = system: import nixpkgs { inherit system; };

      mkHomeConfiguration =
        { system, ... }@args:
        home-manager.lib.homeManagerConfiguration (
          rec {
            pkgs = pkgsForSystem system;
            extraSpecialArgs = {
              pkgs-stable = import (if pkgs.stdenv.isDarwin then nixpkgs-stable-darwin else nixpkgs-stable) {
                inherit system;
              };
              inputs = inputs;
            };
          }
          // builtins.removeAttrs args [ "system" ]
        );

      home-common =
        { lib, config, ... }:
        {
          nixpkgs = nixpkgsConfig;

          programs.home-manager.enable = true;
          home.stateVersion = "23.05";
          imports = [
            ./users/common.nix
            (
              let
                declCachix = builtins.fetchTarball "https://github.com/jonascarpay/declarative-cachix/archive/800c308a85b964eb3447a3cb07e8190fb74dcf59.tar.gz";
              in
              import "${declCachix}/home-manager.nix"
            )
          ];

          caches.cachix = [ "nix-community" ];
        };

      home-nixos = {
        imports = [ ./users/hosts/desktop.nix ];
      };
      home-work = {
        imports = [
          ./users/linux.nix
          ./users/hosts/work.nix
        ];
      };

      home-arch = {
        imports = [
          ./users/linux.nix
          ./users/hosts/arch.nix
        ];
      };
      home-mac = {
        imports = [
          ./users/mac.nix
          ./users/hosts/mac.nix
        ];
      };
      home-personal-mac = {
        imports = [
          ./users/mac.nix
          ./users/hosts/personal-mac.nix
        ];
      };
    in
    {
      overlays = {
        # Overlay useful on Macs with Apple Silicon
        apple-silicon =
          final: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          };

        fenix = fenix.overlays.default;


        packages = final: prev: {
        };
      };

      homeConfigurations = {
        nixos = mkHomeConfiguration {
          system = "x86_64-linux";
          modules = [
            home-common
            home-nixos
          ];
        };
        work = mkHomeConfiguration {
          system = "x86_64-linux";
          modules = [
            home-common
            home-work
          ];
        };
        arch = mkHomeConfiguration {
          system = "x86_64-linux";
          modules = [
            home-common
            home-arch
          ];
        };
        mac = mkHomeConfiguration {
          system = "aarch64-darwin";
          modules = [
            home-common
            home-mac
          ];
        };
        personal-mac = mkHomeConfiguration {
          system = "aarch64-darwin";
          modules = [
            home-common
            home-personal-mac
          ];
        };
      };
      nixosConfigurations.nixos = nixpkgs-system.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/configuration.nix ];
      };
    };
}
