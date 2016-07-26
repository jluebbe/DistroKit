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
PACKAGES-$(PTXCONF_BLSPEC_BONEBLACK) += blspec-boneblack

BLSPEC_BONEBLACK_VERSION	:= 4.6

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-boneblack.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-boneblack)
	@$(call install_fixup,blspec-boneblack,PRIORITY,optional)
	@$(call install_fixup,blspec-boneblack,SECTION,base)
	@$(call install_fixup,blspec-boneblack,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup,blspec-boneblack,DESCRIPTION,missing)

	@$(call install_alternative, blspec-boneblack, 0, 0, 0644, \
		/loader/entries/boneblack.conf)

	@$(call install_finish,blspec-boneblack)

	@$(call touch)

# vim: syntax=make
