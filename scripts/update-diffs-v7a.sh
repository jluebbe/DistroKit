#!/bin/sh

BAREBOXES="barebox-common barebox-am335x barebox-mx6 barebox-rpi2 barebox-vexpress"
for pkg in $BAREBOXES; do
	ptxdist oldconfig $pkg
done
