{
  hostname,
  ...
}: {
  imports = [

    ./hardware-configuration.nix
    ../modules/common.nix
    ../modules/kde.nix
    ../modules/piper.nix
    ../modules/steam.nix
    ../modules/syncthing.nix
    ../modules/amdgpu.nix
  ];

  # Set hostname
  networking.hostName = hostname;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.05";

  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 25565; to = 25599; }
    ];
  };

}
