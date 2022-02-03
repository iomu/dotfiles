{ config, pkgs, lib, ... }:

let
  myCustomLayout = pkgs.writeText "xkb-layout" ''
    ! Map umlauts to RIGHT ALT + <key>
    keycode 108 = Mode_switch
    keysym e = e E EuroSign
    keysym c = c C cent
    keysym a = a A adiaeresis Adiaeresis
    keysym o = o O odiaeresis Odiaeresis
    keysym u = u U udiaeresis Udiaeresis
    keysym s = s S ssharp

    ! disable capslock
    ! remove Lock = Caps_Lock
  '';
in {
  programs.zsh.shellAliases = {
    klayout = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";
  };
  programs.zsh.initExtra = ''
    # umlauts in keyboard layout
    ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}
  '';
}
