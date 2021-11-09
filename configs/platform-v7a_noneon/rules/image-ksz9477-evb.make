# -*-makefile-*-
#
# Copyright (C) 2020 by Holger Assmann <h.assmann@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_KSZ9477_EVB) += image-ksz9477-evb

#
# Paths and names
#
IMAGE_KSZ9477_EVB		:= image-ksz9477-evb
IMAGE_KSZ9477_EVB_DIR		:= $(BUILDDIR)/$(IMAGE_KSZ9477_EVB)
IMAGE_KSZ9477_EVB_IMAGE		:= $(IMAGEDIR)/image-ksz9477-evb.hdimg
IMAGE_KSZ9477_EVB_FILES		:= $(IMAGEDIR)/root.tgz
IMAGE_KSZ9477_EVB_CONFIG	:= at91-sd.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_KSZ9477_EVB_ENV := \
        FSBL=barebox-microchip-ksz9477-evb-xload-mmc.img \
        SSBL=barebox-microchip-ksz9477-evb.img

$(IMAGE_KSZ9477_EVB_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_KSZ9477_EVB)
	@$(call finish)

# vim: syntax=make
