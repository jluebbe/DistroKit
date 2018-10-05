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
            # a lot of leaning toothpicks because we need to escape a literal
            # '\' with '\\' on multiple levels:
            # - one level for the string inside awk: \\\\\\\\\\\\\\\\ -> \\\\\\\\
            # - one level for the shell string after sed -e:          -> \\\\
            # - one level for the s expression inside sed:            -> \\
            # - and finally, one level for /etc/issue:                -> \
            etcissue)	awk '{ gsub("\\\\", "\\\\\\\\\\\\\\\\"); print }' ;;
            *)		;;
        esac | \
        awk '{ if ($0 !~ "^ *$") printf("%s\\n", $0) }'  # newlines for sed
    } &&
    figlet="$(ptxd_figlet_helper "$value" "$escapemode")" &&
    sed -i -e "s#${placeholder}#${figlet}#g" "${dirs[@]/%/${dst}}" ||

    ptxd_install_error "install_replace failed!"
}
export -f ptxd_install_replace_figlet

