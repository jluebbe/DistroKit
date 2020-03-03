# -*-makefile-*-
#
# Copyright (C) 2016 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_RPI2) += blspec-rpi2

BLSPEC_RPI2_VERSION	:= 4.6

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-rpi2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-rpi2)
	@$(call install_fixup,blspec-rpi2,PRIORITY,optional)
	@$(call install_fixup,blspec-rpi2,SECTION,base)
	@$(call install_fixup,blspec-rpi2,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup,blspec-rpi2,DESCRIPTION,missing)

	@$(call install_alternative, blspec-rpi2, 0, 0, 0644, \
		/loader/entries/rpi2.conf)

	@$(call install_finish,blspec-rpi2)

	@$(call touch)

# vim: syntax=make
