# Remember to commit any new scripts,
# Else they won't be symlinked correctly.

{
  pkgs,
  lib,
  ...
}: let
  scripts = ./../../files/scripts;
in {
  # Source scripts from the home-manager store
  home.file = {
    ".local/bin" = {
      recursive = true;
      source = scripts;
    };
  };
}
