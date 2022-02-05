{ config, pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
    dejavu_fonts
    fira-code
    # (nerdfonts.override { fonts = [ ]; })
  ];
}
