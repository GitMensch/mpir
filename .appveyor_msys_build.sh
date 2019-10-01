export PATH=/c/msys64/mingw$ABI/bin:/c/projects/mpir/bin/:$PATH
cd /c/projects/mpir

echo && echo build: ./autogen.sh
./autogen.sh

case "$LIBRARY" in
	"static") CONFIGURE_FLAGS="--enable-static --disable-shared";;
	"shared") CONFIGURE_FLAGS="--disable-static --enable-shared";;
esac
case "$FEATURE" in
	*GMP*) CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-gmpcompat"
		MODE="$MODE-gmp"
		;;
esac
case "$FEATURE" in
	*CXX*) CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-cxx"
		MODE="$MODE-cxx"
		;;
esac

echo && echo build: ./configure ABI=$ABI $CONFIGURE_FLAGS
./configure ABI=$ABI $CONFIGURE_FLAGS --prefix=/usr/local

echo && echo build: make
make
# should work but falsely requires texlive ?!?
#echo && echo build: DISTCHECK_CONFIGURE_FLAGS="ABI=$ABI $LIB" make distcheck
#DISTCHECK_CONFIGURE_FLAGS="ABI=$ABI $LIB" make distcheck
echo && echo build: make check
make check

echo && echo build: make dist
make dist

if test "x$FEATURE" != "x"; then
	echo && echo build: make install DESTDIR=$(pwd)/package
	make install DESTDIR=$(pwd)/package && cd package/usr/local && \
		zip -9 -r ../../../bin$ABI$MODE-$LIBRARY.zip *
fi
