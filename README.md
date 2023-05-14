# Windows/Mac
Only run `./setup.sh`

# Fedora
`./setup.sh` and then `sudo ./sudo-setup.sh`

# Fedora checklist as of 37

## Threadirqs (audio)

`sudo nano /etc/default/grub`

Add `threadirqs mitigations=off` to `GRUB_CMDLINE_LINUX=""` 

`sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg`

## X11 patch

https://copr.fedorainfracloud.org/coprs/calcastor/gnome-patched/

## Build stuff

`sudo dnf group install "C Development Tools and Libraries" "Development Tools"`

## Rust (use nightly)

`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

## Helix

https://github.com/helix-editor/helix

## Wezterm

https://wezfurlong.org/wezterm/install/linux.html

## Use Wezterm in File Manager right click

`sudo dnf install nautilus-python`

`sudo pip install nautilus-open-any-terminal`

`glib-compile-schemas ~/.local/share/glib-2.0/schemas/`

`gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal wezterm`

## RPM

`sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`

## Better fonts

https://copr.fedorainfracloud.org/coprs/dawid/better_fonts/

## Codecs

`sudo dnf groupupdate multimedia sound-and-video`

## Flatpaks

https://flatpak.org/setup/Fedora

## Appimagelauncher

https://github.com/TheAssassin/AppImageLauncher

## Gamecube

`sudo dnf install gcadapter_oc-dkms`

## Razer

Openrazer (Driver)

https://openrazer.github.io/

Polychromatic (UI)

https://polychromatic.app/

## XClip (vim/helix clipboard)

`sudo dnf install xclip`

