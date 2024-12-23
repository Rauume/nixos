# https://mynixos.com/home-manager/options/services.syncthing
{
  # userConfig,
  # pkgs,
  ...
}: {
  services.syncthing = {
    enable = true;
    # group = "mygroupname";
    # user = "${userConfig.name}";
    # dataDir = "/home/${userConfig.name}/Documents";    # Default folder for new synced folders
    # configDir = "/home/${userConfig.name}/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    # options = {

    # }
  };
}



# "file:///home/${userConfig.name}/Downloads/temp"