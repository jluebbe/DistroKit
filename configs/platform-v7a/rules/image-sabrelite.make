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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_SABRELITE) += image-sabrelite

#
# Paths and names
#
IMAGE_SABRELITE		:= image-sabrelite
IMAGE_SABRELITE_DIR	:= $(BUILDDIR)/$(IMAGE_SABRELITE)
IMAGE_SABRELITE_IMAGE	:= $(IMAGEDIR)/sabrelite.hdimg
IMAGE_SABRELITE_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_SABRELITE_CONFIG	:= sabrelite.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_SABRELITE_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_SABRELITE)
	@$(call finish)

# vim: syntax=make
