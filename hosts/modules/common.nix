{
  inputs,
  outputs,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}: {
  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];

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
    # kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 0;
    initrd.verbose = true;
    kernelParams = ["quiet" "splash"];
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
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
    displayManager.gdm.enable = true;
  };

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
    extraGroups = ["networkmanager" "wheel" "docker"];
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
    # delta
    # docker-compose
    # gcc
    # wl-clipboard
    eza
    fd
    glib
    # killall
    # lazydocker
    # mesa
    # nh
    #obs-studio
    pipenv
    pulseaudio
    # qt6.qtwayland
    ripgrep
    unzip
    #zoom-us
    vscode
    firefox
    google-chrome
    discord
    obsidian
    # bottles
    wgnord #nordVPN
    wireguard-tools
    prusa-slicer
    mission-center
    scrcpy
    spotify
    vlc
    # angryipscanner #Broken :(
    easyeffects
    btop
    # steam
    mission-center
    wget
    openvpn
    gnome-boxes
    libvirt
    wineWowPackages.stagingFull
    winetricks
    lutris
  ];

  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

  # Zsh configuration
  programs.zsh.enable = true;

  # Fonts configuration
  #fonts.packages = with pkgs; [
  #  (nerdfonts.override {fonts = ["Meslo" "JetBrainsMono"];})
  #  roboto
  #];

  # Additional services
  # services.locate.enable = true;
  # services.locate.localuser = null;

  # OpenSSH daemon
  services.openssh.enable = true;

  #Flatpaks
  services.flatpak.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # xdg.portal.config.common.default = "gtk";

}
