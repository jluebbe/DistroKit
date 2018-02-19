Boundary Devices Nitrogen6X
===========================

Bootloader
----------

Use one of the following Barebox images that fits your hardware:

  * ``../platform-v7a/images/barebox-boundarydevices-imx6q-nitrogen6x-1g.img`` (Nitrogen6X board with 1 GB of RAM)
  * ``../platform-v7a/images/barebox-boundarydevices-imx6q-nitrogen6x-2g.img`` (Nitrogen6X board with 2 GB of RAM)

Boot Media
----------
Use the generic userland image ``platform-v7a/images/hd.img`` and write it onto your microSD card.

Serial Console
--------------
The serial boot console is available via the COM1/COM2 connector J17 at 115200 Baud and 8N1. The pinout is:

* J17.3: GND
* J17.4: TxD
* J17.5: RxD
