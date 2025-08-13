{ vars, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  # required for correct display manager functionality
  # https://github.com/NixOS/nixpkgs/pull/297434#issuecomment-2348783988
  systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
}
