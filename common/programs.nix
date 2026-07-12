{ pkgs, rust-overlay, ... }: {
  # Include packages from rust overlay
  nixpkgs.overlays = [ rust-overlay.overlays.default ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    # Stuff
    pkgs.fastfetch
    pkgs.discord
    pkgs.signal-desktop
    pkgs.obsidian
    pkgs.numbat
    pkgs.usbutils

    # Video Players & Encoders
    pkgs.vlc
    pkgs.ffmpeg-headless
    pkgs.handbrake

    # Visual Art
    pkgs.blender
    pkgs.aseprite
    pkgs.krita
    pkgs.reaper

    # Common Programming Tools
    pkgs.git-credential-manager
    pkgs.git-lfs
    pkgs.just
    pkgs.ghostty
    pkgs.zed-editor
    pkgs.claude-code
    pkgs.godot_4_7
    pkgs.arduino-ide
    pkgs.python3
    pkgs.gcc
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = [
        "rust-analyzer"
        "rust-src"
        "clippy"
        "rustfmt"
      ];
    })
    pkgs.pnpm
    pkgs.nodejs

    # Language Servers
    pkgs.nil
    pkgs.nixd
    pkgs.package-version-server
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Enable Git LFS and GCM
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      credential.credentialStore = "secretservice";
    };
  };
}
