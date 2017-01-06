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
PACKAGES-$(PTXCONF_BAREBOX_GF) += barebox-gf

#
# Paths and names
#
BAREBOX_GF_VERSION	:= 2016.05.0
BAREBOX_GF_MD5		:=
BAREBOX_GF		:= barebox-$(BAREBOX_GF_VERSION)
BAREBOX_GF_SUFFIX	:= tar.bz2
BAREBOX_GF_DIR		:= $(BUILDDIR)/barebox-gf-$(BAREBOX_GF_VERSION)
BAREBOX_GF_CONFIG	:= $(PTXDIST_PLATFORMCONFIGDIR)/barebox-gf.config.$(BAREBOX_GF_VERSION)
BAREBOX_GF_LICENSE	:= GPL-2.0
BAREBOX_GF_URL		:= $(call barebox-url, BAREBOX_GF)
BAREBOX_GF_SOURCE	:= $(SRCDIR)/$(BAREBOX_GF).$(BAREBOX_GF_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_GF_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG

BAREBOX_GF_CONF_ENV := KCONFIG_NOTIMESTAMP=1
BAREBOX_GF_CONF_OPT := $(call barebox-opts, BAREBOX_GF)

BAREBOX_GF_MAKE_ENV := $(BAREBOX_GF_CONF_ENV)
BAREBOX_GF_MAKE_OPT := $(BAREBOX_GF_CONF_OPT)

BAREBOX_GF_IMAGES := barebox.bin
BAREBOX_GF_IMAGES := $(addprefix $(BAREBOX_GF_DIR)/,$(BAREBOX_GF_IMAGES))

ifdef PTXCONF_BAREBOX_GF
$(BAREBOX_GF_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-gf'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-gf.prepare: $(BAREBOX_GF_CONFIG)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

BAREBOX_GF_INSTALL_OPT := \
	$(call barebox-opts, BAREBOX_GF)

$(STATEDIR)/barebox-gf.install:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_GF_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))-gf;)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-gf.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_GF)
	@$(foreach image, $(BAREBOX_GF_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))-gf;)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-gf_oldconfig barebox-gf_menuconfig barebox-gf_nconfig: $(STATEDIR)/barebox-gf.extract
	@$(call world/kconfig, BAREBOX_GF, $(subst barebox-gf_,,$@))

# vim: syntax=make
