#!/bin/sh

if [ -z "$PTXDIST" ]; then
	PTXDIST=ptxdist
else
	tput setaf 3 # yellow
	echo Note: using PTXDIST=$PTXDIST
	tput sgr 0   # back to normal
fi

BAREBOXES="barebox-common barebox-am335x barebox-mx6 barebox-rpi2 barebox-vexpress"
for pkg in $BAREBOXES; do
	$PTXDIST --platformconfig="configs/platform-v7a/platformconfig" oldconfig $pkg
done
