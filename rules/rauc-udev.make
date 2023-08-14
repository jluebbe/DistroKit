# -*-makefile-*-
#
# Copyright (C) 2021 by Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RAUC_UDEV) += rauc-udev

RAUC_UDEV_VERSION	:= 1
RAUC_UDEV_LICENSE	:= 0-BSD

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rauc-udev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rauc-udev)
	@$(call install_fixup,rauc-udev,PRIORITY,optional)
	@$(call install_fixup,rauc-udev,SECTION,base)
	@$(call install_fixup,rauc-udev,AUTHOR,"Roland Hieber, Pengutronix <rhi@pengutronix.de>")
	@$(call install_fixup,rauc-udev,DESCRIPTION,missing)

	@$(call install_alternative, rauc-udev, 0, 0, 0755, /usr/lib/udev/of_base_compatible)
	@$(call install_alternative, rauc-udev, 0, 0, 0644, /usr/lib/udev/rules.d/90-rauc-partitions.rules)

	@$(call install_finish,rauc-udev)

	@$(call touch)

# vim: syntax=make
