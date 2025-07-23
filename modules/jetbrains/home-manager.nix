{ pkgs, ... }:

{
  home.packages = with pkgs.jetbrains; [
    (pycharm-professional.override {
      jdk = pkgs.openjdk21;
    })
    (webstorm.override {
      jdk = pkgs.openjdk21;
    })
  ];
}
