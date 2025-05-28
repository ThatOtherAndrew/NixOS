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
    brightnessctl
    file
    google-chrome
    mission-center
    nerd-fonts.jetbrains-mono
    nil
    overskride
    ripgrep-all
    twemoji-color-font
    twitter-color-emoji
    unifont
    unifont_upper
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
      emoji = ["Twitter Color Emoji"];
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

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Variables
      "$mod" = "SUPER";

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
        "$mod, space, exec, walker"
        "$mod, left, movetoworkspace, -1"
        "$mod, right, movetoworkspace, +1"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
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
      keybindings = {
        up = "increase_font_size";
        down = "decrease_font_size";
      };
    };

    waybar = {
      enable = true;
    };

    nh = {
      enable = true;
      flake = "/home/andromeda/nixos";
    };
  };

  services = {
    swww.enable = true;
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
