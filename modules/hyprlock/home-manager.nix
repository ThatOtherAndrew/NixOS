{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 5;
        ignore_empty_input = true;
        enable_fingerprint = true;
      };

      auth.fingerprint.enabled = true;

      background = {
        path = "screenshot";
        blur_passes = 2;
        blur_size = 5;
      };

      label = {
        text = "cmd[update:1000] date +%-I:%M";
        font_size = 100;
        font_family = "JetBrains Mono Extrabold";
        position = "0, 200";
        halign = "center";
        valign = "center";
      };
    };
  };
}
