# -*-makefile-*-
#
# Copyright (C) 2017 by Chris Fiege <c.fiege@pengutronix.de>
# Copyright (C) 2020 by Oleksij Rempel <o.rempel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_AR9331) += blspec-ar9331

BLSPEC_AR9331_VERSION	:= 4.11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-ar9331.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-ar9331)
	@$(call install_fixup,blspec-ar9331,PRIORITY,optional)
	@$(call install_fixup,blspec-ar9331,SECTION,base)
	@$(call install_fixup,blspec-ar9331,AUTHOR,"Oleksij Rempel <o.rempel@pengutronix.de>")
	@$(call install_fixup,blspec-ar9331,DESCRIPTION,missing)

	@$(call install_alternative, blspec-ar9331, 0, 0, 0644, \
		/loader/entries/ar9331.conf)

	@$(call install_finish,blspec-ar9331)

	@$(call touch)

# vim: syntax=make
