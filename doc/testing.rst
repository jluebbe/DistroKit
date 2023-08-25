.. _fast_development:

Fast development
================

Sometimes a quick test should be done: a new kernel feature or a tool
should be tested on a real target.

If the target suports USB OTG (or peripheral mode) or network, 'fastboot'
can be an easy-to-use solution.

'fastboot' support
------------------

For a fast development or testing cycle you can use 'fastboot' via
USB or network to transfer the required parts to the target system.

Here we want to run a Linux kernel and a corresponding root filesystem,
without writing target system local memories again and again for each
development or test cycle.

In this test, we transfer the required files to the target system
which only needs to run a 'fastboot' capable bootloader.

Since we want to use an initramfs as the kernel's root filesystem, we
have some requirements to the target system's free memory. The bootloader
keeps up to 512 MiB of memory to add files to its own RAM disk. The
512 MiB is valid for a physical memory size of 1 GiB and above. With less
physical memory it is always 50 % of the available physical memory.
Keep an eye on the size of the initramfs file if it fits onto the
bootloader's RAM disk. Reduce its size on demand.

Note: the 50 % rule is only valid for the time the bootloader runs. After
      starting the Linux kernel, 100 % of the physical memory is available.

Some settings are required to make it work smoothly.

Linux kernel
------------

- CONFIG_BLK_DEV_INITRD=y

And one of the supported decompressors:

- CONFIG_RD_GZIP

Note: the required decompressor depends on the used compression method for the
      initramfs selected in the BSP. See below.

Bootloader
----------

The 'bootm' command must support initrd/initramfs:

- CONFIG_BOOTM_INITRD = y

If your target system has an OTG connector, you should enable 'fastboot' on
the gadget interface:

- CONFIG_USB_GADGET = y
- CONFIG_USB_GADGET_FASTBOOT = y
- CONFIG_CMD_USBGADGET = y

If you want to use 'fastboot' via network instead (or in addition) to the
USB interface, you should enable this channel as well:

- CONFIG_NET_FASTBOOT = y

Since we want to transfer large initrd/initramfs files, 'fastboot' requires
'sparse' feature support:

- CONFIG_FASTBOOT_SPARSE = y

And we want run the downloaded files, so we need:

- CONFIG_FASTBOOT_CMD_OEM = y

BSP
---

Create an initramf of the root filesystem:

- PTXCONF_IMAGE_ROOT_CPIO = y

You need to select a compression method for the initramfs file in relation to
the selected decompression support in the Linux kernel. See notes above.

- PTXCONF_IMAGE_ROOT_CPIO_COMPRESSION_MODE_GZ = y

The generic behaviour changes when the Linux kernel starts an initrd/initramfs
and it tries to start '/init' instead of an init processes in subdirectories.
If you can change the kernel's command line, you can restore the generic behaviour
by adding 'rdinit=/sbin/init'. If not, you can create a softlink at '/init' pointing
to '/sbin/init via:

- PTXCONF_ROOTFS_INIT_LINK

Optimisation
------------

Some BPS settings do not make sense regarding used in an initramfs instead
of a persistent target system local memory. For development or testing some
settings should be changed, to reduce the file sizes and boot time.

The Linux kernel will be transferred separately, so it makes less sense to
have it in the root filesystem as well. This will reduce the size of the
initramfs.

- PTXCONF_KERNEL_INSTALL = n

Some 'rc-once' jobs are useless in an initramfs and only increase the
boot time again and again:

- PTXCONF_GLIBC_LDCONFIG_RC_ONCE = n
- PTXCONF_MACHINE_ID_RC_ONCE = n

If possible, disable the whole rc-once step:

- PTXCONF_RC_ONCE = n

If you don't need ssh, you can disable its key generation as well:

- PTXCONF_OPENSSH_SSHD_GENKEYS = n

Preparations
------------

'fastboot' requires to divide large files into smaller chunks, if their
size hits some threshold. In this case, there are some additional requirements
to the size of the file itself: its size must be a multiple of 4 kiB.

Note: if this additional requirement isn't met, the error message is
      misleading and states about an 'invalid value' after the first
      transfer.

Most of the time the initramfs file hits the threshold. Thus, it must
be 4 kiB aligned::

   dd if=<platform-dir>/images/root.cpio.gz of=cpio.gz conv=sync bs=4096

Target
------

Enable the 'fastboot' feature on the target system::

   usbgadget -a -A /kernel(kernel)c,/devicetree(devicetree)c,/initrd(initrd)c

Host
----

Download the three parts into the target system::

   fastboot -i 7531 flash kernel <platform-dir>/images/linuximage
   fastboot -i 7531 flash devicetree <platform-dir>/images/<devicetree>
   fastboot -i 7531 flash initrd cpio.gz

If you have no '/init' in your root filesystem, you need to define the
init executable to be run by the Linux kernel::

   fastboot -i 7531 oem exec 'global linux.bootargs.ramfs=rdinit=/sbin/init'

In the final step, just start the already downloaded files::

   fastboot -i 7531 oem exec -- bootm -o /devicetree -r /initrd /kernel

