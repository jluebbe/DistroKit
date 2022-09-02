# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_VEXPRESS_NOR) += image-vexpress-nor

#
# Paths and names
#
IMAGE_VEXPRESS_NOR		:= image-vexpress-nor
IMAGE_VEXPRESS_NOR_DIR		:= $(BUILDDIR)/$(IMAGE_VEXPRESS_NOR)
IMAGE_VEXPRESS_NOR_IMAGE	:= $(IMAGEDIR)/vexpress.norimg
IMAGE_VEXPRESS_NOR_CONFIG	:= vexpress-nor.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

# Note: no ':' and only works with one device tree
IMAGE_VEXPRESS_NOR_ENV = \
	DTB=$(IMAGEDIR)/vexpress-v2p-ca9.dtb

$(IMAGE_VEXPRESS_NOR_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_VEXPRESS_NOR)
	@$(call finish)

# vim: syntax=make
