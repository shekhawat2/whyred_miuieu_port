#!/usr/bin/env bash
BAKSMALIJAR=$TOOLS/baksmali.jar
SMALIJAR=$TOOLS/smali.jar
TMPDIR=${PATCHDIR}/temp/services_jar
mkdir -p "$TMPDIR/original_dex"

7z e "$LOCALDIR/system/system/framework/services.jar" classes.dex classes2.dex -o"$TMPDIR/original_dex" > /dev/null

java -jar "$BAKSMALIJAR" disassemble --debug-info false "$TMPDIR/original_dex/classes.dex" -o "$TMPDIR/dexout1"
java -jar "$BAKSMALIJAR" disassemble --debug-info false "$TMPDIR/original_dex/classes2.dex" -o "$TMPDIR/dexout2"

rsync -ra ${PATCHDIR}/services_jar/replace/ $TMPDIR
patch -p1 -N -r - -d $TMPDIR < ${PATCHDIR}/services_jar/patch/services_jar_1.patch

java -jar "$SMALIJAR" assemble "$TMPDIR/dexout1" -o "$TMPDIR/classes.dex"
java -jar "$SMALIJAR" assemble "$TMPDIR/dexout2" -o "$TMPDIR/classes2.dex"
zip -gjq "$LOCALDIR/system/system/framework/services.jar" "$TMPDIR/classes.dex" "$TMPDIR/classes2.dex"
rm -rf "$TMPDIR"
