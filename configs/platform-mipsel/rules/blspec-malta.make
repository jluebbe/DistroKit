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
PACKAGES-$(PTXCONF_BLSPEC_MALTA) += blspec-malta

BLSPEC_MALTA_VERSION	:= 4.11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-malta.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-malta)
	@$(call install_fixup,blspec-malta,PRIORITY,optional)
	@$(call install_fixup,blspec-malta,SECTION,base)
	@$(call install_fixup,blspec-malta,AUTHOR,"Oleksij Rempel <o.rempel@pengutronix.de>")
	@$(call install_fixup,blspec-malta,DESCRIPTION,missing)

	@$(call install_alternative, blspec-malta, 0, 0, 0644, \
		/loader/entries/malta.conf)

	@$(call install_finish,blspec-malta)

	@$(call touch)

# vim: syntax=make
