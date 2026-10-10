## 📊 Disk Usage & Space

```
df -h
```

→ Show disk space (human-readable)

```
du -sh *
```

→ Size of files/folders in current directory

```
du -h --max-depth=1
```

→ Folder sizes (1 level deep)

```
ls -lh
```

→ File sizes in readable format

---

## 💽 Disk & Partition Info

```
lsblk
```

→ List disks and partitions

```
sudo fdisk -l
```

→ Detailed partition info

```
blkid
```

→ Show filesystem UUIDs and types

```
mount | column -t
```

→ Show mounted filesystems nicely

---

## 🔌 Mount / Unmount

```
sudo mount /dev/sdX1 /mnt
```

→ Mount a partition

```
sudo umount /mnt
```

→ Unmount

```
sudo mount -a
```

→ Mount everything in `/etc/fstab`

---

## 🧱 Disk Formatting

⚠️ **Danger: deletes data**

```
sudo mkfs.ext4 /dev/sdX1
```

→ Format as ext4

```
sudo mkfs.vfat /dev/sdX1
```

→ Format as FAT32

```
sudo mkfs.ntfs /dev/sdX1
```

→ Format as NTFS

---

## 🔍 Disk Health & Errors

```
dmesg | grep -i error
```

→ Kernel disk errors

```
sudo fsck /dev/sdX1
```

→ Check & repair filesystem

```
sudo smartctl -a /dev/sdX
```

→ Disk health (SMART info)

---

## 📦 Disk Usage Cleanup

```
sudo apt autoremove
```

→ Remove unused packages

```
sudo apt clean
```

→ Clear package cache

```
journalctl --disk-usage
```

→ Check log size

```
sudo journalctl --vacuum-time=7d
```

→ Keep logs for 7 days

---

## 🔎 Find Large Files

```
find / -type f -size +1G
```

→ Files larger than 1GB

```
du -ah / | sort -rh | head -20
```

→ Top 20 largest files

---

## 🧠 Bonus Tips

- Replace `/dev/sdX` with your actual disk (e.g. `/dev/sda`)
    
- Use `lsblk` first to avoid mistakes
    
- Always double-check before formatting or `fsck`