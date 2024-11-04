{ config, lib, pkgs, ...}:
{
  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Bibata-Modern-Ice";
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Bibata-Modern-Ice
    '';
}
