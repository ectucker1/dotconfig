{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    # Stuff
    pkgs.fastfetch
    pkgs.discord
    pkgs.signal-desktop

    # Common Programming Tools
    pkgs.git-lfs
    pkgs.just
    pkgs.zed-editor
    pkgs.claude-code
    pkgs.godot_4_7

    # Language Servers
    pkgs.nil
    pkgs.nixd
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Enable Git LFS
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
