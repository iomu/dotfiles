{ config, pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    font-awesome
    dejavu_fonts
     (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "JetBrainsMono" "DejaVuSansMono" ]; })
  ];
}
