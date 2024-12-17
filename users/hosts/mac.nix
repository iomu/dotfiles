{ config, pkgs, lib, inputs, ... }: {

  custom = {
    system = "mac";
    enableAlacritty = false;
    enableWezterm = false;
    user = "johannes.mueller";
    git.userEmail = "johannes.mueller@freiheit.com";
    terminal = lib.getExe pkgs.kitty;
  };

  home.packages = [ pkgs.graphviz ];
}
