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
PACKAGES-$(PTXCONF_BLSPEC_SAMA5D27_GIANTBOARD) += blspec-sama5d27-giantboard

BLSPEC_SAMA5D27_GIANTBOARD_VERSION	:= 5.8

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-sama5d27-giantboard.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-sama5d27-giantboard)
	@$(call install_fixup,blspec-sama5d27-giantboard,PRIORITY,optional)
	@$(call install_fixup,blspec-sama5d27-giantboard,SECTION,base)
	@$(call install_fixup,blspec-sama5d27-giantboard,AUTHOR,"Ahmad Fatoum <afa@pengutronix.de>")
	@$(call install_fixup,blspec-sama5d27-giantboard,DESCRIPTION,missing)

	@$(call install_alternative, blspec-sama5d27-giantboard, 0, 0, 0644, \
		/loader/entries/sama5d27-giantboard.conf)

	@$(call install_finish,blspec-sama5d27-giantboard)

	@$(call touch)

# vim: syntax=make
