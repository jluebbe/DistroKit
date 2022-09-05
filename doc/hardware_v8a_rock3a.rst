Radxa Rock 3 Model A
====================

Boot Media
----------

Copy the image ``platform-v8a/images/rock3a.img`` onto a microSD card. Put the
microSD card into the Rock 3A and boot it.

Alternatively, you may put the Rock 3A into MASKROM mode following the `Rock 3
Hardware User Manual <https://wiki.radxa.com/Rock3/hardware/3a>`_ and boot
Barebox via USB:

.. code-block:: shell

    platform-v8a/sysroot-host/bin/rk-usb-loader platform-v8a/images/barebox-rock3a.img-rockchip

Once Barebox is booted, copy the image ``platform-v8a/images/rock3a.img`` via
tftp or NFS to the eMMC to persist it. Disable MASKROM mode and reboot the
board to start from eMMC.

Serial Console
--------------

The serial boot console is available via the pin
header of the board. Follow the `Rock 3 Development Guide
<https://wiki.radxa.com/Rock3/dev/serial-console>`_ for connecting an USB to
TTL serial cable. Make sure the cable support 1.5 Mbps.
