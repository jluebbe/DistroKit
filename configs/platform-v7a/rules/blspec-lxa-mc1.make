# -*-makefile-*-
#
# Copyright (C) 2020 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_LXA_MC1) += blspec-lxa-mc1

BLSPEC_LXA_MC1_VERSION	:= 5.4

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-lxa-mc1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-lxa-mc1)
	@$(call install_fixup,blspec-lxa-mc1,PRIORITY,optional)
	@$(call install_fixup,blspec-lxa-mc1,SECTION,base)
	@$(call install_fixup,blspec-lxa-mc1,AUTHOR,"Ahmad Fatoum <a.fatoum@pengutronix.de>")
	@$(call install_fixup,blspec-lxa-mc1,DESCRIPTION,missing)

	@$(call install_alternative, blspec-lxa-mc1, 0, 0, 0644, \
		/loader/entries/lxa-mc1.conf)

	@$(call install_finish,blspec-lxa-mc1)

	@$(call touch)

# vim: syntax=make
