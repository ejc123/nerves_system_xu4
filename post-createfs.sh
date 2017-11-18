#!/bin/sh



set -e

FWUP_CONFIG=$NERVES_DEFCONFIG_DIR/fwup.conf

# Run the common post-image processing for nerves
$BR2_EXTERNAL_NERVES_PATH/board/nerves-common/post-createfs.sh $TARGET_DIR $FWUP_CONFIG

BOARD_DIR="$(dirname $0)"
UBOOT_DIR="${BUILD_DIR}/uboot-odroidxu4-v2017.05/sd_fuse"

IMAGE_NAME="nerves_oxdroid_xu4.img"

signed_bl1_position=1
bl2_position=31
uboot_position=63
tzsw_position=1503
env_position=2015

dd iflag=dsync oflag=dsync conv=notrunc if="${UBOOT_DIR}/bl1.bin.hardkernel"            of="${BINARIES_DIR}/${IMAGE_NAME}" seek=$signed_bl1_position
dd iflag=dsync oflag=dsync conv=notrunc if="${UBOOT_DIR}/bl2.bin.hardkernel.720k_uboot" of="${BINARIES_DIR}/${IMAGE_NAME}" seek=$bl2_position
dd iflag=dsync oflag=dsync conv=notrunc if="${BINARIES_DIR}/u-boot-dtb.bin"             of="${BINARIES_DIR}/${IMAGE_NAME}" seek=$uboot_position
dd iflag=dsync oflag=dsync conv=notrunc if="${UBOOT_DIR}/tzsw.bin.hardkernel"           of="${BINARIES_DIR}/${IMAGE_NAME}" seek=$tzsw_position
dd iflag=dsync oflag=dsync conv=notrunc if=/dev/zero                                    of="${BINARIES_DIR}/${IMAGE_NAME}" seek=$env_position count=32 bs=512
