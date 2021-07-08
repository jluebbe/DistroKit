# -*-makefile-*-
#
# Copyright (C) 2017 by Chris Fiege <c.fiege@pengutronix.de>
# Copyright (C) 2020 by Oleksij Rempel <o.rempel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_MALTA) += image-malta

#
# Paths and names
#
IMAGE_MALTA		:= image-malta
IMAGE_MALTA_DIR	:= $(BUILDDIR)/$(IMAGE_MALTA)
IMAGE_MALTA_IMAGE	:= $(IMAGEDIR)/malta.hdimg
IMAGE_MALTA_CONFIG	:= malta.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_MALTA_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_MALTA)
	@$(call finish)

# vim: syntax=make
