RIoT-Board
================

Boot Media
----------
Use the image ``platform-v7a/images/riotboard.hdimg`` and write it to your SD card.

Set the DIP switches (SW1) accordingly to boot from a full-size SD card (J6
on the bottom) or a Micro SD card (J7 on top):

+-------------------+-----+-----+-----+-----+-----+-----+-----+-----+
| Switch            | D1  | D2  | D3  | D4  | D5  | D6  | D7  | D8  |
+===================+=====+=====+=====+=====+=====+=====+=====+=====+
| Full-size SD (J6) | On  | Off | On  | Off | Off | On  | Off | On  |
+-------------------+-----+-----+-----+-----+-----+-----+-----+-----+
| Micro SD (J7)     | On  | Off | On  | Off | Off | On  | On  | Off |
+-------------------+-----+-----+-----+-----+-----+-----+-----+-----+

Serial Console
--------------
The serial boot console is available at the debug-header J18 at 115200 Baud and 8N1 with the following pinout:

* J18.1: TxD
* J18.2: RxD
* J18.3: GND

Fast development
----------------

For development the RIoT-Board bootloader supports 'fastboot'. Refer
:ref:`fast_development` for Linux and BSP preparation on demand.

RIoT i.MX6S
~~~~~~~~~~~

The BSP already supports 'fastboot' and prepares the target accordingly.
The PARTITION names might differ, so you should check first, what PARTITIONs
are exported.

To get the exported PARTITION names, available via 'fastboot', you can run::

   $ fastboot getvar all
   (bootloader) version: 0.4
   (bootloader) bootloader-version: barebox-2023.02.1
   (bootloader) max-download-size: 8388608
   (bootloader) partition-size:mmc1: 00000000
   (bootloader) partition-type:mmc1: unavailable
   (bootloader) partition-size:mmc2: 00000000
   (bootloader) partition-type:mmc2: unavailable
   (bootloader) partition-size:mmc3: e5000000
   (bootloader) partition-type:mmc3: basic
   (bootloader) partition-size:ram-kernel: 00000000
   (bootloader) partition-type:ram-kernel: file
   (bootloader) partition-size:ram-initramfs: 00000000
   (bootloader) partition-type:ram-initramfs: file
   (bootloader) partition-size:ram-oftree: 00000000
   (bootloader) partition-type:ram-oftree: file
   (bootloader) partition-size:bbu-emmc: 000e0000
   (bootloader) partition-type:bbu-emmc: basic

In this example, the PARTITION names are 'mmc1', 'mmc2', 'mmc3', 'ram-kernel',
'ram-initramfs', 'ram-oftree' and 'bbu-emmc'. In this example the two possible
SD cards are not plugged in (e.g. "unavailable").

.. note:: You need to restart the fastboot usbgadget, if you probe the SD cards
          later on.

Just connect the USB OTG connector to your host and run::

   $ fastboot flash ram-kernel platform-v7a/images/linuximage -S 1
   $ fastboot flash ram-oftree platform-v7a/images/imx6dl-riotboard.dtb -S 1
   $ fastboot flash ram-initramfs platform-v7a/images/root.cpio.gz -S 1
   $ fastboot oem exec -- boot ram-fastboot

You can populate local memory like the eMMC as well. But only full memory
devices and no particular partitions.

If inserted, the regular SD card::

   $ fastboot flash mmc1 platform-v7a/images/riotboard.hdimg -S 1

If inserted, the µSD card::

   $ fastboot flash mmc2 platform-v7a/images/riotboard.hdimg -S 1

The built-in eMMC::

   $ fastboot flash mmc3 platform-v7a/images/riotboard.hdimg -S 1

.. note:: If you have no USB connection to the RIoT i.MX6S, you can use
          a network connection instead. Just run all the 'fastboot' commands
          shown above with the additional option '-s udp:<RIoT i.MX6S IP address>'.
