# -*-makefile-*-
#
# Copyright (C) 2017 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_AM335X) += barebox-am335x

#
# Paths and names
#
BAREBOX_AM335X_VERSION	:= 2019.01.0
BAREBOX_AM335X_MD5	:= 51fae9592ee453535b9b21ffdd50f775
BAREBOX_AM335X		:= barebox-$(BAREBOX_AM335X_VERSION)
BAREBOX_AM335X_SUFFIX	:= tar.bz2
BAREBOX_AM335X_DIR	:= $(BUILDDIR)/barebox-am335x-$(BAREBOX_AM335X_VERSION)
BAREBOX_AM335X_CONFIG	:= $(call ptx/in-platformconfigdir, barebox-am335x.config)
BAREBOX_AM335X_LICENSE	:= GPL-2.0
BAREBOX_AM335X_URL	:= $(call barebox-url, BAREBOX_AM335X)
BAREBOX_AM335X_SOURCE	:= $(SRCDIR)/$(BAREBOX_AM335X).$(BAREBOX_AM335X_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_AM335X_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

BAREBOX_AM335X_CONF_ENV := KCONFIG_NOTIMESTAMP=1
BAREBOX_AM335X_CONF_OPT := $(call barebox-opts, BAREBOX_AM335X)

BAREBOX_AM335X_MAKE_ENV := $(BAREBOX_AM335X_CONF_ENV)
BAREBOX_AM335X_MAKE_OPT := $(BAREBOX_AM335X_CONF_OPT)

BAREBOX_AM335X_IMAGES := images/barebox-am33xx-afi-gf.img \
			images/barebox-am33xx-beaglebone.img
BAREBOX_AM335X_IMAGES := $(addprefix $(BAREBOX_AM335X_DIR)/,$(BAREBOX_AM335X_IMAGES))

ifdef PTXCONF_BAREBOX_AM335X
$(BAREBOX_AM335X_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo " Please generate a bareboxconfig with 'ptxdist menuconfig barebox-am335x'"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox-am335x.prepare: $(BAREBOX_AM335X_CONFIG)
	@$(call targetinfo)
	@rm -f "$(BAREBOX_AM335X_DIR)/.ptxdist-defaultenv"
	@ln -s "$(call ptx/in-platformconfigdir, barebox-am335x-defaultenv)" \
		"$(BAREBOX_AM335X_DIR)/.ptxdist-defaultenv"
	@$(call world/prepare, BAREBOX_AM335X)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Targetinstall
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x.targetinstall:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_AM335X_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image));)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-am335x.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_AM335X)
	@$(foreach image, $(BAREBOX_AM335X_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))-am335x;)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-am335x_oldconfig barebox-am335x_menuconfig barebox-am335x_nconfig: $(STATEDIR)/barebox-am335x.extract
	@$(call world/kconfig, BAREBOX_AM335X, $(subst barebox-am335x_,,$@))

# vim: syntax=make
