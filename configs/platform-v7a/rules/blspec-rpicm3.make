# -*-makefile-*-
#
# Copyright (C) 2021 by Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_RPICM3) += blspec-rpicm3

BLSPEC_RPICM3_VERSION	:= 4.6

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-rpicm3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-rpicm3)
	@$(call install_fixup,blspec-rpicm3,PRIORITY,optional)
	@$(call install_fixup,blspec-rpicm3,SECTION,base)
	@$(call install_fixup,blspec-rpicm3,AUTHOR,"Uwe Kleine-König <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup,blspec-rpicm3,DESCRIPTION,missing)

	@$(call install_alternative, blspec-rpicm3, 0, 0, 0644, \
		/loader/entries/rpicm3.conf)

	@$(call install_finish,blspec-rpicm3)

	@$(call touch)

# vim: syntax=make
