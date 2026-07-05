{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../common/common.nix
  ];

  networking.hostName = "nomi";
}
