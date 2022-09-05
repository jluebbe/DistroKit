# -*-makefile-*-
#
# Copyright (C) 2022 by Michael Riesch <michael.riesch@wolfvision.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_ROCKCHIP) += barebox-rockchip

#
# Paths and names
#
BAREBOX_ROCKCHIP_VERSION	:= 2022.08.0
BAREBOX_ROCKCHIP_MD5		:= 129a9e66ddb90cad7856df827e1dc574
BAREBOX_ROCKCHIP		:= barebox-rockchip-$(BAREBOX_ROCKCHIP_VERSION)
BAREBOX_ROCKCHIP_SUFFIX		:= tar.bz2
BAREBOX_ROCKCHIP_URL		:= $(call barebox-url, BAREBOX_ROCKCHIP)
BAREBOX_ROCKCHIP_PATCHES	:= barebox-rockchip-$(BAREBOX_ROCKCHIP_VERSION)
BAREBOX_ROCKCHIP_SOURCE		:= $(SRCDIR)/$(BAREBOX_ROCKCHIP_PATCHES).$(BAREBOX_ROCKCHIP_SUFFIX)
BAREBOX_ROCKCHIP_DIR		:= $(BUILDDIR)/$(BAREBOX_ROCKCHIP)
BAREBOX_ROCKCHIP_BUILD_DIR	:= $(BAREBOX_ROCKCHIP_DIR)-build
BAREBOX_ROCKCHIP_LICENSE	:= GPL-2.0-only
BAREBOX_ROCKCHIP_DEVPKG		:= NO
BAREBOX_ROCKCHIP_BUILD_OOT	:= KEEP

BAREBOX_ROCKCHIP_CONFIG		:= $(call ptx/in-platformconfigdir, \
		barebox-rockchip.config)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_ROCKCHIP_INJECT_PATH	:= ${PTXDIST_SYSROOT_TARGET}/usr/lib/firmware
BAREBOX_ROCKCHIP_INJECT_FILES	+= rk3568_bl31_v1.24.elf:firmware/rk3568-bl31.bin
BAREBOX_ROCKCHIP_INJECT_FILES	+= rk3568_bl32_v1.05.bin:firmware/rk3568-op-tee.bin
BAREBOX_ROCKCHIP_INJECT_FILES	+= rk3568_ddr_1560MHz_v1.08.bin:arch/arm/boards/rockchip-rk3568-evb/sdram-init.bin
BAREBOX_ROCKCHIP_INJECT_FILES	+= rk3568_ddr_1560MHz_v1.08.bin:arch/arm/boards/radxa-rock3/sdram-init.bin

# use host pkg-config for host tools
BAREBOX_ROCKCHIP_PATH		:= PATH=$(HOST_PATH)

BAREBOX_ROCKCHIP_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_ROCKCHIP_CONF_TOOL	:= kconfig
BAREBOX_ROCKCHIP_CONF_OPT	:= \
	-C $(BAREBOX_ROCKCHIP_DIR) \
	O=$(BAREBOX_ROCKCHIP_BUILD_DIR) \
	$(call barebox-opts, BAREBOX_ROCKCHIP)

BAREBOX_ROCKCHIP_MAKE_OPT	:= $(BAREBOX_ROCKCHIP_CONF_OPT)

BAREBOX_ROCKCHIP_IMAGES := images/barebox-rk3568-evb.img images/barebox-rock3a.img
BAREBOX_ROCKCHIP_IMAGES := $(addprefix $(BAREBOX_ROCKCHIP_BUILD_DIR)/,$(BAREBOX_ROCKCHIP_IMAGES))

ifdef PTXCONF_BAREBOX_ROCKCHIP
$(BAREBOX_ROCKCHIP_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-rockchip'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

BAREBOX_ROCKCHIP_EXTRA_ENV_PATH  := $(foreach path, \
                $(call remove_quotes,"barebox-rock3a-defaultenv"), \
                $(call ptx/in-platformconfigdir,$(path)))
BAREBOX_ROCKCHIP_EXTRA_ENV_DEPS  := \
        $(BAREBOX_ROCKCHIP_EXTRA_ENV_PATH) \
        $(call ptx/force-sh, find $(BAREBOX_ROCKCHIP_EXTRA_ENV_PATH) -print 2>/dev/null)

$(STATEDIR)/barebox-rockchip.prepare: $(BAREBOX_ROCKCHIP_EXTRA_ENV_DEPS)
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX_ROCKCHIP)
	@$(call world/inject, BAREBOX_ROCKCHIP)

	@rm -rf $(BAREBOX_ROCKCHIP_BUILD_DIR)/.ptxdist-defaultenv
	@ptxd_source_kconfig "${PTXDIST_PTXCONFIG}" && \
	ptxd_source_kconfig "${PTXDIST_PLATFORMCONFIG}" && \
	$(foreach path, $(BAREBOX_ROCKCHIP_EXTRA_ENV_PATH), \
		if [ -d "$(path)" ]; then \
			ptxd_filter_dir "$(path)" \
			$(BAREBOX_ROCKCHIP_BUILD_DIR)/.ptxdist-defaultenv; \
		else \
			cp "$(path)" $(BAREBOX_ROCKCHIP_BUILD_DIR)/.ptxdist-defaultenv/; \
		fi;)
	@rm -rf $(BAREBOX_ROCKCHIP_BUILD_DIR)/defaultenv/barebox_default_env

	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-rockchip.compile:
	@$(call targetinfo)

	@if test $$(grep -c -e "^CONFIG_DEFAULT_ENVIRONMENT_PATH=.*\$(BAREBOX_ROCKCHIP_BUILD_DIR)/.ptxdist-defaultenv" $(BAREBOX_ROCKCHIP_BUILD_DIR)/.config) -eq 0; then \
		sed -i -e "s,^\(CONFIG_DEFAULT_ENVIRONMENT_PATH=.*\)\"$$,\1 $(BAREBOX_ROCKCHIP_BUILD_DIR)/.ptxdist-defaultenv\"," \
			$(BAREBOX_ROCKCHIP_BUILD_DIR)/.config; \
	fi

	@$(call world/compile, BAREBOX_ROCKCHIP)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

BAREBOX_ROCKCHIP_PROGS_HOST := \
	rk-usb-loader

$(STATEDIR)/barebox-rockchip.install:
	@$(call targetinfo)

	@$(foreach prog, $(BAREBOX_ROCKCHIP_PROGS_HOST), \
		if [ -e $(BAREBOX_ROCKCHIP_BUILD_DIR)/scripts/$(prog) ]; then \
			install -v -D -m755 \
				$(BAREBOX_ROCKCHIP_BUILD_DIR)/scripts/$(prog) \
				$(PTXDIST_SYSROOT_HOST)/bin/$(notdir $(prog)) \
				|| exit; \
		fi;)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-rockchip.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_ROCKCHIP_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))-rockchip$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-rockchip.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_ROCKCHIP)
	@$(foreach image, $(BAREBOX_ROCKCHIP_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))-rockchip$(ptx/nl))
	@$(foreach prog, $(BAREBOX_ROCKCHIP_PROGS_HOST), \
		rm -vf $(PTXDIST_SYSROOT_HOST)/bin/$(notdir $(prog))$(ptx/nl))


# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

$(call ptx/kconfig-targets, barebox-rockchip): $(STATEDIR)/barebox-rockchip.extract
	@$(call world/kconfig, BAREBOX_ROCKCHIP, $(subst barebox-rockchip_,,$@))

# vim: syntax=make
