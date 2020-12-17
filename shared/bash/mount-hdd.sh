#/usr/bin/bash
echo "Discovering hard disk mount point"
MOUNT=$(lsblk | grep "sd.[[:digit:]]" | awk '{print $1}' | grep -o '....$')
echo "Mounting hard disk to: /dev/$MOUNT"
sudo mount -o gid=jk,dmask=007,fmask=117 /dev/$MOUNT /mnt
