# -*-makefile-*-
#
# Copyright (C) 2017 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_UDOO_NEO) += blspec-udoo-neo

BLSPEC_UDOO_NEO_VERSION	:= 4.11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-udoo-neo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-udoo-neo)
	@$(call install_fixup,blspec-udoo-neo,PRIORITY,optional)
	@$(call install_fixup,blspec-udoo-neo,SECTION,base)
	@$(call install_fixup,blspec-udoo-neo,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup,blspec-udoo-neo,DESCRIPTION,missing)

	@$(call install_alternative, blspec-udoo-neo, 0, 0, 0644, \
		/loader/entries/udoo-neo.conf)

	@$(call install_finish,blspec-udoo-neo)

	@$(call touch)

# vim: syntax=make
