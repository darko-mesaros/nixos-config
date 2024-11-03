{ config, lib, pkgs, ...}:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" ];})
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji
    pkgs.liberation_ttf
  ];
}
