{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
    configPackages = [pkgs.kdePackages.plasma-workspace];
  };
  services = {
    flatpak.enable = true; # Enable Flatpak
  };
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
