# -*-makefile-*-
#
# Copyright (C) 2017 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_RIOTBOARD) += blspec-riotboard

BLSPEC_RIOTBOARD_VERSION	:= 4.11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-riotboard.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-riotboard)
	@$(call install_fixup,blspec-riotboard,PRIORITY,optional)
	@$(call install_fixup,blspec-riotboard,SECTION,base)
	@$(call install_fixup,blspec-riotboard,AUTHOR,"Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup,blspec-riotboard,DESCRIPTION,missing)

	@$(call install_alternative, blspec-riotboard, 0, 0, 0644, \
		/loader/entries/riotboard.conf)

	@$(call install_finish,blspec-riotboard)

	@$(call touch)

# vim: syntax=make
