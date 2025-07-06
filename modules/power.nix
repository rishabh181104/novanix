{ config, pkgs, ... }:

{
  services.power-profiles-daemon.enable = true;
  # Optionally, enable TLP for advanced power management (uncomment if needed):
  # services.tlp.enable = true;
  # Configure suspend/hibernate settings:
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowHybridSleep=yes
    AllowSuspendThenHibernate=yes
  '';
}
