# -*-makefile-*-
#
# Copyright (C) 2020 by Holger Assmann <h.assmann@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_KSZ9477_EVB) += blspec-ksz9477-evb

BLSPEC_KSZ9477_EVB_VERSION	:= 5.8

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-ksz9477-evb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-ksz9477-evb)
	@$(call install_fixup,blspec-ksz9477-evb,PRIORITY,optional)
	@$(call install_fixup,blspec-ksz9477-evb,SECTION,base)
	@$(call install_fixup,blspec-ksz9477-evb,AUTHOR,"Holger Assmann <h.assmann@pengutronix.de>")
	@$(call install_fixup,blspec-ksz9477-evb,DESCRIPTION,missing)

	@$(call install_alternative, blspec-ksz9477-evb, 0, 0, 0644, \
		/loader/entries/sama5d3-ksz9477-evb.conf)

	@$(call install_finish,blspec-ksz9477-evb)

	@$(call touch)

# vim: syntax=make
