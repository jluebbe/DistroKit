Hardware Platforms
==================

DistroKit supports a range of hardware, supported by the ptxdist
platforms listed below. A platform can be built with one ``ptxdist
images`` and shares the same cross compiler and binary format.


v7a Platform
------------

The v7a platform is made for machines based on the ARMv7a architecture.
Select the platform with

::

	$ ptxdist platform configs/platform-v7a/platformconfig
	info: selected platformconfig:
	      'configs/platform-v7a/platformconfig'

To use the platform, the arm-v7a-linux-gnueabihf toolchain needs to be
installed; if installed from the debian packages or tarballs, ptxdist
is able to find and select the right toolchain with

::

	$ ptxdist toolchain
	found and using toolchain:
	'/opt/OSELAS.Toolchain-2016.06.1/arm-v7a-linux-gnueabihf/gcc-5.4.0-glibc-2.23-binutils-2.26-kernel-4.6-sanitized/bin'

Now everything is prepared to build the platform with

::

	$ ptxdist images

Hardware for the v7a Platform
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

DistroKit supports various boards based on the ARMv7-A architecture.
For the following boards there is separate documentation:

.. toctree::

   hardware_v7a_qemu
   hardware_v7a_beaglebone_white
   hardware_v7a_beaglebone_black
   hardware_v7a_nitrogen6x
   hardware_v7a_riot
   hardware_v7a_raspi2
   hardware_v7a_raspi3
   hardware_v7a_udoo_neo

If you want to get DistroKit running on your ARMv7-A board which is not
listed above, here is a short overview of the generic way:

1. Build the device tree for your board by adding its DTS source file to the
   variable ``PTXCONF_DTC_OFTREE_DTS`` (in ``ptxdist menuconfig platform`` →
   *Build device tree* → *source dts file*).
   The compiled device tree will appear in ``platform-v7a/images/`` after the
   build.

2. Build a bootloader for your board.
   If the hardware is very similar to one of the provided *barebox* packages,
   you can simply adapt their config (``ptxdist menuconfig barebox-TARGET``)
   and the respective rules in ``configs/platform-v7a/rules/barebox-*.make``.
   If your hardware is too different, you can create a new bootloader package
   with ``ptxdist newpackage barebox``.

   Bootloader images can also be found in ``platform-v7a/images/`` after the
   PTXdist build.
   You can use these images to populate your board with a bootloader, for
   example with imx-usb-loader, fastboot, or the tool of choice for your
   respective SoC.

3. Adapt the kernel configuration to include support for your board with
   ``ptxdist menuconfig kernel``.
   After the build, you will find the kernel zImage in
   ``platform-v7a/images/linuximage``.

4. The userland for ARMv7-A is built to ``platform-v7a/images/root.{ext2,tgz}``.
   You can simply use these images too populate your boot media, or boot from
   NFS instead (see section :ref:`nfsroot`).

5. If you want to build a separate hdimage for your board, for example to boot
   barebox and the kernel from an SD card, create a new image package with
   ``ptxdist newpackage image-genimage`` (or fork one of the existing packages
   in ``configs/platform-v7a/``).

6. Send patches to <distrokit@pengutronix.de> :)

Refer to the :ref:`ptx_dev_manual` for a more thorough documentation.

v8a Platform
------------

The stuff from the v7a section above applies here accordingly.

Hardware for the v8a Platform
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Currently DistroKit only supports a single board; the Marvell espressobin.

.. toctree::

   hardware_v8a_espressobin

rpi Platform
------------

.. note::

  The rpi platform is currently not actively maintained,
  as RPi 1 has been superseded by newer models
  which are supported in the v7a platform.
  However, if you are targeting a RPi 1,
  we will be happy to merge your patches anyways.

The rpi platform has support for the Raspberry Pi 1, which is based on
the Broadcom BCM2835 SoC (ARMv6). Select the platform with

::

	$ ptxdist platform configs/platform-rpi/platformconfig
	info: selected platformconfig:
	      'configs/platform-rpi/platformconfig'

You'll need the arm-1136jfs-linux-gnueabihf toolchain installed on your
system. If installed through the Pengutronix Debian or tarball
packages, ptxdist will pick it up automatically in this step.

::

	$ ptxdist toolchain
	found and using toolchain:
	'/opt/OSELAS.Toolchain-2014.12.2/arm-1136jfs-linux-gnueabihf/gcc-4.9.2-glibc-2.20-binutils-2.24-kernel-3.16-sanitized/bin/'

Now everything is prepared to build the platform with

::

	$ ptxdist images

Hardware for the rpi Platform
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::

   hardware_rpi_raspi1
