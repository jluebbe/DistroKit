Raspberry Pi 2
==============

Boot Media
----------
Use the same ``platform-v7a/images/rpi.hdimg`` image and write it to your MicroSD-Card.

Serial Console
--------------
The serial boot console is available at J8 (the GPIO header) with 115200 Baud and 8N1 on the following Pins:

* J8.6: GND
* J8.8: Tx
* J8.10: Rx

Raspberry Pi 3
==============

Boot Media
----------
Use the same ``platform-v7a/images/rpi.hdimg`` image and write it to your MicroSD-Card.

Serial Console
--------------
The serial boot console is available at J8 (the GPIO header) with 115200 Baud and 8N1 on the following pins:

* J8.6: GND
* J8.8: Tx
* J8.10: Rx

Raspberry Pi Compute Module 3+
==============================

Boot Media
----------
Use the same ``platform-v7a/images/rpi.hdimg`` image and write it to your MicroSD-Card.

If you have a hardware with eMMC the uSD slot is not functional, in this case
you have to use `usbboot <https://github.com/raspberrypi/usbboot>`_ to switch
the hardware into USB mass storage mode. See their documentation and
`"Flashing the Compute Module eMMC" at raspberrypi.org
<https://www.raspberrypi.org/documentation/hardware/computemodule/cm-emmc-flashing.md>`
for details.

Serial Console
--------------
The serial boot console is available at the GPIOx BANK0 header (J5) on the following pins with the Compute Module IO Board V3.0:

* GPIO14: TX
* GPIO15: RX

For GND there are several labeled pins available on J5.
