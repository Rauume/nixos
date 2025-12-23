{userConfig, pkgs, ...}: {
  # Install git via home-manager module
  programs.delta.enableGitIntegration = true;
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings.user.name = userConfig.fullName;
    settings.user.email = userConfig.email;
    settings = {
      pull.rebase = "true";
      credential.helper = "libsecret";
    };
  };
  programs.delta = {
    options = {
      keep-plus-minus-markers = true;
      light = false;
      line-numbers = true;
      navigate = true;
      width = 280;
    };
  };
}
