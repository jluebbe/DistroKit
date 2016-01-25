# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
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
IMAGE_BOOT_VFAT_DATA	:= \
	$(wildcard $(PTXDIST_PLATFORMCONFIGDIR)/firmware/*.bin) \
	$(wildcard $(PTXDIST_PLATFORMCONFIGDIR)/firmware/*.elf) \
	$(wildcard $(PTXDIST_PLATFORMCONFIGDIR)/firmware/*.dat) \
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
	HEADER=$(PTXDIST_PLATFORMCONFIGDIR)/first32k.bin \
	BAREBOX=barebox-image \
	BAREBOX_ENV=barebox-default-environment \
	KERNEL=linuximage \
	START=$(PTXDIST_PLATFORMCONFIGDIR)/firmware/$(PTXCONF_IMAGE_BOOT_VFAT_START)_start.elf

$(IMAGE_BOOT_VFAT_IMAGE):
	@$(call targetinfo)
	@GPU_MEM=$(PTXCONF_IMAGE_BOOT_VFAT_GPU_MEM) \
		ptxd_replace_magic "$(PTXDIST_PLATFORMCONFIGDIR)/config.txt" > \
		"$(PTXDIST_TEMPDIR)/config.txt"
	@$(call image/genimage, IMAGE_BOOT_VFAT)
	@$(call finish)

# vim: syntax=make
