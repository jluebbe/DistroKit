# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_NITROGEN6X) += blspec-nitrogen6x

BLSPEC_NITROGEN6X_VERSION	:= 4.12

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-nitrogen6x.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-nitrogen6x)
	@$(call install_fixup,blspec-nitrogen6x,PRIORITY,optional)
	@$(call install_fixup,blspec-nitrogen6x,SECTION,base)
	@$(call install_fixup,blspec-nitrogen6x,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup,blspec-nitrogen6x,DESCRIPTION,missing)

	@$(call install_alternative, blspec-nitrogen6x, 0, 0, 0644, \
		/loader/entries/nitrogen6x.conf)

	@$(call install_finish,blspec-nitrogen6x)

	@$(call touch)

# vim: syntax=make
