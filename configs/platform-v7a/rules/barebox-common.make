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
EXTRA_PACKAGES-$(PTXCONF_BAREBOX_COMMON) += barebox-common

#
# Paths and names
#
BAREBOX_COMMON_VERSION	:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_VERSION))
BAREBOX_COMMON_MD5	:= $(call remove_quotes,$(PTXCONF_BAREBOX_COMMON_MD5))
BAREBOX_COMMON		:= barebox-common-$(BAREBOX_COMMON_VERSION)
BAREBOX_COMMON_SUFFIX	:= tar.bz2
BAREBOX_COMMON_URL	:= $(call barebox-url, BAREBOX_COMMON)
BAREBOX_COMMON_SOURCE	:= $(SRCDIR)/barebox-$(BAREBOX_COMMON_VERSION).$(BAREBOX_COMMON_SUFFIX)
BAREBOX_COMMON_DIR	:= $(BUILDDIR)/$(BAREBOX_COMMON)
BAREBOX_COMMON_LICENSE	:= GPL-2.0-only
BAREBOX_COMMON_DEVPKG	:= NO

BAREBOX_COMMON_CONFIG	:= $(call ptx/in-platformconfigdir, barebox.config)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_COMMON_PATH := PATH=$(HOST_PATH)

BAREBOX_COMMON_CONF_OPT := $(call barebox-opts)
BAREBOX_COMMON_MAKE_OPT := $(BAREBOX_COMMON_CONF_OPT)

BAREBOX_COMMON_TAGS_OPT := TAGS tags cscope

$(STATEDIR)/barebox-common.prepare:
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX_COMMON)
	@$(call touch)

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
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-common.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-common_oldconfig barebox-common_menuconfig barebox-common_nconfig: $(STATEDIR)/barebox-common.extract
	@$(call world/kconfig, BAREBOX_COMMON, $(subst barebox-common_,,$@))

# vim: syntax=make
