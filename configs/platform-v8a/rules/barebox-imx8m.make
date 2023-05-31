# -*-makefile-*-
#
# Copyright (C) 2020 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_IMX8M) += barebox-imx8m

#
# Paths and names
#
BAREBOX_IMX8M_VERSION	:= 2023.05.0
BAREBOX_IMX8M_MD5	:= 35a6a96f00df2a3f596efdc5d2459cb5
BAREBOX_IMX8M		:= barebox-imx8m-$(BAREBOX_IMX8M_VERSION)
BAREBOX_IMX8M_SUFFIX	:= tar.bz2
BAREBOX_IMX8M_URL	:= $(call barebox-url, BAREBOX_IMX8M)
BAREBOX_IMX8M_PATCHES	:= barebox-$(BAREBOX_IMX8M_VERSION)
BAREBOX_IMX8M_SOURCE	:= $(SRCDIR)/$(BAREBOX_IMX8M_PATCHES).$(BAREBOX_IMX8M_SUFFIX)
BAREBOX_IMX8M_DIR	:= $(BUILDDIR)/$(BAREBOX_IMX8M)
BAREBOX_IMX8M_BUILD_DIR	:= $(BAREBOX_IMX8M_DIR)-build
BAREBOX_IMX8M_CONFIG	:= $(call ptx/in-platformconfigdir, barebox-imx8m.config)
BAREBOX_IMX8M_LICENSE	:= GPL-2.0-only
BAREBOX_IMX8M_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_IMX8M_INJECT_PATH	:= ${PTXDIST_SYSROOT_TARGET}/usr/lib

# TF-A firmware blobs
BAREBOX_IMX8M_INJECT_FILES	+= firmware/imx8mm-bl31.bin
BAREBOX_IMX8M_INJECT_FILES	+= firmware/imx8mp-bl31.bin
BAREBOX_IMX8M_INJECT_FILES	+= firmware/imx8mq-bl31.bin

# DRAM firmware blobs
BAREBOX_IMX8M_INJECT_FILES	+= firmware/ddr/synopsys/lpddr4_pmu_train_1d_dmem.bin:firmware/lpddr4_pmu_train_1d_dmem.bin
BAREBOX_IMX8M_INJECT_FILES	+= firmware/ddr/synopsys/lpddr4_pmu_train_1d_imem.bin:firmware/lpddr4_pmu_train_1d_imem.bin
BAREBOX_IMX8M_INJECT_FILES	+= firmware/ddr/synopsys/lpddr4_pmu_train_2d_dmem.bin:firmware/lpddr4_pmu_train_2d_dmem.bin
BAREBOX_IMX8M_INJECT_FILES	+= firmware/ddr/synopsys/lpddr4_pmu_train_2d_imem.bin:firmware/lpddr4_pmu_train_2d_imem.bin

# use host pkg-config for host tools
BAREBOX_IMX8M_PATH := PATH=$(HOST_PATH)

BAREBOX_IMX8M_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_IMX8M_CONF_OPT := \
	-C $(BAREBOX_IMX8M_DIR) \
	O=$(BAREBOX_IMX8M_BUILD_DIR) \
	BUILDSYSTEM_VERSION=$(PTXDIST_VCS_VERSION) \
	$(call barebox-opts, BAREBOX_IMX8M)

BAREBOX_IMX8M_MAKE_OPT := $(BAREBOX_IMX8M_CONF_OPT)

BAREBOX_IMX8M_IMAGES := barebox-nxp-imx8mp-evk.img \
	barebox-nxp-imx8mq-evk.img \
	barebox-nxp-imx8mm-evk.img
BAREBOX_IMX8M_IMAGES := $(addprefix $(BAREBOX_IMX8M_BUILD_DIR)/images/,$(BAREBOX_IMX8M_IMAGES))

ifdef PTXCONF_BAREBOX_IMX8M
$(BAREBOX_IMX8M_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-imx8m'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-imx8m.prepare: $(BAREBOX_IMX8M_CONFIG)
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX_IMX8M)
	@$(call world/inject, BAREBOX_IMX8M)

	@rm -f "$(BAREBOX_IMX8M_BUILD_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-common-defaultenv)" \
		"$(BAREBOX_IMX8M_BUILD_DIR)/.ptxdist-defaultenv"

	@$(call touch)


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-imx8m.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-imx8m.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_IMX8M_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))-imx8m$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-imx8m.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_IMX8M)
	@$(foreach image, $(BAREBOX_IMX8M_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))-imx8m$(ptx/nl))

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-imx8m_oldconfig barebox-imx8m_menuconfig barebox-imx8m_nconfig: $(STATEDIR)/barebox-imx8m.extract
	@$(call world/kconfig, BAREBOX_IMX8M, $(subst barebox-imx8m_,,$@))

# vim: syntax=make
