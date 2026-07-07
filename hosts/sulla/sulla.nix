{ nixos-hardware, ... }: {
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.framework-amd-ai-300-series
    ../../common/common.nix
  ];

  services.fwupd.enable = true;

  networking.hostName = "sulla";
}
