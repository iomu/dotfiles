{
  inputs = {
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
      url = "github:Pocco81/auto-save.nvim";
      flake = false;
    };
    nvim-local-history-src = {
      url = "github:dinhhuy258/vim-local-history";
      flake = false;
    };
  };
  outputs = inputs:
    let
      missingVimPluginsInNixpkgs = pkgs: {
        nvim-surround = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-surround";
          src = inputs.nvim-surround-src;
        };
        nvim-tundra = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-tundra";
          src = inputs.nvim-tundra-src;
        };
        nvim-which-key = pkgs.vimUtils.buildVimPlugin {
          name = "which-key.nvim";
          src = inputs.nvim-which-key-src;
        };
        nvim-tokyonight = pkgs.vimUtils.buildVimPlugin {
          name = "tokyonight.nvim";
          src = inputs.nvim-tokyonight-src;
        };
        nvim-lspsaga = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "nvim-lspsaga";
          src = inputs.nvim-lspsaga-src;
          buildInputs = [ pkgs.lua53Packages.busted ];
        };
        nvim-auto-save = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "nvim-auto-save";
          src = inputs.nvim-auto-save-src;
        };
        nvim-local-history = pkgs.vimUtils.buildVimPluginFrom2Nix {
          name = "nvim-local-history";
          src = inputs.nvim-local-history-src;
        };
      };
    in
    {
      overlay = _final: prev: {
        vimPlugins = prev.vimPlugins // (missingVimPluginsInNixpkgs prev.pkgs);
      };
    };
}
