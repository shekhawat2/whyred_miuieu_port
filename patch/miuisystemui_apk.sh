#!/usr/bin/env bash
BAKSMALIJAR=$TOOLS/baksmali.jar
SMALIJAR=$TOOLS/smali.jar
TMPDIR=${PATCHDIR}/temp/miuisystemui_apk
mkdir -p "$TMPDIR/original_dex"
PATCHFILE="$LOCALDIR/system/system/priv-app/MiuiSystemUI/MiuiSystemUI.apk"

echo "Patching MiuiSystemUI.apk"
7z e "$PATCHFILE" classes.dex -o"$TMPDIR/original_dex" > /dev/null

java -jar "$BAKSMALIJAR" disassemble --debug-info false "$TMPDIR/original_dex/classes.dex" -o "$TMPDIR/dexout1"

bash ${PATCHDIR}/miuisystemui_apk/patch/miuisystemui_apk_1

java -jar "$SMALIJAR" assemble "$TMPDIR/dexout1" -o "$TMPDIR/classes.dex"

zip -gjq "$PATCHFILE" "$TMPDIR/classes.dex"
rm -rf "$TMPDIR"
