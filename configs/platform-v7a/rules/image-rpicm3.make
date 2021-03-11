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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_RPICM3) += image-rpicm3

#
# Paths and names
#
IMAGE_RPICM3		:= image-rpicm3
IMAGE_RPICM3_DIR	:= $(BUILDDIR)/$(IMAGE_RPICM3)
IMAGE_RPICM3_IMAGE	:= $(IMAGEDIR)/rpicm3.hdimg
IMAGE_RPICM3_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_RPICM3_CONFIG	:= rpicm3.config
IMAGE_RPICM3_DATA_DIR	:= $(call ptx/in-platformconfigdir, rpi-firmware)
IMAGE_RPICM3_DATA		:= \
	$(wildcard $(IMAGE_RPICM3_DATA_DIR)/*.bin) \
	$(wildcard $(IMAGE_RPICM3_DATA_DIR)/*.elf) \
	$(wildcard $(IMAGE_RPICM3_DATA_DIR)/*.dat) \
	$(wildcard $(IMAGE_RPICM3_DATA_DIR)/*.dtb) \
	$(wildcard $(IMAGE_RPICM3_DATA_DIR)/config.txt)

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

define squote_and_comma
$(subst $(ptx/def/space),$(comma) ,$(addsuffix $(ptx/def/squote),$(addprefix $(ptx/def/squote),$(1))))
endef

IMAGE_RPICM3_ENV := \
        FIRMWARE_RPI3="$(call squote_and_comma,$(IMAGE_RPICM3_DATA))"

$(IMAGE_RPICM3_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_RPICM3)
	@$(call finish)

# vim: syntax=make
