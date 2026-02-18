{ inputs, pkgs, ... }:

let
  infinidesk = inputs.infinidesk.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  environment.systemPackages = [ infinidesk ];

  # Register Infinidesk as a selectable session in greetd/tuigreet
  services.displayManager.sessionPackages = [ infinidesk ];
}
