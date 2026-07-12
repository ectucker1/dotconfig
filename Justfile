deploy hostname:
  nixos-rebuild switch --flake .#{{hostname}} --sudo

dry-run hostname:
  nixos-rebuild dry-activate --flake .#{{hostname}} --sudo

search package:
  nix --extra-experimental-features 'nix-command flakes' search nixpkgs {{package}}

update:
  nix --extra-experimental-features 'nix-command flakes' flake update

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old
