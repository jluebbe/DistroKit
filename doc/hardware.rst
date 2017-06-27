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
-----------------------------

.. toctree::

   hardware_v7a_qemu
   hardware_v7a_beaglebone_white
   hardware_v7a_beaglebone_black
   hardware_v7a_riot
   hardware_v7a_raspi2
   hardware_v7a_raspi3
