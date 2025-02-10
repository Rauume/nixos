{config, pkgs, ... }: 
{
    services.syncthing = {
        enable = true;
        user = "cam";
        dataDir = "/home/cam";    # Default folder for new synced folders, instead of /var/lib/syncthing
        configDir = "/home/cam/.config/syncthing";   # Folder for Syncthing's settings and keys. Will be overwritten by Nix!		
    };
}