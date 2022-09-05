# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Riesch <michael.riesch@wolfvision.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROCK3A) += image-rock3a

#
# Paths and names
#
IMAGE_ROCK3A		:= image-rock3a
IMAGE_ROCK3A_DIR	:= $(BUILDDIR)/$(IMAGE_ROCK3A)
IMAGE_ROCK3A_IMAGE	:= $(IMAGEDIR)/rock3a.img
IMAGE_ROCK3A_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_ROCK3A_CONFIG	:= rock3a.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_ROCK3A_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ROCK3A)
	@$(call finish)

# vim: syntax=make
