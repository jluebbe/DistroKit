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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_SAMA5D3_EDS) += image-sama5d3-eds

#
# Paths and names
#
IMAGE_SAMA5D3_EDS		:= image-sama5d3-eds
IMAGE_SAMA5D3_EDS_DIR		:= $(BUILDDIR)/$(IMAGE_SAMA5D3_EDS)
IMAGE_SAMA5D3_EDS_IMAGE		:= $(IMAGEDIR)/image-sama5d3-eds.hdimg
IMAGE_SAMA5D3_EDS_FILES		:= $(IMAGEDIR)/root.tgz
IMAGE_SAMA5D3_EDS_CONFIG	:= at91-sd.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_SAMA5D3_EDS_ENV := \
        FSBL=barebox-microchip-sama5d3-eds-xload-mmc.img \
        SSBL=barebox-microchip-sama5d3-eds.img

$(IMAGE_SAMA5D3_EDS_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_SAMA5D3_EDS)
	@$(call finish)

# vim: syntax=make
