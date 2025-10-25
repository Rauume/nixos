# Linux NixOS  Configs

This is my personal Nixos Linux configuration. I share this across my devices to keep their programs and settings synced with each other. 

Running Gnome desktop, Zsh. Managed with Nix Flakes, and Home-Manager.

## Installation
This guide assumes you've already [installed the graphical iso](https://nixos.org/download/) and generated a `hardware-configuration.nix`.
1. **Clone this repo**

   ```sh
   
   git clone https://github.com/Rauume/nixos.git
   
   cd nixos-main

   ```

2. **Update `flake.nix`:**
   
   a. Add your user details: (replacing `usernamehere` with your chosen username)
   ```nix
   # Define user configurations
   users = {
	   usernamehere = {
		   name = "";
		   fullName = "";
		   email = "";
		   avatar = ./files/avatar/icon.png; #512x512.png
	   };
   };
   ```
   
   b. Add your new machine, replacing `username` and `newmachine`
   ```nix
   #System Config
   nixosConfigurations = {
	   newmachine = mkNixosConfiguration "newmachine" "username";
	};
	#Home Manager Config
	homeConfigurations = {
	   "username@newmachine" = mkHomeConfiguration "x86_64-linux" "username" "newmachine";
   };
   ```

3. **Add Machine Configs:**

	a. Make a new folder: `hosts/newmachine`
	
	b. Copy `/etc/nixos/hardware-configuration.nix` to your `hosts/newmachine` folder

	```sh
	cp /etc/nixos/hardware-configuration.nix repo/hosts/newmachine
	```
	
	c. Touch `hosts/newmachine/configuration.nix` and add the following:
	
	```nix
	{
	inputs,
	hostname,
	...
	}: {
	imports = [
	./hardware-configuration.nix
	../modules/common.nix
	../modules/gnome.nix
	../modules/piper.nix
	];
	
	# Set hostname
	networking.hostName = hostname;
	
	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	system.stateVersion = "24.05";
	}
	```
	d. Touch `home/username/newmachine.nix` and add the following:
	```nix
	{...}: {
	imports = [
	../modules/common.nix
	../modules/easyeffects.nix
	../modules/gnome.nix
	];
	
	# Enable home-manager
	programs.home-manager.enable = true;
	
	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";
	
	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "24.05";
	
	# Disable warning for release checks
	home.enableNixpkgsReleaseCheck = false;
	}
	```
4. **Update `update.sh`:**

	This script automates updating the flake, and switching system and home-manager to the new config.
	
	Update the following to match your username:
	
	```
	# Update home-manager packages, from the flake
	home-manager switch --flake .#usernamehere@$1;
	```

5. **Complete Setup:**
	```
	# Stage your new files in Git. Otherwise, nix-shell won't build them.
	git add .
	
	# Temporarily install home-manager. This will persist once install is complete.
	nix-shell -p home-manager
	
	# Update the flake, and enable flakes
	nix flake update --experimental-features 'nix-command flakes'
	
	# Build and switch to the new configuration
	bash ./update.sh newmachine
	```
	Done, you can now reboot and the machine will be ready!

## Updating
	
Run: `bash ./update.sh newmachine` 
	
This script is comprised of several steps:
	
```sh
# Update package references/nix flake inputs
nix flake update

# Build and switch to the new instance
sudo nixos-rebuild switch --upgrade --flake .#newmachine;

# Update home-manager packages, from the flake
home-manager switch --flake .#username@newmachine;
```


## References

This repo is based on [AlexNabokikh](https://github.com/AlexNabokikh/nix-config)'s repo, with some configs based on [ZaneyOS](https://gitlab.com/Zaney/zaneyos)

## License

This repository is licensed under MIT License. Feel free to use, modify, and distribute according to the license terms.
