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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_RPI2) += image-rpi2

#
# Paths and names
#
IMAGE_RPI2		:= image-rpi2
IMAGE_RPI2_DIR	:= $(BUILDDIR)/$(IMAGE_RPI2)
IMAGE_RPI2_IMAGE	:= $(IMAGEDIR)/rpi.hdimg
IMAGE_RPI2_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_RPI2_CONFIG	:= rpi2.config
IMAGE_RPI2_DATA_DIR	:= $(call ptx/in-platformconfigdir, rpi-firmware)
IMAGE_RPI2_DATA		:= \
	$(wildcard $(IMAGE_RPI2_DATA_DIR)/*.bin) \
	$(wildcard $(IMAGE_RPI2_DATA_DIR)/*.elf) \
	$(wildcard $(IMAGE_RPI2_DATA_DIR)/*.dat) \
	$(wildcard $(IMAGE_RPI2_DATA_DIR)/*.dtb) \
	$(wildcard $(IMAGE_RPI2_DATA_DIR)/config.txt)

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
	@$(call image/genimage, IMAGE_RPI2)
	@$(call finish)

# vim: syntax=make
