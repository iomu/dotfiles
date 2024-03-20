{ config, pkgs, pkgs-stable, lib, ... }:
let
  colima-docker = pkgs.writeScriptBin "cdocker" ''
    ${pkgs.colima}/bin/colima nerdctl -- $@
  '';
in {

  home.homeDirectory = "/Users/${config.custom.user}";

  home.packages = [
    pkgs.colima
    pkgs.cocoapods
    pkgs.rubyPackages.xcodeproj
    colima-docker
    pkgs.docker-client
    pkgs.docker-credential-helpers
    pkgs.docker-credential-gcr
  ];

  home.sessionVariables = {
    DOCKER_HOST =
      "unix://${config.home.homeDirectory}/.colima/default/docker.sock";
      ANDROID_HOME = "${config.home.homeDirectory}/Library/Android/sdk";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/Library/Android/sdk/platform-tools"
  ];
}
