Marvell espressobin
===================

Boot Media
----------
Use the image ``platform-v8a/images/espressobin.hdimg`` and write it to your MicroSD-Card, e.g:

.. code-block:: shell

    dd if=platform-v8a/images/espressobin.hdimg of=/dev/mmcblk0

As barebox doesn't support the espressobin yet and also U-Boot isn't built
here, it is relied on the U-Boot shipped on the board for now.

Serial Console
--------------
The serial boot console is available via the micro USB connector via a PL2303
on the board. Use it with 115200n8.
