# -*-makefile-*-
#
# Copyright (C) 2017 by Sascha Hauer <s.hauer@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_SABRELITE) += blspec-sabrelite

BLSPEC_SABRELITE_VERSION	:= 4.11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-sabrelite.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-sabrelite)
	@$(call install_fixup,blspec-sabrelite,PRIORITY,optional)
	@$(call install_fixup,blspec-sabrelite,SECTION,base)
	@$(call install_fixup,blspec-sabrelite,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup,blspec-sabrelite,DESCRIPTION,missing)

	@$(call install_alternative, blspec-sabrelite, 0, 0, 0644, \
		/loader/entries/sabrelite.conf)

	@$(call install_finish,blspec-sabrelite)

	@$(call touch)

# vim: syntax=make
