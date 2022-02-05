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
  };

  outputs = { self, nixpkgs, nixpkgs-system, home-manager, nixgl, ... }@inputs:
    let
      extraSpecialArgs = {
        inherit inputs self;
        bling = inputs.bling;
      };
    in {
      homeConfigurations = {
        nixos = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";

          username = "jo";
          homeDirectory = "/home/jo";

          stateVersion = "21.05";
          inherit extraSpecialArgs;
          configuration = { config, lib, pkgs, ... }: {
            nixpkgs.config = { allowUnfree = true; };
            # Let Home Manager install and manage itself.
            programs.home-manager.enable = true;

            # This value determines the Home Manager release that your
            # configuration is compatible with. This helps avoid breakage
            # when a new Home Manager release introduces backwards
            # incompatible changes.
            #
            # You can update Home Manager without changing this value. See
            # the Home Manager release notes for a list of state version
            # changes in each release.
            home.stateVersion = "21.05";

            imports = [ ./users/common.nix ./users/hosts/desktop.nix ];
          };
        };
        work = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";

          username = "jo";
          homeDirectory = "/home/jo";

          stateVersion = "21.05";
          inherit extraSpecialArgs;
          configuration = { config, lib, pkgs, ... }: {
            nixpkgs.config = { allowUnfree = true; };
            # Let Home Manager install and manage itself.
            programs.home-manager.enable = true;

            # This value determines the Home Manager release that your
            # configuration is compatible with. This helps avoid breakage
            # when a new Home Manager release introduces backwards
            # incompatible changes.
            #
            # You can update Home Manager without changing this value. See
            # the Home Manager release notes for a list of state version
            # changes in each release.
            home.stateVersion = "21.05";

            imports = [ ./users/common.nix ./users/hosts/work.nix ];
          };
        };
        arch = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";

          username = "jo";
          homeDirectory = "/home/jo";
          stateVersion = "21.05";
          inherit extraSpecialArgs;
          configuration = { config, lib, pkgs, ... }: {
            nixpkgs.config.allowUnfree = true;
            programs.home-manager.enable = true;

            home.stateVersion = "21.05";
            imports = [ ./users/common.nix ./users/hosts/arch.nix ];
          };
        };
      };
      nixosConfigurations.nixos = nixpkgs-system.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/configuration.nix ];
      };
    };
}
