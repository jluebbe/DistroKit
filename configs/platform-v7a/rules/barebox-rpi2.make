# -*-makefile-*-
#
# Copyright (C) 2016 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_RPI2) += barebox-rpi2

#
# Paths and names
#
BAREBOX_RPI2_VERSION	:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_VERSION))
BAREBOX_RPI2_MD5	:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_MD5))
BAREBOX_RPI2		:= barebox-rpi2-$(BAREBOX_RPI2_VERSION)
BAREBOX_RPI2_SUFFIX	:= tar.bz2
BAREBOX_RPI2_URL	:= $(call barebox-url, BAREBOX_RPI2)
BAREBOX_RPI2_PATCHES	:= barebox-$(BAREBOX_RPI2_VERSION)
BAREBOX_RPI2_SOURCE	:= $(SRCDIR)/$(BAREBOX_RPI2_PATCHES).$(BAREBOX_RPI2_SUFFIX)
BAREBOX_RPI2_DIR	:= $(BUILDDIR)/$(BAREBOX_RPI2)
BAREBOX_RPI2_BUILD_DIR	:= $(BAREBOX_RPI2_DIR)-build
BAREBOX_RPI2_CONFIG	:= $(call ptx/in-platformconfigdir, barebox-rpi2.config)
BAREBOX_RPI2_REF_CONFIG := $(call ptx/in-platformconfigdir, barebox.config)
BAREBOX_RPI2_LICENSE	:= GPL-2.0-only
BAREBOX_RPI2_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_RPI2_PATH := PATH=$(HOST_PATH)

BAREBOX_RPI2_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_RPI2_CONF_OPT := \
	-C $(BAREBOX_RPI2_DIR) \
	O=$(BAREBOX_RPI2_BUILD_DIR) \
	$(call barebox-opts, BAREBOX_RPI2)

BAREBOX_RPI2_MAKE_OPT := $(BAREBOX_RPI2_CONF_OPT)

BAREBOX_RPI2_IMAGES := images/barebox-raspberry-pi-2.img images/barebox-raspberry-pi-3.img
BAREBOX_RPI2_IMAGES := $(addprefix $(BAREBOX_RPI2_BUILD_DIR)/,$(BAREBOX_RPI2_IMAGES))

ifdef PTXCONF_BAREBOX_RPI2
$(BAREBOX_RPI2_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-rpi2'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-rpi2.prepare: $(BAREBOX_RPI2_CONFIG)
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX_RPI2)
	@rm -f "$(BAREBOX_RPI2_BUILD_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-rpi2-defaultenv)" \
		"$(BAREBOX_RPI2_BUILD_DIR)/.ptxdist-defaultenv"
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-rpi2.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-rpi2.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_RPI2_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-rpi2.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_RPI2)
	@$(foreach image, $(BAREBOX_RPI2_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-rpi2_oldconfig barebox-rpi2_menuconfig barebox-rpi2_nconfig: $(STATEDIR)/barebox-rpi2.extract
	@$(call world/kconfig, BAREBOX_RPI2, $(subst barebox-rpi2_,,$@))

# vim: syntax=make
