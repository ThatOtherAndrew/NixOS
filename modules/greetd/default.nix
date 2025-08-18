{ pkgs, ... }:

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
          --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' \
          --asterisks \
          --asterisks-char ':3' \
        '';
      };
    }
    ;
  };
}
