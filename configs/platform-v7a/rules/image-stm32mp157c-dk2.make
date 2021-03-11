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
IMAGE_PACKAGES-$(PTXCONF_IMAGE_STM32MP157C_DK2) += image-stm32mp157c-dk2

IMAGE_STM32MP157C_DK2_ENV := \
	STM32MP_BOARD_FSBL=stm32mp157c-dk2 \
	STM32MP_BOARD_SSBL=stm32mp157c-dk2

#
# Paths and names
#
IMAGE_STM32MP157C_DK2		:= image-stm32mp157c-dk2
IMAGE_STM32MP157C_DK2_DIR	:= $(BUILDDIR)/$(IMAGE_STM32MP157C_DK2)
IMAGE_STM32MP157C_DK2_IMAGE	:= $(IMAGEDIR)/stm32mp157c-dk2.hdimg
IMAGE_STM32MP157C_DK2_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_STM32MP157C_DK2_CONFIG	:= stm32mp.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_STM32MP157C_DK2_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_STM32MP157C_DK2)
	@$(call finish)

# vim: syntax=make

