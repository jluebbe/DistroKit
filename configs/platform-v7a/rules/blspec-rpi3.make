# -*-makefile-*-
#
# Copyright (C) 2018 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_RPI3) += blspec-rpi3

BLSPEC_RPI3_VERSION	:= 4.6

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-rpi3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-rpi3)
	@$(call install_fixup,blspec-rpi3,PRIORITY,optional)
	@$(call install_fixup,blspec-rpi3,SECTION,base)
	@$(call install_fixup,blspec-rpi3,AUTHOR,"Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup,blspec-rpi3,DESCRIPTION,missing)

	@$(call install_alternative, blspec-rpi3, 0, 0, 0644, \
		/loader/entries/rpi3.conf)

	@$(call install_finish,blspec-rpi3)

	@$(call touch)

# vim: syntax=make
