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
