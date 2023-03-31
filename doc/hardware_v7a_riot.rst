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

