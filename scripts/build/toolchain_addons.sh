CT_TOOLCHAIN_ADDONS_FACILITY_LIST=
for f in "${CT_LIB_DIR}/scripts/build/toolchain_addons/"*.sh; do
    _f="$(basename "${f}" .sh)"
    _f="${_f#???-}"
    __f="CT_TOOLCHAIN_ADDONS_${_f}"
    if [ "${!__f}" = "y" ]; then
        CT_DoLog DEBUG "Enabling addon '${_f}'"
        . "${f}"
        CT_TOOLCHAIN_ADDONS_FACILITY_LIST="${CT_TOOLCHAIN_ADDONS_FACILITY_LIST} ${_f}"
    else
        CT_DoLog DEBUG "Disabling addon '${_f}'"
    fi
done

do_toolchain_addons_get() {
    for f in ${CT_TOOLCHAIN_ADDONS_FACILITY_LIST}; do
        do_toolchain_addons_${f}_get
    done
}

do_toolchain_addons_extract() {
    for f in ${CT_TOOLCHAIN_ADDONS_FACILITY_LIST}; do
        do_toolchain_addons_${f}_extract
    done
}

do_toolchain_addons() {
    for f in ${CT_TOOLCHAIN_ADDONS_FACILITY_LIST}; do
        do_toolchain_addons_${f}_build
    done
}

