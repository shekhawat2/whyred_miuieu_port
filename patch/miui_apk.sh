#!/usr/bin/env bash
TMPDIR=$LOCALDIR/temp/miui_apk

mkdir ${TMPDIR}
$APKTOOL d -f -s -o ${TMPDIR} ${fmiui}

cat > ${TMPDIR}/res/xml/default_auto_install.xml << EOF
<?xml version="1.0" encoding="utf-8"?>
<install>
</install>
EOF

$APKTOOL b ${TMPDIR}
java -jar ${TOOLS}/signapk/signapk.jar ${TOOLS}/keys/platform.x509.pem ${TOOLS}/keys/platform.pk8 "${TMPDIR}/dist/miui.apk" "${fmiui}"

rm -rf "${TMPDIR}"
