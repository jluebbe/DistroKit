# -*-makefile-*-
#
# Copyright (C) 2017 by Chris Fiege <c.fiege@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_VEXPRESS) += blspec-vexpress

BLSPEC_VEXPRESS_VERSION	:= 4.11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-vexpress.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-vexpress)
	@$(call install_fixup,blspec-vexpress,PRIORITY,optional)
	@$(call install_fixup,blspec-vexpress,SECTION,base)
	@$(call install_fixup,blspec-vexpress,AUTHOR,"Chris Fiege <c.fiege@pengutronix.de>")
	@$(call install_fixup,blspec-vexpress,DESCRIPTION,missing)

	@$(call install_alternative, blspec-vexpress, 0, 0, 0644, \
		/loader/entries/vexpress.conf)

	@$(call install_finish,blspec-vexpress)

	@$(call touch)

# vim: syntax=make
