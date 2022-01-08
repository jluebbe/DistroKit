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

DistroKit supports multiple hardware platforms, see chapter
:ref:`hardware-platforms` for more information about them.


Quick Start
-----------

The next sections below describe briefly how to build the BSP from scratch,
but for more in-depth documentation, refer to the `PTXdist manual
<https://www.ptxdist.org/doc/>`_ (or the later chapters if you're reading this
documentation in the HTML or the PDF version).

If you already have a working environment, you can skip to the section about the
individual :ref:`hardware-platforms` for more information on how to build
images, how to flash an image to a board, or how to get a serial console.

Installing PTXdist
~~~~~~~~~~~~~~~~~~

DistroKit is built with PTXdist version |ptxdistVendorVersion|.  In order to
install PTXdist,
`download the tarball <http://www.pengutronix.de/software/ptxdist/download/ptxdist-|ptxdistVendorVersion|.tar.bz2>`_
from the PTXdist Download Area.

Extract the tarball:

::

        $ tar xf ptxdist-|ptxdistVendorVersion|.tar.bz2 && cd ptxdist-|ptxdistVendorVersion|

Go to the extracted directory and run

::

        $ ./configure && make && sudo make install

Installing the Toolchain
~~~~~~~~~~~~~~~~~~~~~~~~

In order to build a BSP for a different architecture than your host system,
you need a toolchain.
DistroKit is configured for the OSELAS.Toolchain |oselasTCNVendorVersion|.
Depending on the platform you want to build, different toolchains are necessary –
see the sections about the :ref:`hardware-platforms`.

Pre-built Debian packages of the toolchains are available from Pengutronix,
but you can also build the toolchain from source.
See the `OSELAS.Toolchain homepage <https://www.pengutronix.de/de/software/toolchain.html>`_
for more information.


Contributing
------------

The canonical source repository for DistroKit is at
<https://git.pengutronix.de/cgit/DistroKit/>.

For any questions regarding DistroKit, send a mail to the mailing list at
<distrokit@pengutronix.de>.
Note that posts from non-subscribed addresses will be held for moderation.
We recommend that you subscribe to the list by sending a mail to
<distrokit-request@pengutronix.de> containing "subscribe" in the subject.

The same list should also be used to send patches.
The easiest way to format your patch into the canonical patch format is by
using `git format-patch <https://git-scm.com/docs/git-format-patch>`_ on the
DistroKit git repository
(also see its man page for info on using mailers other than *git send-email*).

Mails sent to the DistoKit mailing list are archived on ``lore.distrokit.org``.
Patch series can be fetched with `b4 <https://pypi.org/project/b4/>`_ ::

   git config b4.midmask https://lore.distrokit.org/%s
   git config b4.linkmask https://lore.distrokit.org/%s
   b4 am https://lore.distrokit.org/$messageid # replace with link

DistroKit uses the `Developer’s Certificate of Origin <https://developercertificate.org/>`_::

   By making a contribution to this project, I certify that:

   a) The contribution was created in whole or in part by me and I have the
      right to submit it under the open source license indicated in the file; or
   b) The contribution is based upon previous work that, to the best of my
      knowledge, is covered under an appropriate open source license and I have
      the right under that license to submit that work with modifications, whether
      created in whole or in part by me, under the same open source license
      (unless I am permitted to submit under a different license), as indicated in
      the file; or
   c) The contribution was provided directly to me by some other person who
      certified (a), (b) or (c) and I have not modified it.
   d) I understand and agree that this project and the contribution are public
      and that a record of the contribution (including all personal information I
      submit with it, including my sign-off) is maintained indefinitely and may be
      redistributed consistent with this project or the open source license(s)
      involved.

If you can certify the above, then you just add a line saying::

   Signed-off-by: Random J Developer <random@developer.example.org>

using your real name (sorry, no pseudonyms or anonymous contributions)
to the end of your commit message,
or if you use Git, make your commit with ``git commit --signoff``.

License
-------

Copyright (C) 2020 Pengutronix and individual contributors

DistroKit is licensed under the GNU General Public License, version 2.0.
See the file named LICENSE in the root directory of this project for the full
license terms, and the version control history for contributor information.
