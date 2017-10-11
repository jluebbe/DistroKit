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
PACKAGES-$(PTXCONF_BAREBOX_MX6) += barebox-mx6

#
# Paths and names
#
BAREBOX_MX6_VERSION	:= 2017.10.0
BAREBOX_MX6_MD5		:= cae141fd919810397a7d539959d75aae
BAREBOX_MX6		:= barebox-$(BAREBOX_MX6_VERSION)
BAREBOX_MX6_SUFFIX	:= tar.bz2
BAREBOX_MX6_DIR		:= $(BUILDDIR)/barebox-mx6-$(BAREBOX_MX6_VERSION)
BAREBOX_MX6_CONFIG	:= $(PTXDIST_PLATFORMCONFIGDIR)/barebox-mx6.config
BAREBOX_MX6_LICENSE	:= GPL-2.0
BAREBOX_MX6_URL		:= $(call barebox-url, BAREBOX_MX6)
BAREBOX_MX6_SOURCE	:= $(SRCDIR)/$(BAREBOX_MX6).$(BAREBOX_MX6_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_MX6_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG

BAREBOX_MX6_CONF_ENV := KCONFIG_NOTIMESTAMP=1
BAREBOX_MX6_CONF_OPT := $(call barebox-opts, BAREBOX_MX6)

BAREBOX_MX6_MAKE_ENV := $(BAREBOX_MX6_CONF_ENV)
BAREBOX_MX6_MAKE_OPT := $(BAREBOX_MX6_CONF_OPT)

BAREBOX_MX6_IMAGES := images/barebox-embest-imx6s-riotboard.img \
	images/barebox-freescale-imx6dl-sabrelite.img \
	images/barebox-freescale-imx6q-sabrelite.img \
	images/barebox-udoo-neo.img

BAREBOX_MX6_IMAGES := $(addprefix $(BAREBOX_MX6_DIR)/,$(BAREBOX_MX6_IMAGES))

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

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

BAREBOX_MX6_INSTALL_OPT := \
	$(call barebox-opts, BAREBOX_MX6)

$(STATEDIR)/barebox-mx6.install:
	@$(call targetinfo)
	@$(foreach image, $(BAREBOX_MX6_IMAGES), \
		install -m 644 \
			$(image) $(IMAGEDIR)/$(notdir $(image));)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-mx6.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_MX6)
	@$(foreach image, $(BAREBOX_MX6_IMAGES), \
		rm -fv $(IMAGEDIR)/$(notdir $(image))-mx6;)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox-mx6_oldconfig barebox-mx6_menuconfig barebox-mx6_nconfig: $(STATEDIR)/barebox-mx6.extract
	@$(call world/kconfig, BAREBOX_MX6, $(subst barebox-mx6_,,$@))

# vim: syntax=make
