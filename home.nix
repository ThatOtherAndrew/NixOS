{ inputs, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andromeda";
  home.homeDirectory = "/home/andromeda";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    beeper
    ffmpeg
    file
    google-chrome
    hyprshot
    jetbrains.pycharm-professional
    mission-center
    nerd-fonts.jetbrains-mono
    nil
    nwg-displays
    overskride
    pavucontrol
    pinta
    ripgrep-all
    twemoji-color-font
    twitter-color-emoji
    unifont
    unifont_upper
    vesktop
    walker
    zed-editor

    inputs.tsutsumi.packages.${system}.wakatime-ls

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
      # echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.shellAliases = {
    grep = "rga";
    cat = "bat";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [];
      sansSerif = [];
      monospace = ["JetBrains Mono Nerd Font"];
      emoji = [];
    };
  };

  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    hyprcursor.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    # don't conflict with UWSM
    # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/#installation
    systemd.enable = false;

    # use NixOS module packages
    # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#using-the-home-manager-module-with-nixos
    package = null;
    portalPackage = null;

    settings = {
      # Variables
      "$mod" = "SUPER";

      # Imports
      source = [
        "~/.config/hypr/monitors.conf"
        "~/.config/hypr/workspaces.conf"
      ];

      # Autostart
      exec-once = [
        "swww-daemon"
        "waybar"
      ];

      general = {
        border_size = 1;  # border width
        resize_on_border = true;
      };

      input = {
        kb_layout = "gb";
        touchpad.natural_scroll = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      # Binds (https://wiki.hyprland.org/Configuring/Binds/)
      /*
        l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
        r -> release, will trigger on release of a key.
        c -> click, will trigger on release of a key or button as long as the mouse cursor stays inside binds:drag_threshold.
        g -> drag, will trigger on release of a key or button as long as the mouse cursor moves outside binds:drag_threshold.
        o -> longPress, will trigger on long press of a key.
        e -> repeat, will repeat when held.
        n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
        m -> mouse, see below.
        t -> transparent, cannot be shadowed by other binds.
        i -> ignore mods, will ignore modifiers.
        s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
        d -> has description, will allow you to write a description for your bind.
        p -> bypasses the app's requests to inhibit keybinds.
      */

      bind = [
        "$mod, Q, killactive"
        "$mod, T, exec, kitty"
        "$mod, F, fullscreen, toggle"
        "$mod, L, exec, hyprlock --immediate"
        "$mod, N, exec, swaync-client --toggle-panel"
        "$mod, space, exec, walker"
        "$mod, left, movetoworkspace, -1"
        "$mod, right, movetoworkspace, +1"
        "$mod, delete, exec, hyprshot --mode region --freeze --clipboard-only"
        "$mod SHIFT, delete, exec, hyprshot --mode window --freeze --clipboard-only"
        "$mod CTRL, delete, exec, hyprshot --mode output --freeze --clipboard-only"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        "SHIFT, XF86AudioRaiseVolume, exec, swayosd-client --input-volume raise"
        "SHIFT, XF86AudioLowerVolume, exec, swayosd-client --input-volume lower"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness +10"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness -10"
      ];

      bindl = [
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        "SHIFT, XF86AudioMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
      ];
    };
  };

  programs = {
    bash.enable = true;

    git = {
      enable = true;
      userName = "Andromeda";
      userEmail = "stroev.andrew@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };

    starship.enable = true;

    kitty = {
      enable = true;
    };

    waybar = {
      enable = true;
    };

    nh = {
      enable = true;
      flake = "/home/andromeda/nixos";
    };

    obs-studio.enable = true;

    yt-dlp.enable = true;

    hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          grace = 5;
          ignore_empty_input = true;
        };

        fingerprint.enabled = true;

        background = {
          path = "screenshot";
          blur_passes = 2;
          blur_size = 5;
        };

        label = {
          text = "cmd[update:1000] date +%-I:%M";
          font_size = 100;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        };
      };
    };
  };

  services = {
    swww.enable = true;
    swaync.enable = true;
    swayosd.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/andromeda/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "zeditor";
    NIXOS_OZONE_WL = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
