# -*-makefile-*-
#
# Copyright (C) 2019 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_NITROGEN6MAX) += blspec-nitrogen6max

BLSPEC_NITROGEN6MAX_VERSION	:= 5.3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-nitrogen6max.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-nitrogen6max)
	@$(call install_fixup,blspec-nitrogen6max,PRIORITY,optional)
	@$(call install_fixup,blspec-nitrogen6max,SECTION,base)
	@$(call install_fixup,blspec-nitrogen6max,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,blspec-nitrogen6max,DESCRIPTION,missing)

	@$(call install_alternative, blspec-nitrogen6max, 0, 0, 0644, \
		/loader/entries/nitrogen6max.conf)

	@$(call install_finish,blspec-nitrogen6max)

	@$(call touch)

# vim: syntax=make
