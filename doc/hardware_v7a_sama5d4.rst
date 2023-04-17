SAMA5D4 boards
==============

DistroKit currently supports one SAMA5D4 board:

 * Wifx L1 LoRaWAN Gateway


Boot Media
----------

The L1 will boot from a bootable SD-Card if one is inserted and otherwise
fall back to booting from NAND flash. DistroKit generates only a SD-Card
image for now:

 * ``platform-v7a/images/wifx-l1-sd.hdimg``.
