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
PACKAGES-$(PTXCONF_BAREBOX_STM32MP) += barebox-stm32mp

#
# Paths and names
#
BAREBOX_STM32MP_VERSION		:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_VERSION))
BAREBOX_STM32MP_MD5		:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_MD5))
BAREBOX_STM32MP			:= barebox-$(BAREBOX_STM32MP_VERSION)
BAREBOX_STM32MP_SUFFIX		:= tar.bz2
BAREBOX_STM32MP_DIR		:= $(BUILDDIR)/barebox-stm32mp-$(BAREBOX_STM32MP_VERSION)
BAREBOX_STM32MP_CONFIG		:= $(call ptx/in-platformconfigdir, barebox-stm32mp.config)
BAREBOX_STM32MP_REF_CONFIG	:= $(call ptx/in-platformconfigdir, barebox.config)
BAREBOX_STM32MP_LICENSE		:= GPL-2.0
BAREBOX_STM32MP_URL		:= $(call barebox-url, BAREBOX_STM32MP)
BAREBOX_STM32MP_SOURCE		:= $(SRCDIR)/$(BAREBOX_STM32MP).$(BAREBOX_STM32MP_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_STM32MP_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

BAREBOX_STM32MP_CONF_ENV := KCONFIG_NOTIMESTAMP=1
BAREBOX_STM32MP_CONF_OPT := $(call barebox-opts, BAREBOX_STM32MP)

BAREBOX_STM32MP_MAKE_ENV := $(BAREBOX_STM32MP_CONF_ENV)
BAREBOX_STM32MP_MAKE_OPT := $(BAREBOX_STM32MP_CONF_OPT)

BAREBOX_STM32MP_IMAGES := \
	images/barebox-stm32mp157c-dk2.img \
	images/barebox-stm32mp157c-lxa-mc1.img

BAREBOX_STM32MP_IMAGES := $(addprefix $(BAREBOX_STM32MP_DIR)/,$(BAREBOX_STM32MP_IMAGES))

ifdef PTXCONF_BAREBOX_STM32MP
$(BAREBOX_STM32MP_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-stm32mp'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-stm32mp.prepare: $(BAREBOX_STM32MP_CONFIG)
	@$(call targetinfo)
	@rm -f "$(BAREBOX_STM32MP_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-stm32mp-defaultenv)" \
		"$(BAREBOX_STM32MP_DIR)/.ptxdist-defaultenv"
	@$(call world/prepare, BAREBOX_STM32MP)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-stm32mp.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Targetinstall
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-stm32mp.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_STM32MP_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image));)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-stm32mp.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_STM32MP)
	@$(foreach image, $(BAREBOX_STM32MP_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))-stm32mp;)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-stm32mp_oldconfig barebox-stm32mp_menuconfig barebox-stm32mp_nconfig: $(STATEDIR)/barebox-stm32mp.extract
	@$(call world/kconfig, BAREBOX_STM32MP, $(subst barebox-stm32mp_,,$@))

# vim: syntax=make
