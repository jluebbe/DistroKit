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
PACKAGES-$(PTXCONF_BAREBOX_AM335X_MLO) += barebox-am335x-mlo

#
# Paths and names
#
BAREBOX_AM335X_MLO_VERSION	:= $(call ptx/config-version, PTXCONF_BAREBOX_COMMON)
BAREBOX_AM335X_MLO_MD5		:= $(call ptx/config-md5, PTXCONF_BAREBOX_COMMON)
BAREBOX_AM335X_MLO		:= barebox-am335x-mlo-$(BAREBOX_AM335X_MLO_VERSION)
BAREBOX_AM335X_MLO_SUFFIX	:= tar.bz2
BAREBOX_AM335X_MLO_URL		:= $(call barebox-url, BAREBOX_AM335X_MLO)
BAREBOX_AM335X_MLO_PATCHES	:= barebox-$(BAREBOX_AM335X_MLO_VERSION)
BAREBOX_AM335X_MLO_SOURCE	:= $(SRCDIR)/$(BAREBOX_AM335X_MLO_PATCHES).$(BAREBOX_AM335X_MLO_SUFFIX)
BAREBOX_AM335X_MLO_DIR		:= $(BUILDDIR)/$(BAREBOX_AM335X_MLO)
BAREBOX_AM335X_MLO_BUILD_DIR	:= $(BAREBOX_AM335X_MLO_DIR)-build
BAREBOX_AM335X_MLO_CONFIG	:= $(call ptx/in-platformconfigdir, barebox-am335x-mlo.config)
BAREBOX_AM335X_MLO_LICENSE	:= GPL-2.0-only
BAREBOX_AM335X_MLO_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_AM335X_MLO_PATH := PATH=$(HOST_PATH)

BAREBOX_AM335X_MLO_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_AM335X_MLO_CONF_OPT := \
	-C $(BAREBOX_AM335X_MLO_DIR) \
	O=$(BAREBOX_AM335X_MLO_BUILD_DIR) \
	BUILDSYSTEM_VERSION=$(PTXDIST_VCS_VERSION) \
	$(call barebox-opts, BAREBOX_AM335X_MLO)

BAREBOX_AM335X_MLO_MAKE_OPT := $(BAREBOX_AM335X_MLO_CONF_OPT)

BAREBOX_AM335X_MLO_IMAGES := images/barebox-am33xx-afi-gf-mlo.img \
			images/barebox-am33xx-beaglebone-mlo.img
BAREBOX_AM335X_MLO_IMAGES := $(addprefix $(BAREBOX_AM335X_MLO_BUILD_DIR)/,$(BAREBOX_AM335X_MLO_IMAGES))

ifdef PTXCONF_BAREBOX_AM335X_MLO
$(BAREBOX_AM335X_MLO_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-am335x-mlo'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x-mlo.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x-mlo.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_AM335X_MLO_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x-mlo.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_AM335X_MLO)
	@$(foreach image, $(BAREBOX_AM335X_MLO_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))$(ptx/nl))

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-am335x-mlo_oldconfig barebox-am335x-mlo_menuconfig barebox-am335x-mlo_nconfig: $(STATEDIR)/barebox-am335x-mlo.extract
	@$(call world/kconfig, BAREBOX_AM335X_MLO, $(subst barebox-am335x-mlo_,,$@))

# vim: syntax=make
