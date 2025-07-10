{ ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "sleep 0.3 && hyprlock --immediate";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Sleep";
        keybind = "s";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Power off";
        keybind = "p";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        box-shadow: none;
      }

      window {
        background-color: rgba(0, 0, 0, 0.7)
      }

      button {
        font-size: 23px;
        margin: 120px 0px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 20%;
        background-color: black;
        opacity: 0.8;
        border: none;
        border-radius: 0px;
        transition: .3s cubic-bezier(0.33, 1, 0.68, 1) all;
      }

      button:focus {
        background-size: 25%;
        background-color: rebeccapurple;
        border: none;
      }

      button:hover {
        background-size: 35%;
        background-color: rebeccapurple;
        margin: 75px 0px;
        border-radius: 50px;
      }

      #lock {
        border-radius: 50px 0px 0px 50px;
        background-image: image(url("icons/lock.png"));
      }

      #suspend {
        background-image: image(url("icons/suspend.png"));
      }

      #hibernate {
        background-image: image(url("icons/hibernate.png"));
      }

      #shutdown {
        background-image: image(url("icons/shutdown.png"));
      }

      #reboot {
        border-radius: 0px 50px 50px 0px;
        background-image: image(url("icons/reboot.png"));
      }

      #lock:hover, #reboot:hover {
        border-radius: 50px;
      }
    '';
  };

  # Add ctrl-alt-del Hyprland keybind
  wayland.windowManager.hyprland.settings.bind = [
    "CTRL ALT, delete, exec, pgrep -x wlogout || wlogout --buttons-per-row 5"
  ];

  home.file = {
    ".config/wlogout/icons/" = {
      source = ./icons;
      recursive = true;
    };
  };
}
