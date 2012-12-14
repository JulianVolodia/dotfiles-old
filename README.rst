================
Runiq's dotfiles
================

These are my dotfiles. Feel free to copy and paste as you see fit.

Disclaimer
==========

I don't assume liability for any of these files. If you copy and paste and one of the files eats your hamster, you're on your own.

If I have left out a license or improperly attributed something and you want that fixed, drop me a line.

``Deploy`` script
=================

This little devil is used to actually deploy the dotfiles. It takes three parameters:

1. Where your dotfiles currently reside (default: ``files``---take care, it's a relative path).
2. Where they should be copied to (default: ``~/.config/dotfiles``).
3. What directory you want to put the symlinks in (default: ``~``).

The reason for the second step is that I don't like working with dotfiles directly out of my repository – according to Murphy's Law, some program *will* eventually overwrite a dotfile, and if I happen to commit after that without realizing it, non-hilarity will ensue. So I'm having none of that.
