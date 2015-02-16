### PYOPENSSL ###
_build_pyopenssl() {
local VERSION="0.13"
local FOLDER="pyOpenSSL-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="https://pypi.python.org/packages/source/p/pyOpenSSL/${FILE}"
local XPYTHON=~/xtools/python2/${DROBO}

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
sed -i -e "s|from distutils.core import Extension, setup|from setuptools import setup\nfrom distutils.core import Extension|g" setup.py
_PYTHON_HOST_PLATFORM="linux-armv7l" LDSHARED="${CC} -shared -Wl,-rpath,/mnt/DroboFS/Share/DroboApps/python2/lib -L${DEST}/lib-5n" "${XPYTHON}/bin/python" setup.py build_ext --include-dirs="${XPYTHON}/include-${DROBO}" --library-dirs="${XPYTHON}/lib-${DROBO}" --force build --force bdist_egg --dist-dir ../..
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
