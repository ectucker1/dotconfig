{ lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
  ];

  networking.hostName = "nomi";

  # Dual-boot with Windows (installed on separate drive).
  # systemd-boot only scans its own ESP, so it can't see Windows on another drive.
  # So we use GRUB with os-prober instead.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    # Disable fancy GRUB rendering to keep it snappy.
    font = null;
    splashImage = null;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nvidia RTX 3070 proprietary driver.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    # Required for Wayland.
    modesetting.enable = true;
    # Open driver is recommended for current-gen cards.
    open = true;
    nvidiaSettings = true;
  };
}
