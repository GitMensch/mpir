export PATH=/c/msys64/mingw$ABI/bin:/c/projects/mpir/bin/:$PATH
cd /c/projects/mpir
echo && echo build: ./autogen.sh
./autogen.sh
case "$LIBRARY" in
	"static") LIB="--enable-static --disable-shared";;
	"shared") LIB="--disable-static --enable-shared";;
esac
echo && echo build: ./configure ABI=$ABI $LIB $CONFIG_CXX $CONFIG_GMP
./configure ABI=$ABI $LIB $CONFIG_CXX $CONFIG_GMP
echo && echo build: make
make
# should work but falsely requires texlive ?!?
#echo && echo build: DISTCHECK_CONFIGURE_FLAGS="ABI=$ABI $LIB" make distcheck
#DISTCHECK_CONFIGURE_FLAGS="ABI=$ABI $LIB" make distcheck
echo && echo build: make check
make check
echo && echo build: make dist
make dist
if ! test -z "$CONFIG_GMP"; then
	if ! test -z "$CONFIG_CXX"; then
		MODE="C++"
	else
		MODE=""
	fi
	make install DESTDIR=$(pwd)/bin$ABI$MODE-$LIBRARY
fi
