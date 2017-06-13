Introduction
============

DistroKit is a Board Support Package (BSP) for the `PTXdist
<http://www.ptxdist.org>`_ build system. It assembles a small (but not
minimalistic) Embedded Linux system with modern components:

- barebox bootloader
- mainline kernel, as patch free as possible
- systemd based init
- NetworkManager for dbus based network configuration

It can be used as a base for further BSP development.

Installing the BSP
------------------

DistroKit is built with ptxdist. In order to install ptxdist,
`download the tarball <http://www.pengutronix.de/software/ptxdist/download/ptxdist-|ptxdistVendorVersion|.tar.bz2>`_
from the PTXdist Download Area.

Extract the tarball:

::

        $ tar xf ptxdist-|ptxdistVendorVersion|.tar.bz2 && cd ptxdist-|ptxdistVendorVersion|

Go to the extracted directory and run

::

        $ ./configure && make && sudo make install

Installing the Toolchain
------------------------

In order to build a BSP, you need a toolchain. The easiest way to get a
toolchain is to install the debian packages for OSELAS.Toolchain:

        `<http://www.pengutronix.de/oselas/toolchain/>`_

If you want to build the toolchain yourself, you can download the
toolchain sources from

        `<http://www.pengutronix.de/oselas/toolchain/download/>`_

and build them manually.

