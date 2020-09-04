.. _hardware-platforms:

Hardware Platforms
==================

DistroKit supports a range of hardware, supported by the ptxdist
platforms listed below. A platform can be built with one ``ptxdist
images`` and shares the same cross compiler and binary format.

To build a platform, choose the respective platformconfig, e.g.::

   $ ptxdist platform configs/platform-v7a/platformconfig
   info: selected platformconfig:
        'configs/platform-v7a/platformconfig'

If the respective toolchain for the platform is installed from the Debian packages
or tarballs, PTXdist is able to find and select the right toolchain automatically.
Otherwise, select your toolchain by giving its path manually, e.g. with::

   $ ptxdist toolchain /opt/OSELAS.Toolchain-2020.08.0/x86_64-unknown-linux-gnu/gcc-10.2.1-clang-10.0.1-glibc-2.32-binutils-2.35-kernel-5.8-sanitized/bin
   found and using toolchain:
   '/opt/OSELAS.Toolchain-2020.08.0/x86_64-unknown-linux-gnu/gcc-10.2.1-clang-10.0.1-glibc-2.32-binutils-2.35-kernel-5.8-sanitized/bin/'

Then you can build all images with::

   $ ptxdist images


v7a Platform
------------

+-------------------------+-----------------------------------------+
| platformconfig:         | ``configs/platform-v7a/platformconfig`` |
+-------------------------+-----------------------------------------+
| Toolchain architecture: | ``arm-v7a-linux-gnueabihf``             |
+-------------------------+-----------------------------------------+

The v7a platform is made for machines based on the ARMv7-A architecture.
It supports the following hardware:

.. toctree::
   :maxdepth: 1

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

+-------------------------+-----------------------------------------+
| platformconfig:         | ``configs/platform-v8a/platformconfig`` |
+-------------------------+-----------------------------------------+
| Toolchain architecture: | ``aarch64-v8a-linux-gnu``               |
+-------------------------+-----------------------------------------+

The v8a platform targets the ARMv8-A architecture.

The stuff from the v7a section above applies here accordingly.

Currently DistroKit only supports a single board; the Marvell espressobin:

.. toctree::
   :maxdepth: 1

   hardware_v8a_espressobin


rpi Platform
------------

+-------------------------+-----------------------------------------+
| platformconfig:         | ``configs/platform-rpi/platformconfig`` |
+-------------------------+-----------------------------------------+
| Toolchain architecture: | ``arm-1136jfs-linux-gnueabihf``         |
+-------------------------+-----------------------------------------+

.. note::

  The rpi platform is currently not actively maintained,
  as RPi 1 has been superseded by newer models
  which are supported in the v7a platform.
  However, if you are targeting a RPi 1,
  we will be happy to merge your patches anyways.

The rpi platform has support for the Raspberry Pi 1, which is based on
the Broadcom BCM2835 SoC (ARMv6):

.. toctree::
   :maxdepth: 1

   hardware_rpi_raspi1


mips Platform
-------------

+-------------------------+------------------------------------------+
| platformconfig:         | ``configs/platform-mips/platformconfig`` |
+-------------------------+------------------------------------------+
| Toolchain architecture: | ``mips-softfloat-linux-gnu``             |
+-------------------------+------------------------------------------+

.. toctree::
   :maxdepth: 1

   hardware_x86_64_qemu


x86_64 Platform
---------------

+-------------------------+--------------------------------------------+
| platformconfig:         | ``configs/platform-x86_64/platformconfig`` |
+-------------------------+--------------------------------------------+
| Toolchain architecture: | ``x86_64-unknown-linux-gnu``               |
+-------------------------+--------------------------------------------+

.. toctree::
   :maxdepth: 1

   hardware_mips_qemu
