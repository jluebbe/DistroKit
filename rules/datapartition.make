# -*-makefile-*-
#
# Copyright (C) 2016 by Robert Schwebel <r.schwebel@pengutronix.de>
# Copyright (C) 2023 Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DATAPARTITION) += datapartition

DATAPARTITION_VERSION	:= 1
DATAPARTITION_LICENSE	:= ignore

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/datapartition.targetinstall:
	@$(call targetinfo)

	@$(call install_init, datapartition)
	@$(call install_fixup,datapartition,PRIORITY,optional)
	@$(call install_fixup,datapartition,SECTION,base)
	@$(call install_fixup,datapartition,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,datapartition,DESCRIPTION,missing)

	@$(call install_copy, datapartition, 0, 0, 0755, /mnt/data)
	@$(call install_alternative, datapartition, 0, 0, 0644, \
		/usr/lib/systemd/system/mnt-data.mount)

	@# Note: we only want to call systemd-repart in rc-once, so don't
	@# install the configs to any path picked up by systemd-repart.service
	@$(call install_alternative_tree, datapartition, 0, 0, \
		/etc/repart.rc-once.d/)
	@$(call install_alternative, datapartition, 0, 0, 0755, \
		/etc/rc.once.d/repart)

	@$(call install_finish,datapartition)

	@$(call touch)

# vim: syntax=make
