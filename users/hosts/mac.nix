{ config, pkgs, lib, inputs, ... }: {

  custom = {
    system = "mac";
    enableAlacritty = false;
    user = "johannes.mueller";
    git.userEmail = "johannes.mueller@freiheit.com";
  };

  home.packages = [pkgs.azure-cli];
}
