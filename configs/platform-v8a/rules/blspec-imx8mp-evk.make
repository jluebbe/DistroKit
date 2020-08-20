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
PACKAGES-$(PTXCONF_BLSPEC_IMX8MP_EVK) += blspec-imx8mp-evk

BLSPEC_IMX8MP_EVK_VERSION	:= 5.6.2

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-imx8mp-evk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-imx8mp-evk)
	@$(call install_fixup,blspec-imx8mp-evk,PRIORITY,optional)
	@$(call install_fixup,blspec-imx8mp-evk,SECTION,base)
	@$(call install_fixup,blspec-imx8mp-evk,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup,blspec-imx8mp-evk,DESCRIPTION,missing)

	@$(call install_alternative, blspec-imx8mp-evk, 0, 0, 0644, \
		/loader/entries/imx8mp-evk.conf)
	@$(call install_replace, blspec-imx8mp-evk, /loader/entries/imx8mp-evk.conf, \
                        @VERSION@,'$(PTXDIST_BSP_AUTOVERSION)')$(ptx/nl)

	@$(call install_finish,blspec-imx8mp-evk)

	@$(call touch)

# vim: syntax=make
