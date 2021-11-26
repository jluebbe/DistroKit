# -*-makefile-*-
#
# Copyright (C) 2020 by Oleksij Rempel <o.rempel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KERNEL_AR9331) += kernel-ar9331

#
# Paths and names
#
KERNEL_AR9331_VERSION	:= $(KERNEL_VERSION)
KERNEL_AR9331_MD5	:= $(call remove_quotes,$(PTXCONF_KERNEL_MD5))
KERNEL_AR9331		:= linux-ar9331-$(KERNEL_AR9331_VERSION)
KERNEL_AR9331_SUFFIX	:= tar.xz
KERNEL_AR9331_URL	:= $(call kernel-url, KERNEL_AR9331)
KERNEL_AR9331_PATCHES	:= linux-$(KERNEL_AR9331_VERSION)
KERNEL_AR9331_SOURCE	:= $(SRCDIR)/$(KERNEL_AR9331_PATCHES).$(KERNEL_AR9331_SUFFIX)
KERNEL_AR9331_DIR	:= $(BUILDDIR)/$(KERNEL_AR9331)
KERNEL_AR9331_BUILD_DIR	:= $(KERNEL_AR9331_DIR)-build
KERNEL_AR9331_CONFIG	:= $(call ptx/in-platformconfigdir, kernelconfig-ar9331)
KERNEL_AR9331_REF_CONFIG	:= $(call ptx/in-platformconfigdir, kernelconfig)
KERNEL_AR9331_LICENSE	:= GPL-2.0-only
KERNEL_AR9331_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use CONFIG_CC_STACKPROTECTOR if available. The rest makes no sense for the kernel
KERNEL_AR9331_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

KERNEL_AR9331_PATH	:= PATH=$(CROSS_PATH)
KERNEL_AR9331_CONF_OPT	:= \
	-C $(KERNEL_AR9331_DIR) \
	O=$(KERNEL_AR9331_BUILD_DIR) \
	$(call kernel-opts, KERNEL_AR9331)

# no gcc plugins; avoid config changes depending on the host compiler
KERNEL_AR9331_CONF_OPT += \
	HOSTCXX=false

KERNEL_AR9331_IMAGES := vmlinuz
KERNEL_AR9331_IMAGES := $(addprefix $(KERNEL_AR9331_BUILD_DIR)/,$(KERNEL_AR9331_IMAGES))

ifdef PTXCONF_KERNEL_AR9331
$(KERNEL_AR9331_CONFIG):
	@echo
	@echo "*************************************************************************"
	@echo " Please generate a kernelconfig with 'ptxdist menuconfig kernel-ar9331'"
	@echo "*************************************************************************"
	@echo
	@echo
	@exit 1
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

KERNEL_AR9331_MAKE_OPT := \
	$(KERNEL_AR9331_CONF_OPT) \
	vmlinuz modules

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

KERNEL_AR9331_INSTALL_OPT := \
	$(call kernel-opts, KERNEL_AR9331) \
	modules_install

$(STATEDIR)/kernel-ar9331.install:
	@$(call targetinfo)
	@$(call world/install, KERNEL_AR9331)
	@$(foreach image, $(KERNEL_AR9331_IMAGES), \
		install -m 644 $(image) $(IMAGEDIR)/$(notdir $(image))-ar9331$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-ar9331.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  kernel-ar9331)
	@$(call install_fixup, kernel-ar9331, PRIORITY,optional)
	@$(call install_fixup, kernel-ar9331, SECTION,base)
	@$(call install_fixup, kernel-ar9331, AUTHOR,"Oleksij Rempel <o.rempel@pengutronix.de>")
	@$(call install_fixup, kernel-ar9331, DESCRIPTION,missing)

	@$(call install_copy, kernel-ar9331, 0, 0, 0644, \
		$(IMAGEDIR)/vmlinuz-ar9331, /boot/vmlinuz-ar9331, n)

	@$(call install_glob, kernel-ar9331, 0, 0, -, /lib/modules, *.ko,, n)
	@$(call install_glob, kernel-ar9331, 0, 0, -, /lib/modules,, *.ko */build */source, n)

	@$(call install_finish, kernel-ar9331)

	@$(call touch)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

kernel-ar9331_oldconfig kernel-ar9331_menuconfig kernel-ar9331_nconfig: $(STATEDIR)/kernel-ar9331.extract
	@$(call world/kconfig, KERNEL_AR9331, $(subst kernel-ar9331_,,$@))

# vim: syntax=make
