#!/usr/bin/env bash
TMPDIR=$LOCALDIR/temp/services_jar
BAKSMALIJAR=$TOOLS/baksmali.jar
SMALIJAR=$TOOLS/smali.jar

mkdir -p "$TMPDIR/original_dex"
7z e "$LOCALDIR/system/system/framework/services.jar" classes.dex -o"$TMPDIR/original_dex" > /dev/null
java -jar "$BAKSMALIJAR" disassemble "$TMPDIR/original_dex/classes.dex" -o "$TMPDIR/dexout"

files=($TMPDIR/dexout/com/android/server/lights/LightsService.smali \
       $TMPDIR/dexout/com/android/server/audio/AudioService.smali \
       $TMPDIR/dexout/com/android/server/DisplayFeatureControl.smali)
for file in ${files[@]}; do
    sed -i "s/whyred//g" $file
    sed -i "s/lavender/whyred/g" $file
done

java -jar "$SMALIJAR" assemble "$TMPDIR/dexout" -o "$TMPDIR/classes.dex"
zip -gjq "$LOCALDIR/system/system/framework/services.jar" "$TMPDIR/classes.dex"
rm -rf "$TMPDIR"
