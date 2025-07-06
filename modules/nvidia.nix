{ config, pkgs, ... }:

{
  # NVIDIA driver configuration
  hardware.nvidia = {
    # Use proprietary drivers (better performance and compatibility)
    open = false;
    
    # Enable power management
    powerManagement.enable = true;
    
    # Enable modesetting for better Wayland support
    modesetting.enable = true;
    
    # Enable PRIME support for laptops with hybrid graphics
    prime = {
      offload.enable = false; # Set to true if you have hybrid graphics
      # sync.enable = true; # Uncomment for sync mode
    };
    
    # Enable nvidia-persistenced for better performance
    nvidiaPersistenced = true;
  };
  
  # Hardware acceleration
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  
  # Boot configuration for NVIDIA
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_UsePageAttributeTable=1"
  ];
}
