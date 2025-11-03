{ vars, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  programs.steam.enable = true;

  # https://wiki.nixos.org/wiki/Lutris
  security.pam.loginLimits = [{
    domain = "@users";
    type = "hard";
    item = "nofile";
    value = "524288";
  }];
}
