{pkgs, ...}: {
  # For defining buttons on logitech mice
  environment.systemPackages = with pkgs; [
    piper
    libratbag
  ];
  services.ratbagd.enable = true;
}
