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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_UDOO_NEO) += image-udoo-neo

#
# Paths and names
#
IMAGE_UDOO_NEO		:= image-udoo-neo
IMAGE_UDOO_NEO_DIR	:= $(BUILDDIR)/$(IMAGE_UDOO_NEO)
IMAGE_UDOO_NEO_IMAGE	:= $(IMAGEDIR)/udoo-neo.hdimg
IMAGE_UDOO_NEO_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_UDOO_NEO_CONFIG	:= udoo-neo.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_UDOO_NEO_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_UDOO_NEO)
	@$(call finish)

# vim: syntax=make
