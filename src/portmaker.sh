#! /bin/sh
# portmaker

VERSION=@VERSION@

CURDIR=`pwd`
LIBDIR=@PREFIX@/lib/portmaker-${VERSION}
TMPLDIR=@PREFIX@/share/portmaker-${VERSION}

. ${LIBDIR}/mingwPORT.functions

ask "PACKAGE" "" PACKAGE \?
ask "VERSION" "" VERSION \?
ask "ARCHIVETYPE" "tar.gz" ARCHIVETYPE \?
ask "ARCHIVEFILE" "$PACKAGE-$VERSION.$ARCHIVETYPE" ARCHIVEFILE \?
ask "ARCHIVEHOME" "http://www.${PACKAGE}.org" ARCHIVEHOME \?
ask "ARCHIVEPATH" "/tmp" ARCHIVEPATH \?
ask "DOWNLOADURI" "http://ftp.gnu.org/gnu/$PACKAGE" DOWNLOADURI \?
ask "SRCDIR" "\$HOME/src/${PACKAGE}-${VERSION}" SRCDIR \?
ask "BUILDDIR" "./bld" BUILDDIR \?
ask "PREFIX" "/mingw" PREFIX \?
ask "CFLAGS" "-O3 -s -mms-bitfields -march=\\\`uname -m\\\`" CFLAGS \?
ask "CXXFLAGS" "\\\$CFLAGS" CXXFLAGS \?

eval PORTPATH=\"${SRCDIR}/mingwPORT\"
ask "PORTPATH" "$PORTPATH" PORTPATH \?

[ -d "$PORTPATH" ] || mkdir -p "$PORTPATH"
cat <<EOD>$PORTPATH/mingwPORT.ini
PACKAGE=$PACKAGE
VERSION=$VERSION
ARCHIVETYPE=$ARCHIVETYPE
ARCHIVEFILE=$ARCHIVEFILE
ARCHIVEPATH=$ARCHIVEPATH
ARCHIVEHOME=$ARCHIVEHOME
DOWNLOADURI=$DOWNLOADURI
SRCDIR=$SRCDIR
BUILDDIR=$BUILDDIR
PREFIX=$PREFIX
CFLAGS="$CFLAGS"
CXXFLAGS="$CXXFLAGS"
EOD
cat ${TMPLDIR}/mingwPORT.README | sed -e "s@\[PACKAGEFILE\]@${ARCHIVEFILE}@" -e "s@\[PACKAGEHOME\]@${ARCHIVEHOME}@" > $PORTPATH/mingwPORT.README
cp ${TMPLDIR}/mingwPORT.help $PORTPATH
cp ${TMPLDIR}/mingwPORT.messages $PORTPATH
cp ${TMPLDIR}/mingwPORT.getopts $PORTPATH
cp ${TMPLDIR}/mingwPORT.question $PORTPATH
cp ${TMPLDIR}/mingwPORT.afterquestion $PORTPATH
cp ${TMPLDIR}/mingwPORT.configure $PORTPATH
cp ${TMPLDIR}/mingwPORT.make $PORTPATH
cp ${TMPLDIR}/mingwPORT.install $PORTPATH
cp ${TMPLDIR}/mingwPORT.cleanup $PORTPATH
cp ${TMPLDIR}/mingwPORT.sh $PORTPATH
cp ${LIBDIR}/mingwPORT.functions $PORTPATH
cp ${TMPLDIR}/mingwPORT.exports $PORTPATH
cp ${TMPLDIR}/mirrors.sf $PORTPATH
