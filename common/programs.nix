{
  pkgs,
  rust-overlay,
  llm-agents,
  ...
}:
{
  # Include packages from rust overlay
  nixpkgs.overlays = [
    rust-overlay.overlays.default
    llm-agents.overlays.shared-nixpkgs
  ];

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
    pkgs.chromium

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
    pkgs.llm-agents.claude-code
    pkgs.godot_4_7
    pkgs.arduino-ide
    pkgs.python3
    pkgs.gcc
    (pkgs.rust-bin.stable.latest.default.override {
      targets = [
        "thumbv6m-none-eabi"
        "wasm32-unknown-unknown"
      ];
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

  # Install steam
  programs.steam = {
    enable = true;
  };

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
