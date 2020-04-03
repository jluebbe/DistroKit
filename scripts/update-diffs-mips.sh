#!/bin/sh

if [ -z "$PTXDIST" ]; then
	PTXDIST=ptxdist
else
	tput setaf 3 # yellow
	echo Note: using PTXDIST=$PTXDIST
	tput sgr 0   # back to normal
fi

PACKAGES="barebox-common barebox-ar9331 barebox-malta kernel kernel-ar9331 kernel-malta"
for pkg in $PACKAGES; do
	$PTXDIST --platformconfig="configs/platform-mips/platformconfig" oldconfig $pkg
done
