{

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    ### SCREENS ###
    # Built in eDP-1
    monitor = [
      "desc:BOE 0x095F,preferred,auto,1.56667" # This 1.56667 is for the Framework laptop
      "desc:GIGA-BYTE TECHNOLOGY CO. LTD. Gigabyte M32U 21491B000014,3840x2160@144,auto,1.6" # Big Gigabyte M32 4K@144hz
    ];
    ### END SCREENS ###
    ### ENV Variables###
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,Bibata-Modern-Ice"
    ];
    ### END ENV Variables###

    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "pcmanfm";
    "$menu" = "rofi -show run";
    "$emojiMenu" = "rofi -modi 'emoji:rofimoji' -show emoji";
    ### EXEC ###
    exec-once = "hyprctl setcursor Bibata-Modern-Ice 24";
    ### BINDS ###
    binds = {
      allow_workspace_cycles = true;
    };
    bind = [
      "$mod SHIFT, RETURN, exec, $terminal"
      "$mod, W, killactive"
      "$mod SHIFT, X, exit"
      # Move
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, k, movefocus, u"
      "$mod, L, movefocus, r"
      # Resize
      "$mod SHIFT, H, resizeactive, -10 0"
      "$mod SHIFT, J, resizeactive, 0 10"
      "$mod SHIFT, k, resizeactive, 0 -10"
      "$mod SHIFT, L, resizeactive, 10 0"
      # Launchers
      "$mod, E, exec, $menu"
      "$mod SHIFT, PERIOD, exec, $emojiMenu"
      # Applications
      "$mod SHIFT, E, exec, $fileManager"
      "$mod, F, exec, firefox"
      # Scratchpad
      "$mod, F12, togglespecialworkspace, magic"
      "$mod SHIFT, F12, movetoworkspace, special:magic"
      # Misc
      "$mod, F, togglefloating" # toggle floating
      "$mod, A, workspace, previous" # Cycle to previous workspace

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
    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    # Laptop multimedia keys for volume and LCD brightness
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];
    ### BINDS ###

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
