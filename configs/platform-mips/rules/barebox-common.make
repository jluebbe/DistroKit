# -*-makefile-*-
#
# Copyright (C) 2019 Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_COMMON) += barebox-common

#
# Paths and names
#
BAREBOX_COMMON_VERSION		:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_VERSION))
BAREBOX_COMMON_MD5		:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_MD5))
BAREBOX_COMMON			:= barebox-common-$(BAREBOX_COMMON_VERSION)
BAREBOX_COMMON_SUFFIX		:= tar.bz2
BAREBOX_COMMON_URL		:= $(call barebox-url, BAREBOX_COMMON)
BAREBOX_COMMON_PATCHES		:= barebox-$(BAREBOX_COMMON_VERSION)
BAREBOX_COMMON_SOURCE		:= $(SRCDIR)/$(BAREBOX_COMMON_PATCHES).$(BAREBOX_COMMON_SUFFIX)
BAREBOX_COMMON_DIR		:= $(BUILDDIR)/$(BAREBOX_COMMON)
BAREBOX_COMMON_BUILD_DIR	:= $(BAREBOX_COMMON_DIR)-build
BAREBOX_COMMON_CONFIG		:= $(call ptx/in-platformconfigdir, barebox.config)
BAREBOX_COMMON_LICENSE		:= GPL-2.0-only
BAREBOX_COMMON_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_COMMON_PATH := PATH=$(HOST_PATH)

BAREBOX_COMMON_CONF_OPT := \
	-C $(BAREBOX_COMMON_DIR) \
	O=$(BAREBOX_COMMON_BUILD_DIR) \
	$(call barebox-opts, BAREBOX_COMMON)

BAREBOX_COMMON_MAKE_OPT := $(BAREBOX_COMMON_CONF_OPT)

BAREBOX_COMMON_TAGS_OPT := TAGS tags cscope

ifdef PTXCONF_BAREBOX_COMMON
$(BAREBOX_COMMON_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-common'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-common.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-common.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-common_menuconfig barebox-common_nconfig: $(STATEDIR)/barebox-common.extract
	@$(call world/kconfig, BAREBOX_COMMON, $(subst barebox-common_,,$@))

barebox-common_oldconfig_: $(STATEDIR)/barebox-common.extract
	@$(call world/kconfig, BAREBOX_COMMON, oldconfig)

# vim: syntax=make
