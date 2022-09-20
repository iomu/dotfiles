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
      };
    in {
      overlay = _final: prev: {
        vimPlugins = prev.vimPlugins // (missingVimPluginsInNixpkgs prev.pkgs);
      };
    };
}
