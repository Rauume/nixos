{lib, ...}: {
  imports = [
    ../modules/common.nix
    ../modules/easyeffects.nix
    ../modules/gnome.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";

  # Disable warning for release checks
  # home.enableNixpkgsReleaseCheck = false;
  
  dconf.settings."org/gnome/shell".enabled-extensions = lib.mkAfter [
    "tilingshell@ferrarodomenico.com"
  ];
}
