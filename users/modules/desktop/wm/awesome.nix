{ inputs, config, pkgs, libs, ... }: {
  home.file = {
    ".config/awesome" = {
      source = ../../../../config/awesome;
      recursive = true;
    }; # .source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/awesome";
    ".config/awesome/modules/bling".source = inputs.bling.outPath;
    # "dotfiles/config/awesome/modules/bling".source = inputs.bling.outPath;
    # "dotfiles/config/awesome/modules/layout-machi".source = inputs.layout-machi.outPath;
  };
}
