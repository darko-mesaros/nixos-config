{pkgs, lib, config, ...}:
{
  security.pam = {
    services = {
      login.fprintAuth = lib.mkForce true;
      gdm-fingerprint = {
        text = ''
          auth sufficient pam_unix.so try_first_pass likeauth nullok
          auth sufficient pam_fprintd.so
        '';
      };
      sudo.fprintAuth = true;
      su.fprintAuth = true;

    };
  };

  environment.systemPackages = with pkgs; [
    libfprint
    fprintd
  ];
}
