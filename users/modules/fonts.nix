{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ font-awesome dejavu_fonts ];
}
