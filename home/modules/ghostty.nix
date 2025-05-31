{...}: {
  programs.ghostty = {
    enable = true;
    # package = pkgs.ghostty;
  };
  home.file."./.config/ghostty/config".text = ''

    theme = Everforest Dark - Hard
    window-theme = dark
    
  '';
}
