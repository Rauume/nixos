{
  inputs,
  outputs,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}: {
  imports = [
    ../modules/flatpak.nix
  ];
  
  # Nixpkgs configuration
  nixpkgs = {

    config = {
      allowUnfree = true;
    };
  };

  # Register flake inputs for nix commands
  nix.registry = lib.mapAttrs (_: flake: {inherit flake;}) (lib.filterAttrs (_: lib.isType "flake") inputs);

  # Add inputs to legacy channels
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs' (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # Boot settings
  boot = {
    kernelPackages = pkgs.linuxPackages_lqx;
    consoleLogLevel = 0;
    initrd.verbose = true;
    kernelParams = ["quiet" "splash" "mitigations=off"];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    #0 to skip showing previous generations. Mash esc on boot to get generation selection screen.
    loader.timeout = 0;
    plymouth.enable = true;
  };

  # Networking
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Australia/Adelaide";

  # Internationalization
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Input settings
  services.libinput.enable = true;

  # X11 settings
  services.xserver = {
    enable = true;
    xkb.layout = "pl";
    xkb.variant = "";
    excludePackages = with pkgs; [xterm];
  };
  
  services.displayManager.gdm.enable = true;

  # PATH configuration
  environment.localBinInPath = true;

  # Disable CUPS printing
  services.printing.enable = false;

  # Enable devmon for device management
  services.devmon.enable = true;

  # Enable PipeWire for sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User configuration
  users.users.${userConfig.name} = {
    description = userConfig.fullName;
    extraGroups = ["dialout" "networkmanager" "wheel" "docker" "gamemode"];
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  # Set User's avatar
  system.activationScripts.script.text = ''
    mkdir -p /var/lib/AccountsService/{icons,users}
    cp ${userConfig.avatar} /var/lib/AccountsService/icons/${userConfig.name}

    touch /var/lib/AccountsService/users/${userConfig.name}

    if ! grep -q "^Icon=" /var/lib/AccountsService/users/${userConfig.name}; then
      if ! grep -q "^\[User\]" /var/lib/AccountsService/users/${userConfig.name}; then
        echo "[User]" >> /var/lib/AccountsService/users/${userConfig.name}
      fi
      echo "Icon=/var/lib/AccountsService/icons/${userConfig.name}" >> /var/lib/AccountsService/users/${userConfig.name}
    fi
  '';

  # Passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  # System packages
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [pip virtualenv]))
    # wl-clipboard
    eza #Alternate ls
    fd #Find
    xh #HTTP client
    dust #Disk usage utility
    # glib
    wget
    btop
    # killall
    # lazydocker
    # mesa
    # nh #Yet another nix cli helper
    pipenv
    pulseaudio
    unzip
    vscode-fhs
    firefox
    google-chrome
    discord
    obsidian
    wireguard-tools
    scrcpy
    spotify
    vlc
    # angryipscanner #Broken :(
    easyeffects
    openvpn
    gnome-boxes
    libvirt
    wineWowPackages.stagingFull
    winetricks
    lutris
    libreoffice-still
    hunspell
    hunspellDicts.en_AU-large
    # moonlight-qt
    vulkan-tools
    nvme-cli
    mangohud
    thonny #rp2040 micropython development
    resources
    r2modman #modding for RiskOfRain2
    dotnetCorePackages.dotnet_9.sdk
    
  ];

  # Zsh configuration
  programs.zsh.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    nerd-fonts.jetbrains-mono
    # nerd-fonts.mplus
    noto-fonts-emoji-blob-bin
    emojione
    roboto
  ];

  # Additional services
  # services.locate.enable = true;
  # services.locate.localuser = null;

  # OpenSSH daemon
  services.openssh.enable = true;
}