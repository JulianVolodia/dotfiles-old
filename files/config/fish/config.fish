#! /usr/bin/fish
# vim: set foldmethod=marker filetype=sh:
# Some things should only be done for login terminals
# Some things should be done for all interactive shells
if status --is-interactive
  # Set up aliases
  source "$HOME/.config/fish/aliases.fish"
end
