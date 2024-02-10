{ config, pkgs, lib, ... }: {
  programs.atuin.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;
  programs.zoxide.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;

    extraConfig = lib.mkAfter ''
      # See https://github.com/atuinsh/atuin/issues/1025 for details
      $env.config = ($env | default {} config).config
      $env.config.show_banner = false
      $env.config = ($env.config | default [] keybindings)
      $env.config = (
       $env.config | upsert keybindings (
           $env.config.keybindings
           | append {
               name: atuin
               modifier: none
               keycode: up
               mode: [emacs, vi_normal, vi_insert]
               event: { send: executehostcommand cmd: (_atuin_search_cmd '--shell-up-key-binding') }
           }
       )
      )

      let fish_completer = {|spans|
          ${pkgs.fish}/bin/fish --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
      }

      let zoxide_completer = {|spans|
          $spans | skip 1 | ${pkgs.zoxide}/bin/zoxide query -l $in | lines | where {|x| $x != $env.PWD}
      }

      let carapace_completer = {|spans: list<string>|
          ${pkgs.carapace}/bin/carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
      }

      let external_completer = {|spans|
          let expanded_alias = scope aliases
          | where name == $spans.0
          | get -i 0.expansion

          let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
          } else {
              $spans
          }

          match $spans.0 {
              __zoxide_z => $zoxide_completer,
              __zoxide_zi => $zoxide_completer,
              _ => $carapace_completer
          } | do $in $spans
      }
      $env.config = ($env.config | default {} completions)
      $env.config = (
          $env.config | upsert completions (
               $env.config.completions
               | upsert external {
                   enable: true
                   completer: $external_completer
               }
          )
      )
    '';

    shellAliases = config.custom.shellAliases;
  };
}
