#!/bin/bash
# run us root

IMG_FILE=debian_arm.img
IMG_SIZE=2048 #Mb

pacman -S debootstrap
#yaourt -S qemu-arm-static

dd if=/dev/zero bs=1M count=$IMG_SIZE of=$IMG_FILE
mkfs.ext4 $IMG_FILE
mkdir mnt
mount -o loop $IMG_FILE mnt
debootstrap --foreign --arch armel sid mnt/
cp /usr/bin/qemu-arm-static mnt/usr/bin/
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true LC_ALL=C LANGUAGE=C LANG=C chroot mnt
/debootstrap/debootstrap --second-stage
