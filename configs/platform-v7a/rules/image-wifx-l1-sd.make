# -*-makefile-*-
#
# Copyright (C) 2020 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_WIFX_L1_SD) += image-wifx-l1-sd

#
# Paths and names
#
IMAGE_WIFX_L1_SD	:= image-wifx-l1-sd
IMAGE_WIFX_L1_SD_DIR	:= $(BUILDDIR)/$(IMAGE_WIFX_L1_SD)
IMAGE_WIFX_L1_SD_IMAGE	:= $(IMAGEDIR)/wifx-l1.hdimg
IMAGE_WIFX_L1_SD_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_WIFX_L1_SD_CONFIG	:= at91-sd.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_WIFX_L1_SD_ENV := \
        FSBL=at91bootstrap.bin \
        SSBL=barebox-wifx-l1.img

$(IMAGE_WIFX_L1_SD_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_WIFX_L1_SD)
	@$(call finish)

# vim: syntax=make
