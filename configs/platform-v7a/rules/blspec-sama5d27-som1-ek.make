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
PACKAGES-$(PTXCONF_BLSPEC_SAMA5D27_SOM1_EK) += blspec-sama5d27-som1-ek

BLSPEC_SAMA5D27_SOM1_EK_VERSION	:= 5.8

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-sama5d27-som1-ek.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-sama5d27-som1-ek)
	@$(call install_fixup,blspec-sama5d27-som1-ek,PRIORITY,optional)
	@$(call install_fixup,blspec-sama5d27-som1-ek,SECTION,base)
	@$(call install_fixup,blspec-sama5d27-som1-ek,AUTHOR,"Ahmad Fatoum <afa@pengutronix.de>")
	@$(call install_fixup,blspec-sama5d27-som1-ek,DESCRIPTION,missing)

	@$(call install_alternative, blspec-sama5d27-som1-ek, 0, 0, 0644, \
		/loader/entries/sama5d27-som1-ek.conf)

	@$(call install_finish,blspec-sama5d27-som1-ek)

	@$(call touch)

# vim: syntax=make
