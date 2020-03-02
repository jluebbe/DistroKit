# -*-makefile-*-
#
# Copyright (C) 2017 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLSPEC_STM32MP157C_DK2) += blspec-stm32mp157c-dk2

BLSPEC_STM32MP157C_DK2_VERSION	:= 4.11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-stm32mp157c-dk2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-stm32mp157c-dk2)
	@$(call install_fixup,blspec-stm32mp157c-dk2,PRIORITY,optional)
	@$(call install_fixup,blspec-stm32mp157c-dk2,SECTION,base)
	@$(call install_fixup,blspec-stm32mp157c-dk2,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup,blspec-stm32mp157c-dk2,DESCRIPTION,missing)

	@$(call install_alternative, blspec-stm32mp157c-dk2, 0, 0, 0644, \
		/loader/entries/stm32mp157c-dk2.conf)

	@$(call install_finish,blspec-stm32mp157c-dk2)

	@$(call touch)

# vim: syntax=make
