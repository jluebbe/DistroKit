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
PACKAGES-$(PTXCONF_BLSPEC_IMX8MQ_EVK) += blspec-imx8mq-evk

BLSPEC_IMX8MQ_EVK_VERSION	:= 5.6.2

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-imx8mq-evk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-imx8mq-evk)
	@$(call install_fixup,blspec-imx8mq-evk,PRIORITY,optional)
	@$(call install_fixup,blspec-imx8mq-evk,SECTION,base)
	@$(call install_fixup,blspec-imx8mq-evk,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup,blspec-imx8mq-evk,DESCRIPTION,missing)

	@$(call install_alternative, blspec-imx8mq-evk, 0, 0, 0644, \
		/loader/entries/imx8mq-evk.conf)
	@$(call install_replace, blspec-imx8mq-evk, /loader/entries/imx8mq-evk.conf, \
		@VERSION@,'$(PTXDIST_BSP_AUTOVERSION)')$(ptx/nl)

	@$(call install_finish,blspec-imx8mq-evk)

	@$(call touch)

# vim: syntax=make
