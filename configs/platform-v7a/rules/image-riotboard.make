# -*-makefile-*-
#
# Copyright (C) 2017 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_RIOTBOARD) += image-riotboard

#
# Paths and names
#
IMAGE_RIOTBOARD		:= image-riotboard
IMAGE_RIOTBOARD_DIR	:= $(BUILDDIR)/$(IMAGE_RIOTBOARD)
IMAGE_RIOTBOARD_IMAGE	:= $(IMAGEDIR)/riotboard.hdimg
IMAGE_RIOTBOARD_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_RIOTBOARD_CONFIG	:= riotboard.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_RIOTBOARD_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_RIOTBOARD)
	@$(call finish)

# vim: syntax=make
