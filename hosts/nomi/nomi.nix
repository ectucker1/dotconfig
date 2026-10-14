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

  # Arturia MiniFuse 2 only exposes a stereo capture device,
  # so a mic on one input gets averaged with the other (silent) input when downmixed to mono.
  # Expose each input as its own mono source for Discord etc.
  services.pipewire.extraConfig.pipewire."91-minifuse-mono-mic" =
    let
      minifuseInput = n: channel: {
        name = "libpipewire-module-loopback";
        args = {
          "node.description" = "MiniFuse Mic (Input ${toString n})";
          "capture.props" = {
            "node.name" = "capture.minifuse_input${toString n}";
            "audio.position" = [ channel ];
            "stream.dont-remix" = true;
            "target.object" = "alsa_input.usb-ARTURIA_ArturiaMsd_8840400607300448-00.analog-stereo";
            "node.passive" = true;
          };
          "playback.props" = {
            "node.name" = "minifuse_input${toString n}";
            "media.class" = "Audio/Source";
            "audio.position" = [ "MONO" ];
          };
        };
      };
    in
    {
      "context.modules" = [
        (minifuseInput 1 "FL")
        (minifuseInput 2 "FR")
      ];
    };
}
