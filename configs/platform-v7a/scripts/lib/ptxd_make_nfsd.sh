#!/bin/bash
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_nfsd_exec() {
    local port
    local client_specifications
    local root="/$(basename "${ptx_nfsroot}")"
    local base="$(dirname "${ptx_nfsroot}")"

    if ! port="$(ptxd_get_kconfig "${PTXDIST_BOARDSETUP}" "PTXCONF_BOARDSETUP_NFSPORT")"; then
	port=2049
    fi

    if ! client_specifications="$(ptxd_get_kconfig "${PTXDIST_BOARDSETUP}" "PTXCONF_BOARDSETUP_NFSROOT_CLIENT_SPECIFICATIONS")"; then
	client_specifications="(rw,no_root_squash)"
    fi

    echo
    echo "Mount rootfs with nfsroot=${root},v3,tcp,port=${port},mountport=${port}"
    echo

    #insecure for qemu with -net user
    client_specifications="${client_specifications%)},insecure)"
    echo "/ ${client_specifications}" > "${PTXDIST_TEMPDIR}/exports" &&
    UNFS_BASE="${base}" unfsd -e "${PTXDIST_TEMPDIR}/exports" -n ${port} -m ${port} -p -d "${@}"
}
export -f ptxd_make_nfsd_exec

