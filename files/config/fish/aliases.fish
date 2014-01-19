#!/usr/bin/fish
# vim: set foldmethod=marker:

# Slashes are no fun on a German keyboard
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

alias ls "ls -F -h --color --group-directories-first"
alias la "ls -A"
alias ll "ls -l"
alias lla "ls -la"

# I'm a lazy bastard
alias_with_completion p "pacaur"
alias_with_completion t "task"
alias_with_completion b "beet"
alias_with_completion s "systemctl"
alias_with_completion syu "systemctl --user"
alias_with_completion j "journalctl"
alias_with_completion tr "transmission-remote"
alias_with_completion n "newsbeuter"
