{ config, pkgs, libs, ... }: {

  home.packages = with pkgs; [ autorandr ];

  programs.feh.enable = true;

  programs.rofi = { enable = true; };

  xsession = {
    enable = true;
    scriptPath = ".xsession";
  };
}
