# -*-makefile-*-
#
# Copyright (C) 2013 by Jan Luebbe <j.luebbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_USB_GADGET) += usb-gadget

USB_GADGET_VERSION	:= 1.0
USB_GADGET		:= usb-gadget-$(USB_GADGET_VERSION)
USB_GADGET_URL		:= file://$(PTXDIST_WORKSPACE)/local_src/usb-gadget
USB_GADGET_DIR		:= $(BUILDDIR)/$(USB_GADGET)


# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/usb-gadget.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usb-gadget.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usb-gadget.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usb-gadget)
	@$(call install_fixup,usb-gadget,PRIORITY,optional)
	@$(call install_fixup,usb-gadget,SECTION,base)
	@$(call install_fixup,usb-gadget,AUTHOR,"Jan Luebbe <j.luebbe@pengutronix.de>")
	@$(call install_fixup,usb-gadget,DESCRIPTION,missing)

	@$(call install_copy, usb-gadget, 0, 0, 0644, \
		$(USB_GADGET_DIR)/usb-cdc-gadget.service, \
		/lib/systemd/system/usb-cdc-gadget.service)
	@$(call install_link, usb-gadget, ../usb-cdc-gadget.service, \
		/lib/systemd/system/multi-user.target.wants/usb-cdc-gadget.service)
	@$(call install_copy, usb-gadget, 0, 0, 0644, \
		$(USB_GADGET_DIR)/usb-ifupdown@.service, \
		/lib/systemd/system/usb-ifupdown@.service)

	@$(call install_copy, usb-gadget, 0, 0, 0644, \
		$(USB_GADGET_DIR)/98-usb-gadget.rules, \
		/lib/udev/rules.d/98-usb-gadget.rules)

	@if [ -e $(KERNEL_DIR)/Documentation/usb/linux.inf ]; then \
		install -D -m644 $(KERNEL_DIR)/Documentation/usb/linux.inf $(IMAGEDIR)/linux.inf; \
	fi

	@$(call install_finish,usb-gadget)

	@$(call touch)

# vim: syntax=make
