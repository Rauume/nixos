{config, pkgs, userConfig, ... }: 
{
    services.syncthing = {
        enable = true;
        user = userConfig.name;
        dataDir = "/home/${userConfig.name}";    # Default folder for new synced folders, instead of /var/lib/syncthing
        configDir = "/home/${userConfig.name}/.config/syncthing";   # Folder for Syncthing's settings and keys. Will be overwritten by Nix!		
    };
}