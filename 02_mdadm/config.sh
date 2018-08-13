yum install -y mdadm smartmontools hdparm gdisk
mdadm --zero-superblock /dev/sd{b,c,d,e}
mdadm --create /dev/md0 -l5 -n 4 /dev/sd{b,c,d,e}
for i in `seq 1 5`; do
  (
    echo n # Add a new partition
    echo p # Primary partition
    echo $i # Partition number
    echo   # First sector (Accept default: 1)
    echo   +100M # Last sector (Accept default: varies)
    echo w # Write changes
    ) | gdisk /dev/md0
done
mkfs.ext4 /dev/md0
mdadm --verbose --detail --scan > /etc/mdadm.conf

mdadm /dev/md0 -f /dev/sde
mdadm /dev/md0 --remove /dev/sde
mdadm --zero-superblock /dev/sde
mdadm /dev/md0 --add /dev/sde
