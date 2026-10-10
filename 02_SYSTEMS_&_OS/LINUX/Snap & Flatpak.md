### What Are They?

All three (apt, snap, flatpak) are **package managers** but work differently:

APT
  - Made by: Debian/Ubuntu
  - Apps run: system-integrated
  - Updates: manual (apt upgrade)
  - App store: —

Snap
  - Made by: Canonical (Ubuntu)
  - Apps run: sandboxed
  - Updates: automatic
  - App store: snapcraft.io

Flatpak
  - Made by: Independent
  - Apps run: sandboxed
  - Updates: manual
  - App store: flathub.org
---

### Snap Commands

```bash
sudo snap install <package>      # Install
sudo snap remove <package>       # Remove
snap list                        # List installed snaps
snap refresh                     # Update all snaps (usually auto)
```

### Flatpak Commands

```bash
flatpak install <package>        # Install
flatpak uninstall <package>      # Remove
flatpak list                     # List installed
flatpak update                   # Update all flatpaks
```

### Installing Flatpak (not pre-installed)

```bash
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

---

### Good to Know

- **Snap** is built into Ubuntu, love it or hate it — some people dislike it because apps can be slower to start and Canonical controls the store
- **Flatpak** is community-favored, apps are more up-to-date than apt, good for GUI apps
- **APT** is always preferred when available — most native, lightest, best system integration
- Sandboxed (snap/flatpak) means the app is **isolated** from your system — more secure but sometimes causes permission quirks (like accessing files or hardware)

### General Rule of Thumb

> **APT first → Flatpak second → Snap last**

---