{ inputs, config, pkgs, libs, ... }: {
  home.file = {
    ".config/awesome" = {
      source = ../../../../config/awesome;
      recursive = true;
    };
    ".config/awesome/modules/bling".source = inputs.bling.outPath;
  };

  xsession.windowManager.awesome.enable = true;
}
