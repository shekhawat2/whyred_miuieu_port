#!/usr/bin/env bash
export LOCALDIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
export ARCH=$(uname -m)
export TOOLS=${LOCALDIR}/tools
export SDAT2IMG=${TOOLS}/sdat2img.py
export IMG2SDAT=${TOOLS}/img2sdat.py
export IMGEXTRACTOR=${TOOLS}/imgextractor.py
export MKUSERIMG=${TOOLS}/mkuserimg_mke2fs.sh
export IMG2SIMG=${TOOLS}/${ARCH}/img2simg
export APKTOOL=${TOOLS}/apktool
export SYSTEMDIR=${LOCALDIR}/system
export VENDORDIR=${LOCALDIR}/vendor
export OUTDIR=${LOCALDIR}/out
export INDIR=${LOCALDIR}/in
export fframeworkres="${SYSTEMDIR}/system/framework/framework-res.apk"
export fframeworkextres="${SYSTEMDIR}/system/framework/framework-ext-res/framework-ext-res.apk"
export fmiuisystem="${SYSTEMDIR}/system/app/miuisystem/miuisystem.apk"
export fmiui="${SYSTEMDIR}/system/app/miui/miui.apk"
date=`date +%Y%m%d%H%M%S`
ZIPPATH="$2"

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,P,E,Z,Y}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        let s++
    done
    echo "$b$d ${S[$s]}"
}

extract() {
partitions=(system)
rm -rf config
for partition in ${partitions[@]}; do
rm -rf ${partition}
7z e "${ZIPPATH}" ${partition}.new.dat.br ${partition}.transfer.list -o"$INDIR"
brotli -df ${INDIR}/${partition}.new.dat.br
rm -rf ${INDIR}/${partition}.new.dat.br
$SDAT2IMG ${INDIR}/${partition}.transfer.list ${INDIR}/${partition}.new.dat ${INDIR}/${partition}.img > /dev/null
rm -rf ${INDIR}/${partition}.transfer.list ${INDIR}/${partition}.new.dat
$IMGEXTRACTOR ${INDIR}/${partition}.img .
rm -rf ${INDIR}/${partition}.img
done
}

mk_img() {
size=3221225472
mbsize=$((${size} / 1024 / 1024))
fsize=$(du -sh ${SYSTEMDIR} | awk '{$1*=1024;printf $1}')
tmpout=${OUTDIR}/systemp.img
out=${OUTDIR}/system.img
mkdir -p ${OUTDIR}
fsconfig=${LOCALDIR}/config/system_fs_config
fcontexts=${LOCALDIR}/config/system_file_contexts
echo "Creating system.img $mbsize MB"
echo "system.img size: $fsize MB"
diff=$(bc <<< $mbsize-$fsize | sed 's/-//g')
if [ $mbsize > $fsize ]; then
echo "Free System $diff MB"
elif [ $mbsize < $fsize ]; then
echo "Free up more $diff MB"
fi
$MKUSERIMG "${SYSTEMDIR}" "$tmpout" ext4 system $size -C $fsconfig $fcontexts -T 0 -L system > /dev/null
$IMG2SIMG $tmpout $out
rm -rf $tmpout
}

usage() {
	echo "port.sh extract <zip path>"
	echo "or"
	echo "port.sh mkimg"
}

if [ "${1}" == extract ]; then
echo "Extracting"
extract
elif [ "${1}" == mkimg ]; then
mk_img
else
usage
fi