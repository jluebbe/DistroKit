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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_BEAGLEBONE) += image-beaglebone

#
# Paths and names
#
IMAGE_BEAGLEBONE		:= image-beaglebone
IMAGE_BEAGLEBONE_DIR	:= $(BUILDDIR)/$(IMAGE_BEAGLEBONE)
IMAGE_BEAGLEBONE_IMAGE	:= $(IMAGEDIR)/beaglebone.hdimg
IMAGE_BEAGLEBONE_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_BEAGLEBONE_CONFIG	:= beaglebone.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_BEAGLEBONE_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_BEAGLEBONE)
	@$(call finish)

# vim: syntax=make
