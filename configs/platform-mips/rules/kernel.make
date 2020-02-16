# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KERNEL) += kernel

#
# Paths and names
#
KERNEL			:= linux-$(KERNEL_VERSION)
KERNEL_MD5		:= $(call remove_quotes,$(PTXCONF_KERNEL_MD5))
ifneq ($(KERNEL_NEEDS_GIT_URL),y)
KERNEL_SUFFIX		:= tar.xz
KERNEL_URL		:= $(call kernel-url, KERNEL)
else
KERNEL_SUFFIX		:= tar.gz
KERNEL_URL		:= https://git.kernel.org/torvalds/t/$(KERNEL).$(KERNEL_SUFFIX)
endif
KERNEL_DIR		:= $(BUILDDIR)/$(KERNEL)
KERNEL_BUILD_DIR	:= $(KERNEL_DIR)-build
KERNEL_CONFIG		:= $(call ptx/in-platformconfigdir, kernelconfig)
KERNEL_LICENSE		:= GPL-2.0-only
KERNEL_SOURCE		:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DEVPKG		:= NO
KERNEL_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KERNEL_CONF_OPT := \
	-C $(KERNEL_DIR) \
	O=$(KERNEL_BUILD_DIR) \
	$(call kernel-opts, KERNEL)

ifdef PTXCONF_KERNEL
$(KERNEL_CONFIG):
	@echo
	@echo "*************************************************************************"
	@echo "**** Please generate a kernelconfig with 'ptxdist menuconfig kernel' ****"
	@echo "*************************************************************************"
	@echo
	@echo
	@exit 1
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

kernel_oldconfig kernel_menuconfig kernel_nconfig: $(STATEDIR)/kernel.extract
	@$(call world/kconfig, KERNEL, $(subst kernel_,,$@))

# vim: syntax=make
