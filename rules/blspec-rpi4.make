# -*-makefile-*-
#
# Copyright (C) 2022 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_RPI4) += blspec-rpi4

BLSPEC_RPI4_VERSION	:= 4.6

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-rpi4.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-rpi4)
	@$(call install_fixup,blspec-rpi4,PRIORITY,optional)
	@$(call install_fixup,blspec-rpi4,SECTION,base)
	@$(call install_fixup,blspec-rpi4,AUTHOR,"Ahmad Fatoum <a.fatoum@pengutronix.de>")
	@$(call install_fixup,blspec-rpi4,DESCRIPTION,missing)

	@$(call install_alternative, blspec-rpi4, 0, 0, 0644, \
		/loader/entries/rpi4b.conf)
	@$(call install_alternative, blspec-rpi4, 0, 0, 0644, \
		/loader/entries/rpi400.conf)

	@$(call install_finish,blspec-rpi4)

	@$(call touch)

# vim: syntax=make
