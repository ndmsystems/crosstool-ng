# Build script for node

CT_NODE_VERSION=v4.4.3

do_toolchain_addons_node_get() {
    CT_GetFile "node-${CT_NODE_VERSION}"    \
        https://nodejs.org/dist/${CT_NODE_VERSION}
}

do_toolchain_addons_node_extract() {
    CT_Extract "node-${CT_NODE_VERSION}"
    CT_Patch "node" "${CT_NODE_VERSION}"
}

do_toolchain_addons_node_build() {
    CT_DoStep EXTRA "Installing node"
    local -a extra_config

    if [ "${CT_STATIC_TOOLCHAIN}" = "y" ]; then
        extra_config+=("--fully-static")
    fi

    CT_DoLog EXTRA "Copying sources to build dir"
    CT_DoExecLog ALL cp -av "${CT_SRC_DIR}/node-${CT_NODE_VERSION}" \
                            "${CT_BUILD_DIR}/build-node"
    CT_Pushd "${CT_BUILD_DIR}/build-node"

    CT_DoExecLog CFG            \
    ./configure                 \
    --prefix="${CT_PREFIX_DIR}" \
    "${extra_config[@]}"

    CT_DoExecLog ALL ${make} ${JOBSFLAGS}
    CT_DoExecLog ALL ${make} install
    CT_Popd
    CT_EndStep
}
