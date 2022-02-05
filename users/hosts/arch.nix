{ config, pkgs, lib, inputs, ... }:
let
  apply-user = pkgs.writeScriptBin "apply-user"
    "${builtins.readFile ../modules/system-management/apply-user-arch.sh}";
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [ inputs.nixgl.overlay ];
    config = { allowUnfree = true; };
  };
  terminal =
    "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.alacritty}/bin/alacritty";
in {
  imports = [ ../modules/desktop/wm/i3.nix ];

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes 
  '';

  programs.git.userEmail = "muellerjohannes23@gmail.com";
  home.packages = [ apply-user pkgs.nixgl.auto.nixGLDefault ];

  home.sessionVariables = { TERMINAL = terminal; };

  home.sessionPath = [
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/sbin"
    "/usr/bin"
    "/sbin"
    "/bin"
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  services.gnome-keyring.enable = true;

  xsession.windowManager.i3.config.terminal = terminal;
}
