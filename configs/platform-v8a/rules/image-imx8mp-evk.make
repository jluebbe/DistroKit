# -*-makefile-*-
#
# Copyright (C) 2020 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_IMX8MP_EVK) += image-imx8mp-evk

#
# Paths and names
#
IMAGE_IMX8MP_EVK		:= image-imx8mp-evk
IMAGE_IMX8MP_EVK_DIR	:= $(BUILDDIR)/$(IMAGE_IMX8MP_EVK)
IMAGE_IMX8MP_EVK_IMAGE	:= $(IMAGEDIR)/imx8mp-evk.img
IMAGE_IMX8MP_EVK_FILES	:= $(IMAGEDIR)/root.tgz
IMAGE_IMX8MP_EVK_CONFIG	:= imx8m.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

IMAGE_IMX8MP_EVK_ENV := \
        BAREBOX_IMAGE=barebox-nxp-imx8mp-evk.img

$(IMAGE_IMX8MP_EVK_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_IMX8MP_EVK)
	@$(call finish)

# vim: syntax=make
