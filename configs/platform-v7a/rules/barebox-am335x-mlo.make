# -*-makefile-*-
#
# Copyright (C) 2017 by Sascha Hauer <s.hauer@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
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
BAREBOX_AM335X_MLO_VERSION	:= 2018.01.0
BAREBOX_AM335X_MLO_MD5		:= 37577d9941295d4d38b8dfa334e5d8a9
BAREBOX_AM335X_MLO		:= barebox-$(BAREBOX_AM335X_MLO_VERSION)
BAREBOX_AM335X_MLO_SUFFIX	:= tar.bz2
BAREBOX_AM335X_MLO_DIR		:= $(BUILDDIR)/barebox-am335x-mlo-$(BAREBOX_AM335X_MLO_VERSION)
BAREBOX_AM335X_MLO_CONFIG	:= $(PTXDIST_PLATFORMCONFIGDIR)/barebox-am335x-mlo.config
BAREBOX_AM335X_MLO_LICENSE	:= GPL-2.0
BAREBOX_AM335X_MLO_URL		:= $(call barebox-url, BAREBOX_AM335X_MLO)
BAREBOX_AM335X_MLO_SOURCE	:= $(SRCDIR)/$(BAREBOX_AM335X_MLO).$(BAREBOX_AM335X_MLO_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_AM335X_MLO_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

BAREBOX_AM335X_MLO_CONF_ENV := KCONFIG_NOTIMESTAMP=1
BAREBOX_AM335X_MLO_CONF_OPT := $(call barebox-opts, BAREBOX_AM335X_MLO)

BAREBOX_AM335X_MLO_MAKE_ENV := $(BAREBOX_AM335X_MLO_CONF_ENV)
BAREBOX_AM335X_MLO_MAKE_OPT := $(BAREBOX_AM335X_MLO_CONF_OPT)

BAREBOX_AM335X_MLO_IMAGES := images/barebox-am33xx-afi-gf-mlo.img \
			images/barebox-am33xx-beaglebone-mlo.img
BAREBOX_AM335X_MLO_IMAGES := $(addprefix $(BAREBOX_AM335X_MLO_DIR)/,$(BAREBOX_AM335X_MLO_IMAGES))

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

$(STATEDIR)/barebox-am335x-mlo.prepare: $(BAREBOX_AM335X_MLO_CONFIG)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x-mlo.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Targetinstall
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x-mlo.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_AM335X_MLO_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image));)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x-mlo.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_AM335X_MLO)
	@$(foreach image, $(BAREBOX_AM335X_MLO_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))-am335x-mlo;)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-am335x-mlo_oldconfig barebox-am335x-mlo_menuconfig barebox-am335x-mlo_nconfig: $(STATEDIR)/barebox-am335x-mlo.extract
	@$(call world/kconfig, BAREBOX_AM335X_MLO, $(subst barebox-am335x-mlo_,,$@))

# vim: syntax=make
