# dotfiles

## Mac

Manually add
```sh
if [[ -f '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  export NIX_PATH="$HOME/.nix-defexpr"
fi
```

to `~/.zprofile`.

Undo the changes to /etc/zshrc
