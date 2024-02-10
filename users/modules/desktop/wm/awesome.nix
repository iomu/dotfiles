{ inputs, config, pkgs, libs, ... }: {
  home.file = {
    ".config/awesome" = {
      source = ../../../../config/awesome;
      recursive = true;
    };
  };

  xsession.windowManager.awesome.enable = true;
}
