{lib, ...}: let
  wallpaper = ./../../files/wallpapers/wallpaper.jpg;
in
  with lib.hm.gvariant; {
    imports = [
      ./gtk.nix
      ./pop-shell.nix
    ];

    dconf.settings = {
      "org/gnome/calculator" = {
        "accuracy" = 9;
        "angle-units" = "degrees";
        "base" = 10;
        "button-mode" = "basic";
        "number-format" = "automatic";
        "show-thousands" = false;
        "show-zeroes" = false;
        "source-currency" = "";
        "source-units" = "degree";
        "target-currency" = "";
        "target-units" = "radian";
        "window-maximized" = false;
      };

      "org/gnome/desktop/interface" = {
      #   "cursor-theme" = "Yaru";
      #   "font-name" = "Roboto 11";
      #   "icon-theme" = "Tela-circle-dark";
      #   "color-scheme" = "prefer-dark";
      #   "document-font-name" = "Roboto 11";
      #   "enable-animations" = false;
        "enable-hot-corners" = false;
      #   "font-antialiasing" = "grayscale";
      #   "font-hinting" = "slight";
      #   "monospace-font-name" = "MesloLGS Nerd Font Mono 13";
      #   "show-battery-percentage" = true;
      #   "toolkit-accessibility" = false;
      };

      "org/gnome/tweaks" = {
        "show-extensions-notice" = false;
      };

      "org/gtk/gtk4/settings/color-chooser" = {
        "custom-colors" = [(mkTuple [0.74901962280273438 0.7450980544090271 0.7764706015586853 1.0])];
        "selected-color" = mkTuple [true 0.87058824300765991 0.86666667461395264 0.85490196943283081 1.0];
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        "show-hidden" = true;
      };

      "org/gtk/settings/file-chooser" = {
        "date-format" = "regular";
        "location-mode" = "path-bar";
        "show-hidden" = true;
        "show-size-column" = true;
        "show-type-column" = true;
        "sort-column" = "name";
        "sort-directories-first" = true;
        "sort-order" = "ascending";
        "type-format" = "category";
        "view-type" = "list";
      };

      # "org/gnome/desktop/background" = {
      #   "color-shading-type" = "solid";
      #   "picture-options" = "zoom";
      #   "picture-uri" = "file://${wallpaper}";
      #   "picture-uri-dark" = "file://${wallpaper}";
      #   "primary-color" = "#000000000000";
      #   "secondary-color" = "#000000000000";
      # };

      # "org/gnome/desktop/input-sources" = {
      #   "current" = mkUint32 0;
      #   "mru-sources" = [(mkTuple ["xkb" "pl"]) (mkTuple ["xkb" "ru"])];
      #   "show-all-sources" = false;
      #   "sources" = [(mkTuple ["xkb" "pl"]) (mkTuple ["xkb" "ru"])];
      #   "xkb-options" = ["terminate:ctrl_alt_bksp"];
      # };

      "org/gnome/desktop/peripherals/keyboard" = {
        "delay" = mkUint32 250;
        "repeat-interval" = mkUint32 20;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        "speed" = 0.0;
        "accel-profile" = "flat";
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        "speed" = 0.4;
        "tap-to-click" = true;
        "two-finger-scrolling-enabled" = true;
      };

      "org/gnome/desktop/privacy" = {
        "old-files-age" = mkUint32 30;
        "recent-files-max-age" = -1;
      };

      "org/gnome/desktop/session" = {
        "idle-delay" = mkUint32 900;
      };

      "org/gnome/desktop/wm/keybindings" = {
        "close" = ["<Super>q"];
        "minimize" = ["<Super>comma"];
        "move-to-center" = ["<Control><Alt>c"];
        "move-to-workspace-1" = ["<Super><Shift>1"];
        "move-to-workspace-10" = ["<Super><Shift>0"];
        "move-to-workspace-2" = ["<Super><Shift>2"];
        "move-to-workspace-3" = ["<Super><Shift>3"];
        "move-to-workspace-4" = ["<Super><Shift>4"];
        "move-to-workspace-5" = ["<Super><Shift>5"];
        "move-to-workspace-6" = ["<Super><Shift>6"];
        "move-to-workspace-7" = ["<Super><Shift>7"];
        "move-to-workspace-8" = ["<Super><Shift>8"];
        "move-to-workspace-9" = ["<Super><Shift>9"];
        "switch-applications" = ["<Super>Tab"];
        "switch-to-workspace-1" = ["<Super>1"];
        "switch-to-workspace-2" = ["<Super>2"];
        "switch-to-workspace-3" = ["<Super>3"];
        "switch-to-workspace-4" = ["<Super>4"];
        "switch-to-workspace-5" = ["<Super>5"];
        "switch-to-workspace-6" = ["<Super>6"];
        "switch-to-workspace-7" = ["<Super>7"];
        "switch-to-workspace-8" = ["<Super>8"];
        "switch-to-workspace-9" = ["<Super>9"];
        "toggle-maximized" = ["<Super>m"];
      };

      "org/gnome/desktop/wm/preferences" = {
        # "button-layout" = lib.mkForce "";
        "button-layout" = "appmenu:minimize,close";
        # "focus-mode" = "sloppy";
        # "num-workspaces" = 5;
        # "titlebar-font" = "Roboto Bold 11";
        # "workspace-names" = ["1"];
      };

      # "org/gnome/mutter" = {
      #   "center-new-windows" = true;
      #   "dynamic-workspaces" = true;
      #   "edge-tiling" = false;
      # };

      "org/gnome/nautilus/preferences" = {
        "default-folder-viewer" = "list-view";
        "migrated-gtk-settings" = true;
        "search-filter-time-type" = "last_modified";
        "search-view" = "list-view";
      };

      # "org/gnome/settings-daemon/plugins/color" = {
      #   "night-light-enabled" = true;
      #   "night-light-last-coordinates" = mkTuple [44.437359000257999 26.090661799999999];
      #   "night-light-temperature" = mkUint32 3700;
      # };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        "custom-keybindings" = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/"
        ];
        #lock screen gnome
        "screensaver" = ["<Alt><Ctrl>l"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        "binding" = "<Super>t";
        "command" = "kgx";
        "name" = "Gnome Console";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        "binding" = "<Super>f";
        "command" = "nautilus";
        "name" = "Files";
      };

      "org/gnome/settings-daemon/plugins/power" = {
        "sleep-inactive-ac-type" = "nothing";
        "sleep-inactive-battery-type" = "nothing";
      };

      "org/gnome/shell" = {
        "disable-user-extensions" = false;
        "enabled-extensions" = [
          "clipboard-history@alexsaveau.dev"
          "pop-shell@system76.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "runcat@kolesnikov.se"
          "emoji-copy@felipeftn"
          "quicksettings-audio-devices-hider@marcinjahn.com"
          "azwallpaper@azwallpaper.gitlab.com" # Wallpaper Slideshow
          "status-icons@gnome-shell-extensions.gcampax.github.com"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"          
        ];
        "favorite-apps" = [
          "org.gnome.Console.desktop"
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "net.nokyan.Resources.desktop"
          "discord.desktop"
          "steam.desktop"
          "obsidian.desktop"
        ];
      };

      "org/gnome/shell/extensions/azwallpaper" = {
        "slideshow-show-quick-settings-entry" = false;
        "slideshow-use-absolute-time-for-duration" = true;
        "slideshow-directory" = "/home/cam/Pictures/Bing Wallpapers";
        "bing-wallpaper-download" = true;
        "bing-download-directory" = "/home/cam/Pictures/Bing Wallpapers";
        "bing-wallpaper-download-count" = 8;
      };
      
      "org/gnome/shell/extensions/runcat" = {
        "displaying-items" = "character-and-percentage";
        "idle-threshold" = 10;
      };

      "org/gnome/shell/extensions/emoji-copy" = {
        "emoji-keybind" = ["<super>period"];
        "always-show" = false;
      };

      "org/gnome/shell/extensions/clipboard-history" = {
        "display-mode" = 0;
        "next-entry" = ["<Shift><Alt>j"];
        "prev-entry" = ["<Shift><Alt>k"];
        "toggle-menu" = ["<Shift><Alt>v"];
      };
      
      "org/gnome/shell/extensions/user-theme" = {
        "name" = "everforest-dark-shell";
      };

      "org/gnome/shell/extensions/pop-shell" = {
        "active-hint" = false;
        "gap-inner" = mkUint32 1;
        "gap-outer" = mkUint32 1;
        "tile-by-default" = true;
      };

      "org/gnome/shell/extensions/space-bar/appearance" = {
        "inactive-workspace-text-color" = "rgb(154,153,150)";
        "workspace-margin" = 3;
        "workspaces-bar-padding" = 3;
      };

      "org/gnome/shell/extensions/space-bar/behavior" = {
        "scroll-wheel" = "panel";
        "show-empty-workspaces" = false;
        "smart-workspace-names" = false;
        "toggle-overview" = false;
      };

      "org/gnome/shell/extensions/space-bar/shortcuts" = {
        "enable-activate-workspace-shortcuts" = true;
        "enable-move-to-workspace-shortcuts" = true;
      };

      "org/gnome/shell/extensions/unblank" = {
        "power" = false;
        "time" = 0;
      };

      "org/gnome/shell/keybindings" = {
        "show-screen-recording-ui" = ["<Shift><Super>r"];
        "show-screenshot-ui" = ["<Ctrl><Alt>S"];
        "switch-to-application-1" = [];
        "switch-to-application-2" = [];
        "switch-to-application-3" = [];
        "switch-to-application-4" = [];
        "switch-to-application-5" = [];
        "switch-to-application-6" = [];
        "switch-to-application-7" = [];
        "switch-to-application-8" = [];
        "switch-to-application-9" = [];
        "toggle-application-view" = ["<Super>a"];
        "toggle-message-tray" = ["<Super>v"];
      };

      "org/gnome/system/location" = {
        "enabled" = true;
      };

      "system/locale" = {
        "region" = "en_AU.UTF-8";
      };
    };
  }
