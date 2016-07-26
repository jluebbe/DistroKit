# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_BONEWHITE) += blspec-bonewhite

BLSPEC_BONEWHITE_VERSION	:= 4.6

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-bonewhite.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-bonewhite)
	@$(call install_fixup,blspec-bonewhite,PRIORITY,optional)
	@$(call install_fixup,blspec-bonewhite,SECTION,base)
	@$(call install_fixup,blspec-bonewhite,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup,blspec-bonewhite,DESCRIPTION,missing)

	@$(call install_alternative, blspec-bonewhite, 0, 0, 0644, \
		/loader/entries/bonewhite.conf)

	@$(call install_finish,blspec-bonewhite)

	@$(call touch)

# vim: syntax=make
