# -*-makefile-*-
#
# Copyright (C) 2017 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_VEXPRESS) += barebox-vexpress

#
# Paths and names
#
BAREBOX_VEXPRESS_VERSION	:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_VERSION))
BAREBOX_VEXPRESS_MD5		:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_MD5))
BAREBOX_VEXPRESS		:= barebox-vexpress-$(BAREBOX_VEXPRESS_VERSION)
BAREBOX_VEXPRESS_SUFFIX		:= tar.bz2
BAREBOX_VEXPRESS_URL		:= $(call barebox-url, BAREBOX_VEXPRESS)
BAREBOX_VEXPRESS_PATCHES	:= barebox-$(BAREBOX_VEXPRESS_VERSION)
BAREBOX_VEXPRESS_SOURCE		:= $(SRCDIR)/$(BAREBOX_VEXPRESS_PATCHES).$(BAREBOX_VEXPRESS_SUFFIX)
BAREBOX_VEXPRESS_DIR		:= $(BUILDDIR)/$(BAREBOX_VEXPRESS)
BAREBOX_VEXPRESS_BUILD_DIR	:= $(BAREBOX_VEXPRESS_DIR)-build
BAREBOX_VEXPRESS_CONFIG		:= $(call ptx/in-platformconfigdir, barebox-vexpress.config)
BAREBOX_VEXPRESS_REF_CONFIG	:= $(call ptx/in-platformconfigdir, barebox.config)
BAREBOX_VEXPRESS_LICENSE	:= GPL-2.0-only
BAREBOX_VEXPRESS_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_VEXPRESS_PATH := PATH=$(HOST_PATH)

BAREBOX_VEXPRESS_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_VEXPRESS_CONF_OPT := \
	-C $(BAREBOX_VEXPRESS_DIR) \
	O=$(BAREBOX_VEXPRESS_BUILD_DIR) \
	BUILDSYSTEM_VERSION=$(PTXDIST_VCS_VERSION) \
	$(call barebox-opts, BAREBOX_VEXPRESS)

BAREBOX_VEXPRESS_MAKE_OPT := $(BAREBOX_VEXPRESS_CONF_OPT)

BAREBOX_VEXPRESS_IMAGES := images/barebox-vexpress-ca9.img
BAREBOX_VEXPRESS_IMAGES := $(addprefix $(BAREBOX_VEXPRESS_BUILD_DIR)/,$(BAREBOX_VEXPRESS_IMAGES))

ifdef PTXCONF_BAREBOX_VEXPRESS
$(BAREBOX_VEXPRESS_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-vexpress'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-vexpress.prepare: $(BAREBOX_VEXPRESS_CONFIG)
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX_VEXPRESS)
	@rm -f "$(BAREBOX_VEXPRESS_BUILD_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-vexpress-defaultenv)" \
		"$(BAREBOX_VEXPRESS_BUILD_DIR)/.ptxdist-defaultenv"
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-vexpress.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-vexpress.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_VEXPRESS_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@install -D -m644 $(BAREBOX_VEXPRESS_BUILD_DIR)/defaultenv/barebox_zero_env $(IMAGEDIR)/barebox-zero-env-vexpress
	@install -D -m644 $(BAREBOX_VEXPRESS_BUILD_DIR)/arch/arm/dts/vexpress-v2p-ca9.dtb $(IMAGEDIR)/vexpress-v2p-ca9.dtb-bb
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-vexpress.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_VEXPRESS)
	@$(foreach image, $(BAREBOX_VEXPRESS_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@rm -vf $(IMAGEDIR)/barebox-zero-env-vexpress \
		$(IMAGEDIR)/vexpress-v2p-ca9.dtb-bb

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-vexpress_oldconfig barebox-vexpress_menuconfig barebox-vexpress_nconfig: $(STATEDIR)/barebox-vexpress.extract
	@$(call world/kconfig, BAREBOX_VEXPRESS, $(subst barebox-vexpress_,,$@))

# vim: syntax=make
