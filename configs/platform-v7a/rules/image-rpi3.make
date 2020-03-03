# -*-makefile-*-
#
# Copyright (C) 2017 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_RPI3) += image-rpi3

#
# Paths and names
#
IMAGE_RPI3		:= image-rpi3
IMAGE_RPI3_DIR	:= $(BUILDDIR)/$(IMAGE_RPI3)
IMAGE_RPI3_IMAGE	:= $(IMAGEDIR)/rpi3.hdimg
IMAGE_RPI3_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_RPI3_CONFIG	:= rpi3.config
IMAGE_RPI3_DATA_DIR	:= $(call ptx/in-platformconfigdir, rpi-firmware)
IMAGE_RPI3_DATA		:= \
	$(wildcard $(IMAGE_RPI3_DATA_DIR)/*.bin) \
	$(wildcard $(IMAGE_RPI3_DATA_DIR)/*.elf) \
	$(wildcard $(IMAGE_RPI3_DATA_DIR)/*.dat) \
	$(wildcard $(IMAGE_RPI3_DATA_DIR)/*.dtb) \
	$(wildcard $(IMAGE_RPI3_DATA_DIR)/config.txt)

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

define squote_and_comma
$(subst $(ptx/def/space),$(comma) ,$(addsuffix $(ptx/def/squote),$(addprefix $(ptx/def/squote),$(1))))
endef

IMAGE_RPI3_ENV := \
        FIRMWARE_RPI3="$(call squote_and_comma,$(IMAGE_RPI3_DATA))"

$(IMAGE_RPI3_IMAGE):
	@$(call targetinfo)
	@GPU_MEM=$(PTXCONF_IMAGE_RPI3_GPU_MEM) \
		ptxd_replace_magic "$(IMAGE_RPI3_DATA_DIR)/config.txt" > \
		"$(PTXDIST_TEMPDIR)/config.txt"
	@$(call image/genimage, IMAGE_RPI3)
	@$(call finish)

# vim: syntax=make
