# -*-makefile-*-
#
# Copyright (C) 2017 by Sascha Hauer <s.hauer@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_RPI2) += image-rpi2

#
# Paths and names
#
IMAGE_RPI2		:= image-rpi2
IMAGE_RPI2_DIR	:= $(BUILDDIR)/$(IMAGE_RPI2)
IMAGE_RPI2_IMAGE	:= $(IMAGEDIR)/rpi2.hdimg
IMAGE_RPI2_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_RPI2_CONFIG	:= rpi2.config
IMAGE_RPI2_DATA    := \
        $(wildcard $(PTXDIST_PLATFORMCONFIGDIR)/rpi-firmware/*.bin) \
        $(wildcard $(PTXDIST_PLATFORMCONFIGDIR)/rpi-firmware/*.elf) \
        $(wildcard $(PTXDIST_PLATFORMCONFIGDIR)/rpi-firmware/*.dat) \
        $(wildcard $(PTXDIST_PLATFORMCONFIGDIR)/rpi-firmware/config.txt)

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

define squote_and_comma
$(subst $(ptx/def/space),$(comma) ,$(addsuffix $(ptx/def/squote),$(addprefix $(ptx/def/squote),$(1))))
endef

IMAGE_RPI2_ENV := \
        FIRMWARE_RPI2="$(call squote_and_comma,$(IMAGE_RPI2_DATA))"

$(IMAGE_RPI2_IMAGE):
	@$(call targetinfo)
	@GPU_MEM=$(PTXCONF_IMAGE_RPI2_GPU_MEM) \
		ptxd_replace_magic "$(PTXDIST_PLATFORMCONFIGDIR)/rpi-firmware/config.txt" > \
		"$(PTXDIST_TEMPDIR)/config.txt"
	@$(call image/genimage, IMAGE_RPI2)
	@$(call finish)

# vim: syntax=make
