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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_STM32MP157C_EV1) += image-stm32mp157c-ev1

IMAGE_STM32MP157C_EV1_ENV := STM32MP_BOARD=stm32mp157c-ev1

#
# Paths and names
#
IMAGE_STM32MP157C_EV1		:= image-stm32mp157c-ev1
IMAGE_STM32MP157C_EV1_DIR	:= $(BUILDDIR)/$(IMAGE_STM32MP157C_EV1)
IMAGE_STM32MP157C_EV1_IMAGE	:= $(IMAGEDIR)/stm32mp157c-ev1.hdimg
IMAGE_STM32MP157C_EV1_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_STM32MP157C_EV1_CONFIG	:= stm32mp.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_STM32MP157C_EV1_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_STM32MP157C_EV1)
	@$(call finish)

# vim: syntax=make
