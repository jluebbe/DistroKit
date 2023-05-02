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
PACKAGES-$(PTXCONF_KERNEL_MALTA) += kernel-malta

#
# Paths and names
#
KERNEL_MALTA_VERSION	:= $(call ptx/config-version, PTXCONF_KERNEL)
KERNEL_MALTA_MD5	:= $(call ptx/config-md5, PTXCONF_KERNEL)
KERNEL_MALTA		:= linux-malta-$(KERNEL_MALTA_VERSION)
KERNEL_MALTA_SUFFIX	:= tar.xz
KERNEL_MALTA_URL	:= $(call kernel-url, KERNEL_MALTA)
KERNEL_MALTA_PATCHES	:= linux-$(KERNEL_MALTA_VERSION)
KERNEL_MALTA_SOURCE	:= $(SRCDIR)/$(KERNEL_MALTA_PATCHES).$(KERNEL_MALTA_SUFFIX)
KERNEL_MALTA_DIR	:= $(BUILDDIR)/$(KERNEL_MALTA)
KERNEL_MALTA_BUILD_DIR	:= $(KERNEL_MALTA_DIR)-build
KERNEL_MALTA_CONFIG	:= $(call ptx/in-platformconfigdir, kernelconfig-malta)
KERNEL_MALTA_REF_CONFIG	:= $(call ptx/in-platformconfigdir, kernelconfig)
KERNEL_MALTA_DTS_PATH	:= ${PTXDIST_PLATFORMCONFIG_SUBDIR}/dts:${KERNEL_MALTA_DIR}/arch/${GENERIC_KERNEL_ARCH}/boot/dts/mti
KERNEL_MALTA_DTS	:= malta.dts
KERNEL_MALTA_DTB_FILES	:= $(addsuffix .dtb,$(basename $(KERNEL_MALTA_DTS)))
KERNEL_MALTA_LICENSE	:= GPL-2.0-only
KERNEL_MALTA_LICENSE_FILES	:=
KERNEL_MALTA_BUILD_OOT	:= KEEP

# track changes to devices-trees in the BSP
$(call world/dts-cfghash-file, KERNEL_MALTA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use CONFIG_CC_STACKPROTECTOR if available. The rest makes no sense for the kernel
KERNEL_MALTA_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

KERNEL_MALTA_PATH	:= PATH=$(CROSS_PATH)
KERNEL_MALTA_SHARED_OPT	:= \
	-C $(KERNEL_MALTA_DIR) \
	O=$(KERNEL_MALTA_BUILD_DIR) \
	PAHOLE=false \
	$(call kernel-opts, KERNEL_MALTA)

# no gcc plugins; avoid config changes depending on the host compiler
KERNEL_MALTA_SHARED_OPT	+= \
	HOSTCXX="$(HOSTCXX) -DGENERATOR_FILE" \
	HOSTCC="$(HOSTCC) -DGENERATOR_FILE"
KERNEL_MALTA_CONF_ENV	:= \
	PTXDIST_NO_GCC_PLUGINS=1
KERNEL_MALTA_MAKE_ENV	:= \
	PTXDIST_NO_GCC_PLUGINS=1

KERNEL_MALTA_CONF_TOOL	:= kconfig
KERNEL_MALTA_CONF_OPT	:= \
	$(KERNEL_MALTA_SHARED_OPT)

# force using KERNEL_MALTA_VERSION in the kernelconfig
#KERNEL_MALTA_CONF_OPT	+= \
#	KERNELVERSION=$(KERNEL_MALTA_VERSION)

KERNEL_MALTA_IMAGES	:= vmlinuz
KERNEL_MALTA_IMAGES	:= $(addprefix $(KERNEL_MALTA_BUILD_DIR)/,$(KERNEL_MALTA_IMAGES))

ifdef PTXCONF_KERNEL_MALTA
$(KERNEL_MALTA_CONFIG):
	@echo
	@echo "*************************************************************************"
	@echo " Please generate a kernelconfig with 'ptxdist menuconfig kernel-malta'"
	@echo "*************************************************************************"
	@echo
	@echo
	@exit 1
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

KERNEL_MALTA_MAKE_OPT	:= \
	$(KERNEL_MALTA_SHARED_OPT) \
	vmlinuz modules

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

KERNEL_MALTA_INSTALL_OPT	:= \
	$(call kernel-opts, KERNEL_MALTA) \
	modules_install

$(STATEDIR)/kernel-malta.install:
	@$(call targetinfo)
	@$(call world/install, KERNEL_MALTA)
	@$(call world/dtb, KERNEL_MALTA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-malta.targetinstall:
	@$(call targetinfo)

	@$(foreach image, $(KERNEL_MALTA_IMAGES), \
		install -v -m 644 $(image) \
			$(IMAGEDIR)/$(notdir $(image))-malta$(ptx/nl))

	@$(foreach dtb ,$(KERNEL_MALTA_DTB_FILES), \
		echo -e "Installing $(dtb) ...\n"$(ptx/nl) \
		install -D -m0644 $(KERNEL_MALTA_PKGDIR)/boot/$(dtb) \
			$(IMAGEDIR)/$(dtb)$(ptx/nl))

	@$(call install_init,  kernel-malta)
	@$(call install_fixup, kernel-malta, PRIORITY,optional)
	@$(call install_fixup, kernel-malta, SECTION,base)
	@$(call install_fixup, kernel-malta, AUTHOR,"Oleksij Rempel <o.rempel@pengutronix.de>")
	@$(call install_fixup, kernel-malta, DESCRIPTION,missing)

	@$(call install_copy, kernel-malta, 0, 0, 0644, \
		$(IMAGEDIR)/vmlinuz-malta, /boot/vmlinuz-malta, n)

	@$(foreach dtb, $(KERNEL_MALTA_DTB_FILES), \
		$(call install_copy, kernel-malta, 0, 0, 0644, -, \
			/boot/$(dtb), n)$(ptx/nl))

	@$(call install_glob, kernel-malta, 0, 0, -, /lib/modules, *.ko,, n)
	@$(call install_glob, kernel-malta, 0, 0, -, /lib/modules,, *.ko */build */source, n)

	@$(call install_finish, kernel-malta)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-malta.clean:
	@$(call targetinfo)
	@$(call clean_pkg, KERNEL_MALTA)
	@$(foreach dtb,$(KERNEL_MALTA_DTB_FILES), \
		rm -vf $(IMAGEDIR)/$(dtb)$(ptx/nl))

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

$(call ptx/kconfig-targets, kernel-malta): $(STATEDIR)/kernel-malta.extract
	@$(call world/kconfig, KERNEL_MALTA, $(subst kernel-malta_,,$@))

# vim: syntax=make
