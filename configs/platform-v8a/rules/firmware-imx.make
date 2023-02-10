# -*-makefile-*-
#
# Copyright (C) 2016 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FIRMWARE_IMX) += firmware-imx

#
# Paths and names
#
FIRMWARE_IMX_VERSION	:= 8.8
FIRMWARE_IMX_MD5	:= eabb27d28bba375a9f14d6306c07af5f
FIRMWARE_IMX_SKIP	:= 38918
FIRMWARE_IMX		:= firmware-imx-$(FIRMWARE_IMX_VERSION)
FIRMWARE_IMX_SUFFIX	:= bin
FIRMWARE_IMX_URL	:= http://www.nxp.com/lgfiles/NMG/MAD/YOCTO/$(FIRMWARE_IMX).$(FIRMWARE_IMX_SUFFIX)
FIRMWARE_IMX_LICENSE	:= NXP-Software-License-Agreement
FIRMWARE_IMX_LICENSE_FILES := \
	file://$(FIRMWARE_IMX_PKGDIR)/COPYING;md5=228c72f2a91452b8a03c4cab30f30ef9
FIRMWARE_IMX_SOURCE	:= $(SRCDIR)/$(FIRMWARE_IMX).$(FIRMWARE_IMX_SUFFIX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/firmware-imx.extract:
	@$(call targetinfo)
	@mkdir -p "$(PKGDIR)"
	@dd if=$(FIRMWARE_IMX_SOURCE) bs=$(FIRMWARE_IMX_SKIP) skip=1 | tar xj -C $(PKGDIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/firmware-imx.install:
	@$(call targetinfo)

ifdef PTXCONF_FIRMWARE_IMX_BOOTIMAGE_IMX8
	@$(foreach f, lpddr4_pmu_train_1d_dmem.bin lpddr4_pmu_train_1d_imem.bin \
	              lpddr4_pmu_train_2d_dmem.bin lpddr4_pmu_train_2d_imem.bin, \
		install -v -D -m644 $(FIRMWARE_IMX_PKGDIR)/firmware/ddr/synopsys/$(f) \
		$(PTXCONF_SYSROOT_TARGET)/usr/lib/firmware/ddr/synopsys/$(f);)

	@$(foreach f, signed_dp_imx8m.bin signed_hdmi_imx8m.bin, \
		install -v -D -m644 $(FIRMWARE_IMX_PKGDIR)/firmware/hdmi/cadence/$(f) \
		$(PTXCONF_SYSROOT_TARGET)/usr/lib/firmware/hdmi/cadence/$(f);)
endif

	@$(call touch)
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

FIRMWARE_IMX_INSTALL-y					:=
FIRMWARE_IMX_INSTALL-$(PTXCONF_FIRMWARE_IMX_VPU_IMX27)	+= vpu_fw_imx27_TO2.bin
FIRMWARE_IMX_INSTALL-$(PTXCONF_FIRMWARE_IMX_VPU_IMX6Q)	+= vpu_fw_imx6q.bin
FIRMWARE_IMX_INSTALL-$(PTXCONF_FIRMWARE_IMX_VPU_IMX6DL)	+= vpu_fw_imx6d.bin
FIRMWARE_IMX_INSTALL-$(PTXCONF_FIRMWARE_IMX_VPU_IMX53)	+= vpu_fw_imx53.bin
FIRMWARE_IMX_INSTALL-$(PTXCONF_FIRMWARE_IMX_VPU_IMX51)	+= vpu_fw_imx51.bin

$(STATEDIR)/firmware-imx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, firmware-imx)
	@$(call install_fixup, firmware-imx,PRIORITY,optional)
	@$(call install_fixup, firmware-imx,SECTION,base)
	@$(call install_fixup, firmware-imx,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, firmware-imx,DESCRIPTION,missing)
	@for f in $(FIRMWARE_IMX_INSTALL-y); do \
		$(call install_copy, firmware-imx, 0, 0, 0644, \
		$(FIRMWARE_IMX_PKGDIR)/firmware/vpu/$$f, /usr/lib/firmware/$$f); \
	done
	@$(call install_finish, firmware-imx)

	@$(call touch)

# vim: syntax=make
