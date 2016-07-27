# -*-makefile-*-
#
# Copyright (C) 2016 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MOSQUITTO) += mosquitto

#
# Paths and names
#
MOSQUITTO_VERSION	:= 1.4.9
MOSQUITTO_MD5		:= 67943e2c5afebf7329628616eb2c41c5
MOSQUITTO		:= mosquitto-$(MOSQUITTO_VERSION)
MOSQUITTO_SUFFIX	:= tar.gz
MOSQUITTO_URL		:= http://mosquitto.org/files/source/$(MOSQUITTO).$(MOSQUITTO_SUFFIX)
MOSQUITTO_SOURCE	:= $(SRCDIR)/$(MOSQUITTO).$(MOSQUITTO_SUFFIX)
MOSQUITTO_DIR		:= $(BUILDDIR)/$(MOSQUITTO)

# This is dual licensed under the EPL-1.0 and EDL-1.0, which is a BSD-3-Clause according to
# http://spdx-legal.spdx.narkive.com/wmb1FKZ8/new-license-request
MOSQUITTO_LICENSE	:= EPL-1.0, BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MOSQUITTO_CONF_TOOL	:= cmake
MOSQUITTO_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DWITH_TLS:BOOL=ON \
	-DWITH_TLS_PSK:BOOL=OFF \
	-DWITH_EC:BOOL=OFF \
	-DWITH_SOCKS:BOOL=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mosquitto.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mosquitto)
	@$(call install_fixup, mosquitto,PRIORITY,optional)
	@$(call install_fixup, mosquitto,SECTION,base)
	@$(call install_fixup, mosquitto,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mosquitto,DESCRIPTION,missing)

	@$(call install_lib, mosquitto, 0, 0, 0644, libmosquitto)
	#@$(call install_lib, mosquitto, 0, 0, 0644, libmosquittopp)

ifdef PTXCONF_MOSQUITTO_SERVER	
	@$(call install_copy, mosquitto, 0, 0, 0755, -, /usr/sbin/mosquitto)
endif
ifdef PTXCONF_MOSQUITTO_PASSWD
	@$(call install_copy, mosquitto, 0, 0, 0755, -, /usr/bin/mosquitto_passwd)
endif
ifdef PTXCONF_MOSQUITTO_PUB
	@$(call install_copy, mosquitto, 0, 0, 0755, -, /usr/bin/mosquitto_pub)
endif
ifdef PTXCONF_MOSQUITTO_SUB
	@$(call install_copy, mosquitto, 0, 0, 0755, -, /usr/bin/mosquitto_sub)
endif
	@$(call install_finish, mosquitto)

	@$(call touch)

# vim: syntax=make
