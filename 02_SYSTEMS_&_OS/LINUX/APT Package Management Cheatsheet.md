### Essential Commands

```bash
sudo apt update                  # Refresh package lists (always run before upgrade)
sudo apt upgrade                 # Upgrade all installed packages
sudo apt install <package>       # Install a package
sudo apt remove <package>        # Remove a package (keeps config files)
sudo apt purge <package>         # Remove package + its config files
sudo apt autoremove              # Remove unused dependency packages
```

### Useful Info Commands

```bash
apt list --upgradable            # Show packages with available updates
apt list --installed             # Show all installed packages
apt-mark showmanual
apt search <keyword>             # Search for a package
apt show <package>               # Show details about a package
```

### Repository Management

```bash
ls /etc/apt/sources.list.d/      # See all added repositories
sudo rm /etc/apt/sources.list.d/<file>   # Remove a repository
```

### Typical Maintenance Routine

```bash
sudo apt update && sudo apt upgrade      # Update everything
sudo apt autoremove                      # Clean up leftovers
```

---

### Good to Know

- **Phased updates** — some packages upgrade slowly by design, not a bug
- **`.deb` installs** (like VS Code) add their own repo automatically, so they stay updated via `apt`
- **Removing an app** doesn't always remove its repo — check `sources.list.d/` manually
- Always `update` before `upgrade`, never skip it