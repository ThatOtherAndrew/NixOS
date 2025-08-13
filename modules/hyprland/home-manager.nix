{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprshot
    nwg-displays
    walker
  ];

  home.pointerCursor.hyprcursor.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    # use NixOS module packages
    # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#using-the-home-manager-module-with-nixos
    package = null;
    portalPackage = null;

    settings = {
      # Variables
      "$mod" = "SUPER";

      # Imports
      source = [
        # stateful configuration (for temporary changes / testing / troubleshooting)
        "~/.config/hypr/hyprland-local.conf"

        # nwg-displays
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

      dwindle = {
        preserve_split = true;
        precise_mouse_move = true;
      };

      input = {
        kb_layout = "gb";
        touchpad = {
          natural_scroll = true;
          drag_lock = 0;  # don't hold mouse down on double-tap and drag
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        # needed because of X-NIXOS-SYSTEMD-AWARE
        disable_xdg_env_checks = true;
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
}
