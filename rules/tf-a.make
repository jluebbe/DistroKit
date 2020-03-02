# -*-makefile-*-
#
# Copyright (C) 2018 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#               2019 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TF_A) += tf-a

#
# Paths and names
#
TF_A_VERSION	:= $(call remove_quotes,$(PTXCONF_TF_A_VERSION))
TF_A_MD5	:= $(call remove_quotes,$(PTXCONF_TF_A_MD5))
TF_A		:= tf-a-$(TF_A_VERSION)
TF_A_SUFFIX	:= tar.gz
TF_A_URL	:= https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/snapshot/$(TF_A_VERSION).$(TF_A_SUFFIX)
TF_A_SOURCE	:= $(SRCDIR)/$(TF_A).$(TF_A_SUFFIX)
TF_A_DIR	:= $(BUILDDIR)/$(TF_A)
TF_A_LICENSE    := BSD-3-Clause AND BSD-2-Clause \
		   AND (GPL-2.0-or-later OR BSD-2-Clause) \
		   AND (NCSA OR MIT) \
		   AND Zlib \
		   AND (GPL-2.0-or-later OR BSD-3-Clause)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TF_A_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

TF_A_RELEASE := 1

TF_A_PATH	:= PATH=$(CROSS_PATH)
TF_A_MAKE_OPT	:= \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE) \
	HOSTCC=$(HOSTCC) \
	PLAT=$(PTXCONF_TF_A_PLATFORM) \
	DEBUG=$(if $(filter 1,$(TF_A_RELEASE)),0,1) \
	ARCH=$(PTXCONF_TF_A_ARCH_STRING) \
	ARM_ARCH_MAJOR=$(PTXCONF_TF_A_ARM_ARCH_MAJOR) \
	BUILD_STRING=$(PTXCONF_TF_A_VERSION) \
	$(call remove_quotes,$(PTXCONF_TF_A_EXTRA_ARGS)) \
	all

ifdef PTXCONF_TF_A_BL32_TSP
TF_A_MAKE_OPT += ARM_TSP_RAM_LOCATION=$(PTXCONF_TF_A_BL32_TSP_RAM_LOCATION_STRING)
endif
ifdef PTXCONF_TF_A_ARM_ARCH_MINOR
TF_A_MAKE_OPT += ARM_ARCH_MINOR=$(PTXCONF_TF_A_ARM_ARCH_MINOR)
endif
ifdef PTXCONF_TF_A_BL32_SP_MIN
TF_A_MAKE_OPT += AARCH32_SP=sp_min
endif

ifdef PTXCONF_TF_A
ifeq ($(PTXCONF_TF_A_ARTIFACTS),)
$(error TF_A_ARTIFACTS is empty. nothing to install.)
endif
endif

TF_A_CONF_TOOL	:= NO

$(STATEDIR)/tf-a.prepare:
	@$(call targetinfo)
	@rm -rf $(TF_A_DIR)/build/
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

TF_A_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

TF_A_BUILD_OUTPUT_DIR := $(TF_A_DIR)/build/$(call remove_quotes, \
	$(PTXCONF_TF_A_PLATFORM))/$(if $(filter 1,$(TF_A_RELEASE)),release,debug)
TF_A_ARTIFACTS_SRC = $(wildcard $(addprefix $(TF_A_BUILD_OUTPUT_DIR)/, \
	$(call remove_quotes,$(PTXCONF_TF_A_ARTIFACTS))))
TF_A_ARTIFACTS_DEST = $(subst $(TF_A_BUILD_OUTPUT_DIR)/,,$(TF_A_ARTIFACTS_SRC))

$(STATEDIR)/tf-a.install:
	@$(call targetinfo)
	@$(foreach artifact, $(TF_A_ARTIFACTS_SRC), \
		install -v -D -m 644 $(artifact) \
		$(TF_A_PKGDIR)/usr/lib/firmware/$(notdir $(artifact))$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tf-a.targetinstall:
	@$(call targetinfo)
	@$(foreach artifact, $(TF_A_ARTIFACTS_SRC), \
		install -v -D -m 644 $(artifact) \
		$(IMAGEDIR)/$(notdir $(artifact))$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/tf-a.clean:
	@$(call targetinfo)
	@rm -f $(addprefix $(IMAGEDIR)/, $(TF_A_ARTIFACTS_DEST))
	@$(call clean_pkg, TF_A)

# vim: syntax=make
