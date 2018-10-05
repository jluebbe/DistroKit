#!/bin/bash
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# workaround for ptxdist-2018.10.0: override this function to the old
# variant from ptxdist-2018.09.0, as it is currently broken.
#

export -fn ptxd_install_replace_figlet

ptxd_install_replace_figlet() {
    local dst="$1"
    local placeholder="$2"
    local value="$3"
    local escapemode="$4"
    local -a dirs ndirs pdirs sdirs ddirs
    local mod_nfs mod_rw

    ptxd_install_setup &&
    echo "\
install replace figlet:
  file=${dst}
  '${placeholder}' -> '\`figlet ${value}\`'
" &&

    ptxd_exist "${dirs[@]/%/${dst}}" &&
    ptxd_figlet_helper() {
        local value="$1"
        local escapemode="$2"
        figlet -d "${PTXDIST_SYSROOT_HOST}/share/figlet" -- "${value}" | \
        case "$escapemode" in
            # /etc/issue needs each backslash quoted by another backslash. As
            # the string is interpreted by the shell once more below, another
            # level of quoting is needed such that every \ in the output of
            # figlet needs to be replaced by \\\\. As a \ in sed needs to be
            # quoted, too, this results in eight backslashes in the replacement
            # string.
            etcissue)	sed 's,\\,\\\\\\\\,g';;
            *)		;;
        esac | \
        awk '{ if ($0 !~ "^ *$") printf("%s\\n", $0) }'  # newlines for sed
    } &&
    figlet="$(ptxd_figlet_helper "$value" "$escapemode")" &&
    sed -i -e "s#${placeholder}#${figlet}#g" "${dirs[@]/%/${dst}}" ||

    ptxd_install_error "install_replace failed!"
}

export -f ptxd_install_replace_figlet

