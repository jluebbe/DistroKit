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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_SAMA5D27_SOM1_EK) += image-sama5d27-som1-ek

#
# Paths and names
#
IMAGE_SAMA5D27_SOM1_EK		:= image-sama5d27-som1-ek
IMAGE_SAMA5D27_SOM1_EK_DIR	:= $(BUILDDIR)/$(IMAGE_SAMA5D27_SOM1_EK)
IMAGE_SAMA5D27_SOM1_EK_IMAGE	:= $(IMAGEDIR)/sama5d27-som1-ek.hdimg
IMAGE_SAMA5D27_SOM1_EK_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_SAMA5D27_SOM1_EK_CONFIG	:= at91-sd.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_SAMA5D27_SOM1_EK_ENV := \
        FSBL=barebox-sama5d27-som1-ek-xload-mmc.img \
        SSBL=barebox-sama5d27-som1-ek.img

$(IMAGE_SAMA5D27_SOM1_EK_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_SAMA5D27_SOM1_EK)
	@$(call finish)

# vim: syntax=make
