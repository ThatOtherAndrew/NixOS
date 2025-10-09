{ inputs, vars, pkgs, ... }:

{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

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
    beeper
    ( bottles.override { removeWarningPopup = true; } )
    capacities
    godot
    google-chrome
    mission-center
    overskride
    pavucontrol
    pinta
    slack
    vesktop
    vital
  ];

  home.pointerCursor = {
    enable = true;
    x11.enable = true;
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
    kitty = {
      enable = true;
    };

    waybar = {
      enable = true;
    };
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
