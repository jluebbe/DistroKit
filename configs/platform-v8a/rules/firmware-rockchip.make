# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Tretter <m.tretter@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FIRMWARE_ROCKCHIP) += firmware-rockchip

FIRMWARE_ROCKCHIP_VERSION	:= 2021-06-01-g7d631e0d
FIRMWARE_ROCKCHIP_MD5		:= 4ca62f76ca75019dc708c4cb7cc31b0a
FIRMWARE_ROCKCHIP		:= firmware-rockchip-$(FIRMWARE_ROCKCHIP_VERSION)
FIRMWARE_ROCKCHIP_SUFFIX	:= zip
FIRMWARE_ROCKCHIP_URL		:= https://github.com/rockchip-linux/rkbin/archive/$(FIRMWARE_ROCKCHIP_VERSION).$(FIRMWARE_ROCKCHIP_SUFFIX)
FIRMWARE_ROCKCHIP_SOURCE	:= $(SRCDIR)/$(FIRMWARE_ROCKCHIP).$(FIRMWARE_ROCKCHIP_SUFFIX)
FIRMWARE_ROCKCHIP_DIR		:= $(BUILDDIR)/$(FIRMWARE_ROCKCHIP)
FIRMWARE_ROCKCHIP_LICENSE	:= proprietary

#
# Firmware blobs for barebox
#
ifdef PTXCONF_FIRMWARE_ROCKCHIP
BAREBOX_INJECT_FILES		+= rk3568_bl31_v1.24.elf:firmware/rk3568-bl31.bin
BAREBOX_INJECT_FILES		+= rk3568_bl32_v1.05.bin:firmware/rk3568-op-tee.bin
BAREBOX_INJECT_FILES		+= rk3568_ddr_1560MHz_v1.08.bin:arch/arm/boards/rockchip-rk3568-evb/sdram-init.bin
BAREBOX_INJECT_FILES		+= rk3568_ddr_1560MHz_v1.08.bin:arch/arm/boards/radxa-rock3/sdram-init.bin
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FIRMWARE_ROCKCHIP_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/firmware-rockchip.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/firmware-rockchip.install:
	@$(call targetinfo)

ifdef PTXCONF_FIRMWARE_ROCKCHIP_RK3566_SDRAM
	install -v -D -m644 $(FIRMWARE_ROCKCHIP_DIR)/bin/rk35/rk3566_ddr_1056MHz_v1.08.bin \
		$(FIRMWARE_ROCKCHIP_PKGDIR)/usr/lib/firmware/rk3566_ddr_1056MHz_v1.08.bin
endif

ifdef PTXCONF_FIRMWARE_ROCKCHIP_RK3568_SDRAM
	install -v -D -m644 $(FIRMWARE_ROCKCHIP_DIR)/bin/rk35/rk3568_ddr_1560MHz_v1.08.bin \
		$(FIRMWARE_ROCKCHIP_PKGDIR)/usr/lib/firmware/rk3568_ddr_1560MHz_v1.08.bin
endif

ifdef PTXCONF_FIRMWARE_ROCKCHIP_RK356x_BL31
	install -v -D -m644 $(FIRMWARE_ROCKCHIP_DIR)/bin/rk35/rk3568_bl31_v1.24.elf \
		$(FIRMWARE_ROCKCHIP_PKGDIR)/usr/lib/firmware/rk3568_bl31_v1.24.elf
endif

ifdef PTXCONF_FIRMWARE_ROCKCHIP_RK356x_BL32
	install -v -D -m644 $(FIRMWARE_ROCKCHIP_DIR)/bin/rk35/rk3568_bl32_v1.05.bin \
		$(FIRMWARE_ROCKCHIP_PKGDIR)/usr/lib/firmware/rk3568_bl32_v1.05.bin
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/firmware-rockchip.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
