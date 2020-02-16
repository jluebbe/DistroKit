# -*-makefile-*-
#
# Copyright (C) 2017 by Robert Schwebel <r.schwebel@pengutronix.de>
# Copyright (C) 2020 by Oleksij Rempel <o.rempel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_AR9331) += barebox-ar9331

#
# Paths and names
#
BAREBOX_AR9331_VERSION	:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_VERSION))
BAREBOX_AR9331_MD5		:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_MD5))
BAREBOX_AR9331		:= barebox-ar9331-$(BAREBOX_AR9331_VERSION)
BAREBOX_AR9331_SUFFIX		:= tar.bz2
BAREBOX_AR9331_URL		:= $(call barebox-url, BAREBOX_AR9331)
BAREBOX_AR9331_PATCHES	:= barebox-$(BAREBOX_AR9331_VERSION)
BAREBOX_AR9331_SOURCE		:= $(SRCDIR)/$(BAREBOX_AR9331_PATCHES).$(BAREBOX_AR9331_SUFFIX)
BAREBOX_AR9331_DIR		:= $(BUILDDIR)/$(BAREBOX_AR9331)
BAREBOX_AR9331_BUILD_DIR	:= $(BAREBOX_AR9331_DIR)-build
BAREBOX_AR9331_CONFIG		:= $(call ptx/in-platformconfigdir, barebox-ar9331.config)
BAREBOX_AR9331_REF_CONFIG	:= $(call ptx/in-platformconfigdir, barebox.config)
BAREBOX_AR9331_LICENSE	:= GPL-2.0-only
BAREBOX_AR9331_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_AR9331_PATH := PATH=$(HOST_PATH)

BAREBOX_AR9331_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_AR9331_CONF_OPT := \
	-C $(BAREBOX_AR9331_DIR) \
	O=$(BAREBOX_AR9331_BUILD_DIR) \
	$(call barebox-opts, BAREBOX_AR9331)

BAREBOX_AR9331_MAKE_OPT := $(BAREBOX_AR9331_CONF_OPT)

BAREBOX_AR9331_IMAGES := images/barebox-dptechnics-dpt-module.img
BAREBOX_AR9331_IMAGES := $(addprefix $(BAREBOX_AR9331_BUILD_DIR)/,$(BAREBOX_AR9331_IMAGES))

ifdef PTXCONF_BAREBOX_AR9331
$(BAREBOX_AR9331_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-ar9331'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-ar9331.prepare: $(BAREBOX_AR9331_CONFIG)
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX_AR9331)
	@rm -f "$(BAREBOX_AR9331_BUILD_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-ar9331-defaultenv)" \
		"$(BAREBOX_AR9331_BUILD_DIR)/.ptxdist-defaultenv"
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-ar9331.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-ar9331.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_AR9331_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@install -D -m644 $(BAREBOX_AR9331_BUILD_DIR)/defaultenv/barebox_zero_env $(IMAGEDIR)/barebox-zero-env-ar9331
	@install -D -m644 $(BAREBOX_AR9331_BUILD_DIR)/arch/mips/dts/ar9331-dptechnics-dpt-module.dtb $(IMAGEDIR)/ar9331-dptechnics-dpt-module.dtb-bb
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-ar9331.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_AR9331)
	@$(foreach image, $(BAREBOX_AR9331_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@rm -vf $(IMAGEDIR)/barebox-zero-env-ar9331 \
		$(IMAGEDIR)/ar9331-dptechnics-dpt-module.dtb-bb

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-ar9331_oldconfig barebox-ar9331_menuconfig barebox-ar9331_nconfig: $(STATEDIR)/barebox-ar9331.extract
	@$(call world/kconfig, BAREBOX_AR9331, $(subst barebox-ar9331_,,$@))

# vim: syntax=make
