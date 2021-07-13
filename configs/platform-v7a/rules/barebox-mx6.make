# -*-makefile-*-
#
# Copyright (C) 2017 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_MX6) += barebox-mx6

#
# Paths and names
#
BAREBOX_MX6_VERSION	:= $(call ptx/config-version, PTXCONF_BAREBOX_COMMON)
BAREBOX_MX6_MD5		:= $(call ptx/config-md5, PTXCONF_BAREBOX_COMMON)
BAREBOX_MX6		:= barebox-mx6-$(BAREBOX_MX6_VERSION)
BAREBOX_MX6_SUFFIX	:= tar.bz2
BAREBOX_MX6_URL		:= $(call barebox-url, BAREBOX_MX6)
BAREBOX_MX6_PATCHES	:= barebox-$(BAREBOX_MX6_VERSION)
BAREBOX_MX6_SOURCE	:= $(SRCDIR)/$(BAREBOX_MX6_PATCHES).$(BAREBOX_MX6_SUFFIX)
BAREBOX_MX6_DIR		:= $(BUILDDIR)/$(BAREBOX_MX6)
BAREBOX_MX6_BUILD_DIR	:= $(BAREBOX_MX6_DIR)-build
BAREBOX_MX6_CONFIG	:= $(call ptx/in-platformconfigdir, barebox-mx6.config)
BAREBOX_MX6_REF_CONFIG	:= $(call ptx/in-platformconfigdir, barebox.config)
BAREBOX_MX6_LICENSE	:= GPL-2.0-only
BAREBOX_MX6_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_MX6_PATH := PATH=$(HOST_PATH)

BAREBOX_MX6_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_MX6_CONF_OPT := \
	-C $(BAREBOX_MX6_DIR) \
	O=$(BAREBOX_MX6_BUILD_DIR) \
	BUILDSYSTEM_VERSION=$(PTXDIST_VCS_VERSION) \
	$(call barebox-opts, BAREBOX_MX6)

BAREBOX_MX6_MAKE_OPT := $(BAREBOX_MX6_CONF_OPT)

BAREBOX_MX6_IMAGES := images/barebox-embest-imx6s-riotboard.img \
	images/barebox-freescale-imx6dl-sabrelite.img \
	images/barebox-freescale-imx6q-sabrelite.img \
	images/barebox-boundarydevices-imx6q-nitrogen6x-1g.img \
	images/barebox-boundarydevices-imx6q-nitrogen6x-2g.img \
	images/barebox-boundarydevices-imx6qp-nitrogen6_max.img \
	images/barebox-udoo-neo.img

BAREBOX_MX6_IMAGES := $(addprefix $(BAREBOX_MX6_BUILD_DIR)/,$(BAREBOX_MX6_IMAGES))

ifdef PTXCONF_BAREBOX_MX6
$(BAREBOX_MX6_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-mx6'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-mx6.prepare: $(BAREBOX_MX6_CONFIG)
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX_MX6)
	@rm -f "$(BAREBOX_MX6_BUILD_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-mx6-defaultenv)" \
		"$(BAREBOX_MX6_BUILD_DIR)/.ptxdist-defaultenv"
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-mx6.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-mx6.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_MX6_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-mx6.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_MX6)
	@$(foreach image, $(BAREBOX_MX6_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-mx6_oldconfig barebox-mx6_menuconfig barebox-mx6_nconfig: $(STATEDIR)/barebox-mx6.extract
	@$(call world/kconfig, BAREBOX_MX6, $(subst barebox-mx6_,,$@))

# vim: syntax=make
