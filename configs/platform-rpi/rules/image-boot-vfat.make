# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_BOOT_VFAT) += image-boot-vfat

#
# Paths and names
#
IMAGE_BOOT_VFAT		:= image-boot-vfat
IMAGE_BOOT_VFAT_DIR	:= $(BUILDDIR)/$(IMAGE_BOOT_VFAT)
IMAGE_BOOT_VFAT_IMAGE	:= $(IMAGEDIR)/boot.vfat
IMAGE_BOOT_VFAT_DATA_DIR:= $(call ptx/in-platformconfigdir, firmware)
IMAGE_BOOT_VFAT_DATA	:= \
	$(wildcard $(IMAGE_BOOT_VFAT_DATA_DIR)/*.bin) \
	$(wildcard $(IMAGE_BOOT_VFAT_DATA_DIR)/*.elf) \
	$(wildcard $(IMAGE_BOOT_VFAT_DATA_DIR)/*.dat) \
	$(PTXDIST_TEMPDIR)/config.txt
IMAGE_BOOT_VFAT_CONFIG	:= boot-vfat.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

define squote_and_comma
$(subst $(ptx/def/space),$(comma) ,$(addsuffix $(ptx/def/squote),$(addprefix $(ptx/def/squote),$(1))))
endef


IMAGE_BOOT_VFAT_ENV := \
	FILES="$(call squote_and_comma,$(IMAGE_BOOT_VFAT_DATA))" \
	BAREBOX=barebox-image \
	BAREBOX_ENV=barebox-default-environment \
	KERNEL=linuximage

$(IMAGE_BOOT_VFAT_IMAGE):
	@$(call targetinfo)
	@GPU_MEM=$(PTXCONF_IMAGE_BOOT_VFAT_GPU_MEM) \
		ptxd_replace_magic "$(IMAGE_BOOT_VFAT_DATA_DIR)/config.txt" > \
		"$(PTXDIST_TEMPDIR)/config.txt"
	@$(call image/genimage, IMAGE_BOOT_VFAT)
	@$(call finish)

# vim: syntax=make
