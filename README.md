# My NixOS configuration

Here lie the [NixOS](https://nixos.org/) configuration files I use for my system setup (currently just my [Framework 16](https://frame.work/products/laptop16-diy-amd-7040) laptop). It's rather janky and _probably_ will break on differing hardware, but hey - it's mine.

## Installation

> [!NOTE]
> These instructions will only work on a NixOS machine.

First, clone the repository to a sensible location (e.g. `~/nixos`):
```bash
git clone https://github.com/ThatOtherAndrew/NixOS ~/nixos
```

Edit the `variables.nix` file to configure individual settings (e.g. your username and email), then rebuild!
```bash
sudo nixos-rebuild switch --flake ~/nixos
```
