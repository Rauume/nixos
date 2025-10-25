{pkgs, ...}: {
  
  nixpkgs.config.rocmSupport = true;
  services = {
    open-webui = {
      enable = true;
      port = 8081;     
    };
    
    ollama = {
      enable = true;
      acceleration = "rocm";

      # https://github.com/NixOS/nixpkgs/issues/308206
      # https://rocm.docs.amd.com/en/latest/reference/gpu-arch-specs.html
      rocmOverrideGfx = "12.0.1"; # 9070 xt support override.

      host = "127.0.0.1";
      port = 11434;
      openFirewall = true;
    };

    nextjs-ollama-llm-ui = {
      enable = true;
      port = 8080;
      ollamaUrl = "http://127.0.0.1:11434";
    };
  };
}