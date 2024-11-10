# This goes in your configuration.nix
{ config, pkgs, ... }:

{
  # Enable power management
  powerManagement.enable = true;

  # Configure logind for lid switch handling
  services.logind = {
    lidSwitch = "suspend";          # What to do when lid is closed
    lidSwitchExternalPower = "suspend"; # What to do when on external power
    lidSwitchDocked = "ignore";     # What to do when docked (optional)
    
    # Additional power management settings
    extraConfig = ''
      # Handles lid switch even when external monitor is connected
      HandleLidSwitchDocked=suspend
      
      # Time before system suspends on idle (in minutes)
      IdleAction=suspend
      IdleActionSec=30min
    '';
  };

  # Enable suspend-then-hibernate (optional, for better battery life)
  systemd.sleep.extraConfig = ''
    [Sleep]
    SuspendMode=suspend
    SuspendState=mem standby freeze
    # Hibernate after 2 hours of sleep
    HibernateDelaySec=7200
  '';

  # Optional: Install power management tools
  environment.systemPackages = with pkgs; [
    acpi  # Battery status tool
    powertop  # Power consumption analyzer
  ];

  # Optional: Enable TLP for better power management
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #     
  #     # Optional: Prevent USB devices from waking up the system
  #     USB_AUTOSUSPEND = 1;
  #   };
  # };
}
