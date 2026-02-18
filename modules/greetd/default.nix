{ pkgs, config, ... }:

let
  # Use only the deduplicated session list from sessionPackages,
  # preventing duplicate entries from environment.systemPackages
  sessionDir = "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
          --issue \
          --time \
          --user-menu \
          --remember \
          --remember-user-session \
          --sessions ${sessionDir} \
          --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' \
          --asterisks \
          --asterisks-char ':3' \
        '';
      };
    }
    ;
  };

  # automatically unlock GNOME keyring
  security.pam.services.greetd.enableGnomeKeyring = true;
}
