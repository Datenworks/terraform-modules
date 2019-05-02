#! /bin/bash

sleep 30

set -e

if blkid /dev/sdb;then 
        exit
else 
        mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb; \
        mkdir -p /mnt/disks/data
        mount -o discard,defaults /dev/sdb /mnt/disks/data
        cp /etc/fstab /etc/fstab.backup
        echo UUID=`blkid -s UUID -o value /dev/sdb` /mnt/disks/data ext4 discard,defaults,nofail 0 2 | tee -a /etc/fstab
fi