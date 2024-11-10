{ config, lib, pkgs, ...}:
{

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # Vimium
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";} # 1Password

    ];

  };

}
