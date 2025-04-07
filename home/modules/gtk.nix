{
  userConfig,
  pkgs,
  ...
}: let 
  theme = ./../../files/gtk_themes;
in {
  home.file = {
    ".themes/" = {
      recursive = true;
      source = "${theme}";
    };
  };
  
  # GTK theme configuration
  # gtk = {
  #   enable = true;
  #   # everforest-gtk-theme = {
  #   #   enable = true;
  #   #   gnomeShellTheme = true;
  #   # };
  #   # catppuccin = {
  #   #   enable = true;
  #   #   gnomeShellTheme = true;
  #   # };
  #   # iconTheme = {
  #     # name = "Tela-circle-dark";
  #     # package = pkgs.tela-circle-icon-theme;
  #   # };
  #   cursorTheme = {
  #     name = "Yaru";
  #     package = pkgs.yaru-theme;
  #   };
  #   font = {
  #     name = "Roboto";
  #     size = 11;
  #   };
  #   gtk3 = {
  #     # bookmarks will show in gnome files sidepanel.
  #     # bookmarks = [
  #     #   "file:///home/${userConfig.name}/Downloads/temp"
  #     #   "file:///home/${userConfig.name}/Documents/repositories"
  #     # ];
  #   };
  # };
}
