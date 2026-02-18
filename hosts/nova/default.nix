{ inputs, vars, pkgs, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@wheel" ];
    };

    # registry = {};
  };

  imports = with inputs; [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    nixos-hardware.nixosModules.framework-16-7040-amd
    home-manager.nixosModules.home-manager
    nvf.nixosModules.default
    nix-index-database.nixosModules.nix-index
    stylix.nixosModules.stylix
    musnix.nixosModules.musnix

    ../../modules/fonts
    ../../modules/gaming
    ../../modules/greetd
    ../../modules/hyprland
    ../../modules/hyprlock
    ../../modules/infinidesk
    ../../modules/jetbrains
    ../../modules/mullvad
    ../../modules/audio
    ../../modules/python
    ../../modules/shell
    ../../modules/vm
    ../../modules/wlogout
    ../../modules/zed
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${vars.username} = ./home.nix;
  home-manager.extraSpecialArgs = { inherit inputs vars; };
  programs.nix-index-database.comma.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
      grub.timeoutStyle = "hidden";
    };

    # plymouth = let
    #   selected-theme = "rings";
    # in {
    #   enable = true;
    #   themePackages = with pkgs; [
    #     (
    #       adi1090x-plymouth-themes.override {
    #         selected-themes = [ selected-theme ];
    #       }
    #     )
    #   ];
    #   theme = selected-theme;
    # };
    plymouth.enable = true;
  };

  networking.hostName = "nova";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd"; # replaces wpa_supplicant
  };

  # Speed up boot by skipping network checks (redundant with NetworkManager)
  systemd.network.wait-online.enable = false;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0018", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
  '';

  # Enable zram compression
  zramSwap.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.display-name;
    extraGroups = [ "audio" "networkmanager" "wheel" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark-dark.yaml";
    polarity = "dark";
  };

  security.rtkit.enable = true; # recommended for PipeWire

  virtualisation.docker = {
    enable = true;
  };

  virtualisation.waydroid.enable = true;

  hardware.bluetooth.enable = true;

  services = {
    # fwupdmgr (system firmware update manager)
    fwupd.enable = true;

    power-profiles-daemon.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    automatic-timezoned.enable = true;

    fprintd.enable = true;

    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };

    gnome.gnome-keyring.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };

    # required for URIs like trash://
    gvfs.enable = true;
  };

  programs = {
    fuse.userAllowOther = true; # enable FUSE for non-root users

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        glibc
        libcxx
      ];
    };

    nvf = {
      enable = true;

      settings.vim = {
        languages = {
          nix.enable = true;
          python.enable = true;
        };

        lsp.enable = true;

        binds.whichKey.enable = true;
        statusline.lualine.enable = true;
        utility.vim-wakatime.enable = true;
        telescope.enable = true;
      };
    };

    seahorse.enable = true;

    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
