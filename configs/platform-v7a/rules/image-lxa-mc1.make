# -*-makefile-*-
#
# Copyright (C) 2020 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_LXA_MC1) += image-lxa-mc1

IMAGE_LXA_MC1_ENV := \
	STM32MP_BOARD=stm32mp157c-lxa-mc1

#
# Paths and names
#
IMAGE_LXA_MC1		:= image-lxa-mc1
IMAGE_LXA_MC1_DIR	:= $(BUILDDIR)/$(IMAGE_LXA_MC1)
IMAGE_LXA_MC1_IMAGE	:= $(IMAGEDIR)/lxa-mc1.hdimg
IMAGE_LXA_MC1_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_LXA_MC1_CONFIG	:= stm32mp.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_LXA_MC1_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_LXA_MC1)
	@$(call finish)

# vim: syntax=make
