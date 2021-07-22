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
PACKAGES-$(PTXCONF_BLSPEC_STM32MP157C_EV1) += blspec-stm32mp157c-ev1

BLSPEC_STM32MP157C_EV1_VERSION	:= 5.13

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blspec-stm32mp157c-ev1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blspec-stm32mp157c-ev1)
	@$(call install_fixup,blspec-stm32mp157c-ev1,PRIORITY,optional)
	@$(call install_fixup,blspec-stm32mp157c-ev1,SECTION,base)
	@$(call install_fixup,blspec-stm32mp157c-ev1,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup,blspec-stm32mp157c-ev1,DESCRIPTION,missing)

	@$(call install_alternative, blspec-stm32mp157c-ev1, 0, 0, 0644, \
		/loader/entries/stm32mp157c-ev1.conf)

	@$(call install_finish,blspec-stm32mp157c-ev1)

	@$(call touch)

# vim: syntax=make
