# -*-makefile-*-
#
# Copyright (C) 2017 by Chris Fiege <c.fiege@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_VEXPRESS) += image-vexpress

#
# Paths and names
#
IMAGE_VEXPRESS		:= image-vexpress
IMAGE_VEXPRESS_DIR	:= $(BUILDDIR)/$(IMAGE_VEXPRESS)
IMAGE_VEXPRESS_IMAGE	:= $(IMAGEDIR)/vexpress.hdimg
IMAGE_VEXPRESS_CONFIG	:= vexpress.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_VEXPRESS_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_VEXPRESS)
	@$(call finish)

# vim: syntax=make
