{
  inputs,
  hostname,
  pkgs,
  ...
}: {
  imports = [

    ./hardware-configuration.nix
    ../modules/common.nix
    ../modules/piper.nix
    ../modules/steam.nix
    ../modules/syncthing.nix
    ../modules/kde.nix
  ];

  # Set hostname
  networking.hostName = hostname;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.05";

  systemd.tpm2.enable = false;

  boot.blacklistedKernelModules = [
    "snd_soc_avs"
  ];

  specialisation = {
    cam.configuration = {
      system.nixos.tags = [ "Nvidia-GPU" ];
      imports = [
        ./nvidia.nix
      ];
      environment.systemPackages = with pkgs; [
        sl #Used as a profile sanity check
      ];
    };
  };
}
