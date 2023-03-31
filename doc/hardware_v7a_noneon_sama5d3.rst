SAMA5D3 boards
==============

Supported boards:

 * EVB-KSZ9477 (with ATSAMA5D36A)
   Image: platform-v7a_noneon/images/image-ksz9477-evb.hdimg

Boot Media
----------

DistroKit generates ``platform-v7a_noneon/images/*.hdimg``.
Use the respective image for your board and write it to your SD card.

The EVB-KSZ9477 board has only 1 SD slot. To boot from SD, J13 (NAND Enable)
jumper should be removed.

Serial Console
--------------

The EVB-KSZ9477 has an J10 Serial Comm interface. All UART related pins are
properly named.
