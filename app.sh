### PYOPENSSL ###
_build_pyopenssl() {
local VERSION="0.15.1"
local FOLDER="pyOpenSSL-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="https://pypi.python.org/packages/source/p/pyOpenSSL/${FILE}"
local XPYTHON="${HOME}/xtools/python2/${DROBO}"
local BASE="${PWD}"
export QEMU_LD_PREFIX="${TOOLCHAIN}/${HOST}/libc"
export _PYTHON_HOST_PLATFORM="linux-armv5tejl"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
LDSHARED="${CC} -shared -Wl,-rpath,/mnt/DroboFS/Share/DroboApps/python2/lib -L${XPYTHON}/lib" \
  "${XPYTHON}/bin/python" setup.py build_ext \
  --include-dirs="${XPYTHON}/include" --library-dirs="${XPYTHON}/lib" \
  --force build --force bdist_egg --dist-dir "${BASE}"
popd
}

### BUILD ###
_build() {
  _build_pyopenssl
}

_clean() {
  rm -v -fr *.egg
  rm -vfr "${DEPS}"
  rm -vfr "${DEST}"
  rm -v -fr target/*
}
