{
  description = "Dotfiles";

  inputs = {
    nixpkgs-system.url =
      "github:nixos/nixpkgs/5aaed40d22f0d9376330b6fa413223435ad6fee5";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable-darwin.url =
      "github:nixos/nixpkgs/e922e146779e250fae512da343cfb798c758509d";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-wezterm-fix.url = "github:cpick/nixpkgs/fix-wezterm";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:guibou/nixGL";
    nci = {
      url = "github:yusdacra/nix-cargo-integration";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dream2nix.follows = "dream2nix";
    };
    dream2nix.url = "github:nix-community/dream2nix";
    helix = {
      url = "github:helix-editor/helix";
      #inputs.nci.follows = "nci";
    };

    # awesomewm modules
    bling = {
      url = "github:BlingCorp/bling";
      flake = false;
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
    nvim-rust-tools-src = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    nvim-tabout-src = {
      url = "github:abecodes/tabout.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-stable-darwin
    , nixpkgs-system, home-manager, helix, ... }@inputs:
    let
      inherit (nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;
      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays ++ singleton (
          # Sub in x86 version of packages that don't build on Apple Silicon yet
          final: prev:
          (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit (final.pkgs-x86) click;
          })) ++ singleton (
            final: prev:
            (optionalAttrs (prev.stdenv.system == "x86_64-darwin") {
              inherit (final.pkgs-wezterm) wezterm;
            }));
      };

      pkgsForSystem = system: import nixpkgs { inherit system; };

      mkHomeConfiguration = { system, ... }@args:
        home-manager.lib.homeManagerConfiguration (rec {
          pkgs = pkgsForSystem system;
          extraSpecialArgs = {
            pkgs-stable = import (if pkgs.stdenv.isDarwin then
              nixpkgs-stable-darwin
            else
              nixpkgs-stable) { inherit system; };
          };
        } // builtins.removeAttrs args [ "system" ]);

      home-common = { lib, ... }: {
        nixpkgs = nixpkgsConfig;

        programs.home-manager.enable = true;
        home.stateVersion = "23.05";
        imports = [
          ./users/common.nix
          (let
            declCachix = builtins.fetchTarball
              "https://github.com/jonascarpay/declarative-cachix/archive/800c308a85b964eb3447a3cb07e8190fb74dcf59.tar.gz";
          in import "${declCachix}/home-manager.nix")
        ];

        _module.args = {
          inherit inputs self;
          bling = inputs.bling;
        };

        caches.cachix = [ "helix" "nix-community" ];
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
        home.username = "johannes.mueller";
        home.homeDirectory = "/Users/johannes.mueller";
        imports = [ ./users/mac.nix ./users/hosts/mac.nix ];
      };
      home-personal-mac = {
        home.username = "jo";
        home.homeDirectory = "/Users/jo";
        imports = [ ./users/mac.nix ./users/hosts/personal-mac.nix ];
      };
    in {
      overlays = {
        # Overlay useful on Macs with Apple Silicon
        apple-silicon = final: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            # Add access to x86 packages system is running Apple Silicon
            pkgs-x86 = import inputs.nixpkgs {
              system = "x86_64-darwin";
              config = { allowUnfree = true; };
            };
          };

        wezterm = final: prev:
          optionalAttrs (prev.stdenv.system == "x86_64-darwin") {
            pkgs-wezterm =
              import inputs.nixpkgs-wezterm-fix { system = "x86_64-darwin"; };
          };
      };

      homeConfigurations = {
        nixos = mkHomeConfiguration {
          system = "x86_64-linux";
          modules = [ home-common home-nixos ];
        };
        work = mkHomeConfiguration {
          system = "x86_64-linux";
          modules = [ home-common home-work ];
        };
        arch = mkHomeConfiguration {
          system = "x86_64-linux";
          modules = [ home-common home-arch ];
        };
        mac = mkHomeConfiguration {
          system = "x86_64-darwin";
          modules = [ home-common home-mac ];
        };
        personal-mac = mkHomeConfiguration {
          system = "aarch64-darwin";
          modules = [ home-common home-personal-mac ];
        };
      };
      nixosConfigurations.nixos = nixpkgs-system.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/configuration.nix ];
      };
    };
}
