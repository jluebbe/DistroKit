QEmu
====

The mipsel platform is ready to run in qemu, using the MIPS Malta board
simulation.
There are two ways to run DistroKit inside qemu:

* With barebox:
  Run ``./configs/platform-mipsel/run barebox`` to barebox. The barebox should
  boot the kernel if supported.
* Without barebox:
  Run ``./configs/platform-mipsel/run`` to directly start the kernel without
  barebox.
