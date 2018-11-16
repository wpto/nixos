rm /etc/nixos/configuration.nix
rm /etc/nixos/hardware-configuration.nix
ln -s "/home/dt/.config/nixpkgs/configuration.nix" /etc/nixos/configuration.nix
ln -s "/home/dt/.config/nixpkgs/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
