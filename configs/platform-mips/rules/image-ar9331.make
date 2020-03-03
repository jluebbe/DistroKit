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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_AR9331) += image-ar9331

#
# Paths and names
#
IMAGE_AR9331		:= image-ar9331
IMAGE_AR9331_DIR	:= $(BUILDDIR)/$(IMAGE_AR9331)
IMAGE_AR9331_IMAGE	:= $(IMAGEDIR)/ar9331.hdimg
IMAGE_AR9331_CONFIG	:= ar9331.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_AR9331_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_AR9331)
	@$(call finish)

# vim: syntax=make
