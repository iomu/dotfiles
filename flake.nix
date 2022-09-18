{
  description = "Dotfiles";

  inputs = {
    nixpkgs-system.url =
      "github:nixos/nixpkgs/5aaed40d22f0d9376330b6fa413223435ad6fee5";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:guibou/nixGL";

    # awesomewm modules
    bling = {
      url = "github:BlingCorp/bling";
      flake = false;
    };
    evans = {
      url = "github:ktr0731/evans/v0.10.2";
      flake = false;
    };
    kafkactl = {
      url = "github:deviceinsight/kafkactl/v2.3.0";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-system, home-manager, nixgl, ... }@inputs:
    let
      extraSpecialArgs = {
        inherit inputs self;
        bling = inputs.bling;
      };

      home-common = { lib, ... }: {
        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [ ];

        programs.home-manager.enable = true;
        home.stateVersion = "21.05";
        imports = [ ./users/common.nix ];
      };

      home-nixos = {
        home.username = "jo";
        home.homeDirectory = "/home/jo";
        imports = [ ./users/hosts/desktop.nix ];
      };
      home-work = {
        home.username = "jo";
        home.homeDirectory = "/home/jo";
        imports = [ ./users/linux.nix ./users/hosts/work.nix ];
      };

      home-arch = {
        home.username = "jo";
        home.homeDirectory = "/home/jo";
        imports = [ ./users/linux.nix ./users/hosts/arch.nix ];
      };
      home-mac = {
        home.username = "jo";
        home.homeDirectory = "/Users/jo";
        imports = [ ./users/hosts/mac.nix ];
      };
    in {
      homeConfigurations = {
        nixos = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ home-common home-nixos ];
          inherit extraSpecialArgs;
        };
        work = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ home-common home-work ];
        };
        arch = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ home-common home-arch ];
          inherit extraSpecialArgs;
        };
        mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-darwin";
          modules = [ home-common home-work ];
        };
      };
      nixosConfigurations.nixos = nixpkgs-system.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/configuration.nix ];
      };
    };
}
