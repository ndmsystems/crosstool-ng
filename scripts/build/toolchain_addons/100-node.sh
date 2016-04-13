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

    CT_DoLog EXTRA "Copying sources to build dir"
    CT_DoExecLog ALL cp -av "${CT_SRC_DIR}/node-${CT_NODE_VERSION}" \
                            "${CT_BUILD_DIR}/build-node"
    CT_Pushd "${CT_BUILD_DIR}/build-node"

    CT_DoExecLog CFG ./configure --prefix="${CT_PREFIX_DIR}"

    CT_DoExecLog ALL ${make} ${JOBSFLAGS} LDFLAGS=-static
    CT_DoExecLog ALL ${make} install
    CT_Popd
    CT_EndStep
}
