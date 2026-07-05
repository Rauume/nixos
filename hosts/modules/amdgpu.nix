{ pkgs, userConfig, ... }: {
  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;
  users.users.${userConfig.name}.extraGroups = [ "lact" ];
  environment.systemPackages = [ pkgs.nvtopPackages.amd ];
}
