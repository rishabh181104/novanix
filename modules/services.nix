{ config, pkgs, ... }: 

{
  services = {
# Display and compositor
    picom.enable = true;

# Input handling
    libinput.enable = true;

# Network services
    openssh.enable = true;

# Hardware and device management
    udev.packages = with pkgs; [ libmtp ];
    udisks2.enable = true;

# Audio system
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };

# Printing (optional - uncomment if needed)
# printing.enable = true;
# avahi = {
#   enable = true;
#   nssmdns4 = true;
# };

# Bluetooth (if you have bluetooth hardware)
    blueman.enable = true;
  };

# Security and authentication
  security.polkit.enable = true;
  programs.ssh.startAgent = true;

# System optimization
  powerManagement.cpuFreqGovernor = "performance";

# Disable pulseaudio in favor of pipewire
  services.pulseaudio.enable = false;
}
