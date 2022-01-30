{
  description = "Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # awesomewm modules
    bling = {
      url = "github:BlingCorp/bling";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
      };
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/configuration.nix ];
      };
    };
}
