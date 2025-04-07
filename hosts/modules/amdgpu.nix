{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  #LACT gpu controller
  environment.systemPackages = with pkgs; [
    lact
  ];

  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };


  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
}