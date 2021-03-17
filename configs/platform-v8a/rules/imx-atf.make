# -*-makefile-*-
#
# Copyright (C) 2019 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IMX_ATF) += imx-atf

#
# Paths and names
#
IMX_ATF_VERSION	:= imx_5.4.24_2.1.0
IMX_ATF_MD5	:= f60e3f42e90d552227d6fc1278761637
IMX_ATF		:= imx-atf-$(IMX_ATF_VERSION)
IMX_ATF_SUFFIX	:= tar.xz
IMX_ATF_URL	:= https://source.codeaurora.org/external/imx/imx-atf.git;tag=rel_$(IMX_ATF_VERSION)
IMX_ATF_SOURCE	:= $(SRCDIR)/$(IMX_ATF).$(IMX_ATF_SUFFIX)
IMX_ATF_DIR	:= $(BUILDDIR)/$(IMX_ATF)
IMX_ATF_LICENSE	:= BSD-3-clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
IMX_ATF_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

IMX_ATF_CONF_TOOL := NO

IMX_ATF_CONF_OPT := \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE)

IMX_ATF_PLATFORMS := imx8mq imx8mm imx8mp

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------
IMX_ATF_MAKE_OPT := $(IMX_ATF_CONF_OPT)

$(STATEDIR)/imx-atf.compile:
	@$(call targetinfo)

	@$(foreach plat, $(IMX_ATF_PLATFORMS), \
		$(call compile, IMX_ATF, \
		$(IMX_ATF_MAKE_OPT) PLAT=$(plat) bl31)$(ptx/nl))

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/imx-atf.install:
	@$(call targetinfo)

	@$(foreach plat, $(IMX_ATF_PLATFORMS), \
		install -v -D -m644 $(IMX_ATF_DIR)/build/$(plat)/release/bl31.bin \
		$(PTXCONF_SYSROOT_TARGET)/usr/lib/atf/$(plat)-bl31.bin;)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/imx-atf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, imx-atf)
	@$(call install_fixup, imx-atf,PRIORITY,optional)
	@$(call install_fixup, imx-atf,SECTION,base)
	@$(call install_fixup, imx-atf,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, imx-atf,DESCRIPTION,missing)

	@$(call install_finish, imx-atf)

	@$(call touch)

# vim: syntax=make
