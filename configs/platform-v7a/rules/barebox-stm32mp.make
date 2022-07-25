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
BAREBOX_STM32MP_VERSION		:= $(call ptx/config-version, PTXCONF_BAREBOX_COMMON)
BAREBOX_STM32MP_MD5		:= $(call ptx/config-md5, PTXCONF_BAREBOX_COMMON)
BAREBOX_STM32MP			:= barebox-stm32mp-$(BAREBOX_STM32MP_VERSION)
BAREBOX_STM32MP_SUFFIX		:= tar.bz2
BAREBOX_STM32MP_URL		:= $(call barebox-url, BAREBOX_STM32MP)
BAREBOX_STM32MP_PATCHES		:= barebox-$(BAREBOX_STM32MP_VERSION)
BAREBOX_STM32MP_SOURCE		:= $(SRCDIR)/$(BAREBOX_STM32MP).$(BAREBOX_STM32MP_SUFFIX)
BAREBOX_STM32MP_DIR		:= $(BUILDDIR)/$(BAREBOX_STM32MP)
BAREBOX_STM32MP_BUILD_DIR	:= $(BAREBOX_STM32MP_DIR)-build
BAREBOX_STM32MP_CONFIG		:= $(call ptx/in-platformconfigdir, barebox-stm32mp.config)
BAREBOX_STM32MP_REF_CONFIG	:= $(call ptx/in-platformconfigdir, barebox.config)
BAREBOX_STM32MP_LICENSE		:= GPL-2.0
BAREBOX_STM32MP_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_STM32MP_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_STM32MP_CONF_ENV := KCONFIG_NOTIMESTAMP=1
BAREBOX_STM32MP_CONF_OPT := \
	-C $(BAREBOX_STM32MP_DIR) \
	O=$(BAREBOX_STM32MP_BUILD_DIR) \
	BUILDSYSTEM_VERSION=$(PTXDIST_VCS_VERSION) \
	$(call barebox-opts, BAREBOX_STM32MP)

BAREBOX_STM32MP_MAKE_OPT := $(BAREBOX_STM32MP_CONF_OPT)

BAREBOX_STM32MP_IMAGES := \
	images/barebox-stm32mp-generic-bl33.img

BAREBOX_STM32MP_FIP_DTBS := \
	stm32mp157c-dk2.dtb \
	stm32mp157c-ev1.dtb \
	stm32mp157c-lxa-mc1.dtb

BAREBOX_STM32MP_IMAGES := $(addprefix $(BAREBOX_STM32MP_BUILD_DIR)/,$(BAREBOX_STM32MP_IMAGES))
BAREBOX_STM32MP_FIP_DTBS := \
	$(addprefix $(BAREBOX_STM32MP_BUILD_DIR)/arch/arm/dts/,$(BAREBOX_STM32MP_FIP_DTBS))

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
	@$(call world/prepare, BAREBOX_STM32MP)
	@rm -f "$(BAREBOX_STM32MP_BUILD_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-stm32mp-defaultenv)" \
		"$(BAREBOX_STM32MP_BUILD_DIR)/.ptxdist-defaultenv"
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
	@$(foreach dtb, $(BAREBOX_STM32MP_FIP_DTBS), \
			install -m 644 \
			$(dtb) $(IMAGEDIR)/barebox-$(notdir $(dtb));)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-stm32mp.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_STM32MP)
	@$(foreach image, $(BAREBOX_STM32MP_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@$(foreach dtb, $(BAREBOX_STM32MP_FIP_DTBS), \
		rm -fv $(IMAGEDIR)/barebox-$(notdir $(dtb))$(ptx/nl))

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-stm32mp_oldconfig barebox-stm32mp_menuconfig barebox-stm32mp_nconfig: $(STATEDIR)/barebox-stm32mp.extract
	@$(call world/kconfig, BAREBOX_STM32MP, $(subst barebox-stm32mp_,,$@))

# vim: syntax=make
