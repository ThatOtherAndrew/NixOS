{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    twemoji-color-font
    unifont
    unifont_upper
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ ];
      sansSerif = [ ];
      monospace = [ "JetBrains Mono Nerd Font" ];
      emoji = [ "Twitter Color Emoji" ];
    };
  };

  # xdg.configFile."fontconfig/conf.d/99-emoji-replacement.conf".text = ''
  #   <?xml version="1.0"?>
  #   <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  #   <fontconfig>
  #     <match target="pattern">
  #       <test qual="any" name="family">
  #         <string>Segoe UI Emoji</string>
  #       </test>
  #       <edit name="family" mode="assign" binding="strong">
  #         <string>Twitter Color Emoji</string>
  #       </edit>
  #     </match>
  #   </fontconfig>
  # '';
}
