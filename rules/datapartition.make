# -*-makefile-*-
#
# Copyright (C) 2016 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DATAPARTITION) += datapartition

DATAPARTITION_VERSION	:= 1

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

	@$(call install_alternative, datapartition, 0, 0, 0644, \
		/usr/lib/systemd/system/systemd-autoformat@.service)
	@$(call install_alternative, datapartition, 0, 0, 0644, \
		/usr/lib/udev/rules.d/91-mkfs-ext4.rules)

	@$(call install_finish,datapartition)

	@$(call touch)

# vim: syntax=make
