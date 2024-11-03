{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1.56667"; # This 1.56667 is for the Framework laptop
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "dolphin";
    "$menu" = "rofi -show run";
    #exec-once = "waybar &";
    bind = [
      "$mod SHIFT, RETURN, exec, $terminal"
      "$mod, W, killactive"
      "$mod SHIFT, X, exit"
      "$mod, E, exec, $menu"
      "$mod, F, exec, firefox"
    ]
    ++ (
      builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
        )
        9)
        );

    general = {
      gaps_in = 2;
      gaps_out = 5;
      border_size = 1;
      layout = "dwindle";
    };
    decoration = {
      rounding = 2;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      drop_shadow = false;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };
    animations = {
      enabled = false;
    };
    input = {
      follow_mouse = 0;
      touchpad = {
        natural_scroll = true;
        tap-to-click = false;
        clickfinger_behavior = true;
      };
    };
  };
}
