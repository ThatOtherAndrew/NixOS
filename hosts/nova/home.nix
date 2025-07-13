{ inputs, vars, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

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
    mission-center
    nil
    nwg-displays
    overskride
    pavucontrol
    pinta
    ripgrep-all
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

  programs = {
    bash.enable = true;

    git = {
      enable = true;
      userName = vars.display-name;
      userEmail = vars.email;
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
      flake = vars.config-path;
    };

    obs-studio.enable = true;

    yt-dlp.enable = true;
  };

  services = {
    swww.enable = true;
    swaync.enable = true;
    swayosd.enable = true;
    udiskie.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "zeditor";
    NIXOS_OZONE_WL = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
