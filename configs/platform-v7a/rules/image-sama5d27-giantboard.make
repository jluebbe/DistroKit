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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_SAMA5D27_GIANTBOARD) += image-sama5d27-giantboard

#
# Paths and names
#
IMAGE_SAMA5D27_GIANTBOARD		:= image-sama5d27-giantboard
IMAGE_SAMA5D27_GIANTBOARD_DIR	        := $(BUILDDIR)/$(IMAGE_SAMA5D27_GIANTBOARD)
IMAGE_SAMA5D27_GIANTBOARD_IMAGE	        := $(IMAGEDIR)/sama5d27-giantboard.hdimg
IMAGE_SAMA5D27_GIANTBOARD_FILES	        := $(IMAGEDIR)/root.tgz
IMAGE_SAMA5D27_GIANTBOARD_CONFIG	:= at91-sd.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_SAMA5D27_GIANTBOARD_ENV := \
        FSBL=barebox-groboards-sama5d27-giantboard-xload-mmc.img \
        SSBL=barebox-groboards-sama5d27-giantboard.img

$(IMAGE_SAMA5D27_GIANTBOARD_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_SAMA5D27_GIANTBOARD)
	@$(call finish)

# vim: syntax=make
