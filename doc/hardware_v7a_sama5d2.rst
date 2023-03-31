SAMA5D2 boards
==============

DistroKit supports two SAMA5D27 boards out of the box:

 * SAMA5D27-SOM1-EK
 * Groboards Giant Board

Boot Media
----------

DistroKit generates ``platform-v7a/images/sama5d27-*.hdimg``.
Use the respective image for your board and write it to your SD card.
The Giant board has only 1 microSD slot, the EK has additionally
1 normal SD-sized slot. Both can be used.

Serial Console
--------------

The EK has an on-board USB-serial adapter interfaced to J10. This is the
default console and power supply. Default UART on the Giant board are the
Pins marked as Tx/Rx. The microUSB on the board can be used as power
supply, but it has no serial port there by default.
