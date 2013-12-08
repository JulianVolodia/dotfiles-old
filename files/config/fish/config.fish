#! /usr/bin/fish
# vim: set foldmethod=marker:
# Some things should only be done for login terminals
if status --is-login
  # Nothing
end

# Some things should be done for all interactive shells
if not status --is-login
