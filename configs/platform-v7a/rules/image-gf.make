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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_GF) += image-gf

#
# Paths and names
#
IMAGE_GF		:= image-gf
IMAGE_GF_DIR	:= $(BUILDDIR)/$(IMAGE_GF)
IMAGE_GF_IMAGE	:= $(IMAGEDIR)/gf.hdimg
IMAGE_GF_CONFIG	:= gf.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_GF_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_GF)
	@$(call finish)

# vim: syntax=make
