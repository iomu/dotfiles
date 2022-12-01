{
  description = "Dotfiles";

  inputs =
    { nixpkgs-system.url =
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
        url = "github:ktr0731/evans/v0.10.9";
        flake = false;
      };

      kafkactl = {
        url = "github:deviceinsight/kafkactl/v2.3.0";
        flake = false;
      };

      nvim-surround-src = {
        url = "github:kylechui/nvim-surround";
        flake = false;
      };
      nvim-tundra-src = {
        url = "github:sam4llis/nvim-tundra";
        flake = false;
      };
      nvim-which-key-src = {
        url = "github:folke/which-key.nvim";
        flake = false;
      };
      nvim-tokyonight-src = {
        url = "github:folke/tokyonight.nvim";
        flake = false;
      };
      nvim-lspsaga-src = {
        url = "github:glepnir/lspsaga.nvim";
        flake = false;
      };
      nvim-auto-save-src = {
        url = "github:PolSust/auto-save.nvim/allow_noautocmd_autosaving";
        flake = false;
      };
      nvim-local-history-src = {
        url = "github:dinhhuy258/vim-local-history";
        flake = false;
      };
      nvim-ts-context-commentstring-src = {
        url = "github:JoosepAlviste/nvim-ts-context-commentstring";
        flake = false;
      };
      nvim-tree-climber-src = {
        url = "github:drybalka/tree-climber.nvim";
        flake = false;
      };
      nvim-telescope-fzf-native-src = {
        url = "github:nvim-telescope/telescope-fzf-native.nvim";
        flake = false;
      };
      nvim-noice-src = {
        url = "github:folke/noice.nvim";
        flake = false;
      };
      nvim-dirbuf-src = {
        url = "github:elihunter173/dirbuf.nvim";
        flake = false;
      };
      nvim-dap-go-src = {
        url = "github:leoluz/nvim-dap-go";
        flake = false;
      };
      nvim-neotest-go-src = {
        url = "github:nvim-neotest/neotest-go";
        flake = false;
      };
      nvim-neotest-rust-src = {
        url = "github:rouge8/neotest-rust";
        flake = false;
      };
      nvim-null-ls-fork-src = {
        url = "github:iomu/null-ls.nvim";
        flake = false;
      };
    };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-system
    , home-manager
    , nixgl
    , ...
    }@inputs:
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

        _module.args = {
          inherit inputs self;
          bling = inputs.bling;
        };
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
    in
    {
      homeConfigurations = {
        nixos = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ home-common home-nixos ];
        };
        work = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ home-common home-work ];
        };
        arch = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ home-common home-arch ];
        };
        mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-darwin";
          modules = [ home-common home-mac ];
        };
      };
      nixosConfigurations.nixos = nixpkgs-system.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/configuration.nix ];
      };
    };
}
