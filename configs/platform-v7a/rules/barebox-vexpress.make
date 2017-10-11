# -*-makefile-*-
#
# Copyright (C) 2017 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
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
BAREBOX_VEXPRESS_VERSION	:= 2017.10.0
BAREBOX_VEXPRESS_MD5		:= cae141fd919810397a7d539959d75aae
BAREBOX_VEXPRESS		:= barebox-$(BAREBOX_VEXPRESS_VERSION)
BAREBOX_VEXPRESS_SUFFIX		:= tar.bz2
BAREBOX_VEXPRESS_DIR		:= $(BUILDDIR)/barebox-vexpress-$(BAREBOX_VEXPRESS_VERSION)
BAREBOX_VEXPRESS_CONFIG		:= $(PTXDIST_PLATFORMCONFIGDIR)/barebox-vexpress.config
BAREBOX_VEXPRESS_LICENSE	:= GPL-2.0
BAREBOX_VEXPRESS_URL		:= $(call barebox-url, BAREBOX_VEXPRESS)
BAREBOX_VEXPRESS_SOURCE		:= $(SRCDIR)/$(BAREBOX_VEXPRESS).$(BAREBOX_VEXPRESS_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_VEXPRESS_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG

BAREBOX_VEXPRESS_CONF_ENV := KCONFIG_NOTIMESTAMP=1
BAREBOX_VEXPRESS_CONF_OPT := $(call barebox-opts, BAREBOX_VEXPRESS)

BAREBOX_VEXPRESS_MAKE_ENV := $(BAREBOX_VEXPRESS_CONF_ENV)
BAREBOX_VEXPRESS_MAKE_OPT := $(BAREBOX_VEXPRESS_CONF_OPT)

BAREBOX_VEXPRESS_IMAGES := images/barebox-vexpress-ca9.img
BAREBOX_VEXPRESS_IMAGES := $(addprefix $(BAREBOX_VEXPRESS_DIR)/,$(BAREBOX_VEXPRESS_IMAGES))

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

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

BAREBOX_VEXPRESS_INSTALL_OPT := \
	$(call barebox-opts, BAREBOX_VEXPRESS)

$(STATEDIR)/barebox-vexpress.install:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_VEXPRESS_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image));)
	@install -D -m644 $(BAREBOX_VEXPRESS_DIR)/defaultenv/barebox_zero_env $(IMAGEDIR)/barebox-zero-env-vexpress
	@install -D -m644 $(BAREBOX_VEXPRESS_DIR)/arch/arm/dts/vexpress-v2p-ca9.dtb $(IMAGEDIR)/bb-vexpress-v2p-ca9.dtb
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-vexpress.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_VEXPRESS)
	@$(foreach image, $(BAREBOX_VEXPRESS_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image));)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-vexpress_oldconfig barebox-vexpress_menuconfig barebox-vexpress_nconfig: $(STATEDIR)/barebox-vexpress.extract
	@$(call world/kconfig, BAREBOX_VEXPRESS, $(subst barebox-vexpress_,,$@))

# vim: syntax=make
