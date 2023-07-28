# -*-makefile-*-
#
# Copyright (C) 2023 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_IMX8MN_EVK) += image-imx8mn-evk

#
# Paths and names
#
IMAGE_IMX8MN_EVK		:= image-imx8mn-evk
IMAGE_IMX8MN_EVK_DIR	:= $(BUILDDIR)/$(IMAGE_IMX8MN_EVK)
IMAGE_IMX8MN_EVK_IMAGE	:= $(IMAGEDIR)/imx8mn-evk.img
IMAGE_IMX8MN_EVK_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_IMX8MN_EVK_CONFIG	:= imx8m.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_IMX8MN_EVK_ENV := \
        BAREBOX_IMAGE=barebox-nxp-imx8mn-evk.img

$(IMAGE_IMX8MN_EVK_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_IMX8MN_EVK)
	@$(call finish)

# vim: syntax=make
