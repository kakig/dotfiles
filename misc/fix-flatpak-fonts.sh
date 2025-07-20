#!/bin/sh

# Fixes font change not having an effect in Obsidian flatpak
# https://github.com/flatpak/flatpak/issues/4742#issuecomment-1962922356
sudo flatpak override --filesystem=xdg-config/fontconfig
