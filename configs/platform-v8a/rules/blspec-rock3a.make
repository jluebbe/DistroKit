# -*-makefile-*-
#
# Copyright (C) 2020 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_ROCK3A) += blspec-rock3a

BLSPEC_ROCK3A_VERSION	:= 5.6.2

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-rock3a.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-rock3a)
	@$(call install_fixup,blspec-rock3a,PRIORITY,optional)
	@$(call install_fixup,blspec-rock3a,SECTION,base)
	@$(call install_fixup,blspec-rock3a,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup,blspec-rock3a,DESCRIPTION,missing)

	@$(call install_alternative, blspec-rock3a, 0, 0, 0644, \
		/loader/entries/rock3a.conf)
	@$(call install_replace, blspec-rock3a, /loader/entries/rock3a.conf, \
		@VERSION@,'$(PTXDIST_BSP_AUTOVERSION)')$(ptx/nl)

	@$(call install_finish,blspec-rock3a)

	@$(call touch)

# vim: syntax=make
