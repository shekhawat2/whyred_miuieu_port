#!/usr/bin/env bash
export LOCALDIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
echo $LOCALDIR
export TOOLS=$LOCALDIR/tools
DEVICE=lavender
TYPE=eu
VERSIONS=(beta)
SDAT2IMG=$TOOLS/sdat2img.py
IMG2SDAT=$TOOLS/img2sdat.py
IMGEXTRACT=$TOOLS/imgextractor.py
MKUSERIMG=$TOOLS/mkuserimg_mke2fs.sh
OUTDIR=$LOCALDIR/out
INDIR=$LOCALDIR/in
date=`date +%Y%m%d%H%M%S`
for VERSION in ${VERSIONS[@]}; do
if [ "${TYPE}" = "global" ]; then
    python3 ${LOCALDIR}/${TYPE}.py ${DEVICE} ${VERSION}
    URL=$(cat ${LOCALDIR}/url)
    ZIPNAME=$(echo $URL | cut -d / -f 5)
    NEWZIP=$(sed "s/.zip/-$date.zip/g" <<< $(echo $(sed 's/LAVENDER/WHYRED/g' <<< $ZIPNAME)))
elif [ "${TYPE}" = "mmx" ]; then
    python3 ${LOCALDIR}/${TYPE}.py ${DEVICE} ${VERSION}
    URL=$(cat ${LOCALDIR}/url)
    ZIPNAME=$(echo $URL | cut -d / -f 9)
    NEWZIP=$(sed "s/.zip/-$date.zip/g" <<< $(echo $(sed 's/lavender/whyred/g' <<< $ZIPNAME)))
elif [ "${TYPE}" = "eu" ]; then
    python3 ${LOCALDIR}/${TYPE}.py ${DEVICE} ${VERSION}
    URL=https://mgb1.androidfilehost.com/dl/WiQ9ii9ndZhRH7MV4ZN3Hg/1604720194/10763459528675577935/xiaomi.eu_multi_HMNote7_20.11.5_v12-10.zip
    ZIPNAME=$(echo $URL | cut -d / -f 8)
    NEWZIP=$(sed "s/.zip/-$date.zip/g" <<< $(echo $(sed 's/HMNote7/HMNote5Pro/g' <<< $ZIPNAME)))
else
    echo "Specify TYPE"
fi
rm -rf ${LOCALDIR}/url
COMMITHASH=$(git log -1 --pretty=%H)
rm -rf ${INDIR} ${OUTDIR}
mkdir -p ${INDIR}
mkdir -p ${OUTDIR}

rm -rf $LOCALDIR/flashable/system.*
rm -rf $LOCALDIR/flashable/vendor.*

OLDZIPNAME=$(git describe)
EUDATE=$(echo $ZIPNAME | cut -d _ -f 4)
OLDEUDATE=$(echo $OLDZIPNAME | cut -d _ -f 4)

if [[ $(git cat-file -p $OLDZIPNAME | tail -n +6) == $COMMITHASH && $EUDATE == $OLDEUDATE ]]; then
    echo "$ZIPNAME already done!"
    exit 0
fi

git config --global user.email "anandsingh215@yahoo.com"
git config --global user.name "Anand Shekhawat"


# Download and Unzip
echo "Downloading $ZIPNAME"
aria2c -x16 -j$(nproc) -q -d "$INDIR" -o "$ZIPNAME" ${URL}
echo "Extracting $ZIPNAME to $INDIR"
unzip -o -d $INDIR $INDIR/$ZIPNAME > /dev/null

brotli -df $INDIR/system.new.dat.br
$SDAT2IMG $INDIR/system.transfer.list $INDIR/system.new.dat $INDIR/system.img > /dev/null
python3 $IMGEXTRACT $INDIR/system.img .

brotli -df $INDIR/vendor.new.dat.br
$SDAT2IMG $INDIR/vendor.transfer.list $INDIR/vendor.new.dat $INDIR/vendor.img > /dev/null
python3 $IMGEXTRACT $INDIR/vendor.img .

echo "Patching system and vendor"
rm $LOCALDIR/vendor/etc/init/android.hardware.gatekeeper@1.0-service-qti.rc
rm $LOCALDIR/vendor/etc/init/android.hardware.keymaster@4.0-service-qti.rc
# app
rm -rf $LOCALDIR/system/system/app/Email
rm -rf $LOCALDIR/system/system/app/MiuiVideoGlobal
rm -rf $LOCALDIR/system/system/app/MiPicks
rm -rf $LOCALDIR/system/system/app/InMipay
rm -rf $LOCALDIR/system/system/app/Updater
# priv-app
rm -rf $LOCALDIR/system/system/priv-app/Browser
rm -rf $LOCALDIR/system/system/priv-app/MiBrowserGlobal
rm -rf $LOCALDIR/system/system/priv-app/MiuiBrowserGlobal
rm -rf $LOCALDIR/system/system/priv-app/MiDrop
rm -rf $LOCALDIR/system/system/priv-app/MiuiCamera
rm -rf $LOCALDIR/system/system/priv-app/Updater
# data-app
rm -rf $LOCALDIR/system/system/data-app/PeelMiRemote
rm -rf $LOCALDIR/system/system/data-app/XMRemoteController
# product/app
rm -rf $LOCALDIR/system/system/product/app/YouTube
rm -rf $LOCALDIR/system/system/product/app/Maps
rm -rf $LOCALDIR/system/system/product/app/Gmail2
# vendor/overlay
rm -rf $LOCALDIR/vendor/app/NotchOverlay
rm -rf $LOCALDIR/vendor/overlay/DevicesOverlay.apk
rm -rf $LOCALDIR/vendor/overlay/DevicesAndroidOverlay.apk

rsync -ra $LOCALDIR/whyred/audio/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/camera/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/display/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/fingerprint/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/keymaster/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/sensors/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/thermal/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/wifi/vendor/ $LOCALDIR/vendor
rsync -ra $LOCALDIR/whyred/app/vendor/ $LOCALDIR/vendor

rsync -ra $LOCALDIR/whyred/app/system/ $LOCALDIR/system
rsync -ra $LOCALDIR/customizations/system/ $LOCALDIR/system

#fstab
sed -i "s/forceencrypt/encryptable/g" $LOCALDIR/vendor/etc/fstab.qcom
sed -i "/\/dev\/block\/bootdevice\/by-name\/system/d" $LOCALDIR/vendor/etc/fstab.qcom
sed -i "\/dev\/block\/bootdevice\/by-name\/userdata/a /dev/block/bootdevice/by-name/cust       /cust                  ext4   ro,nosuid,nodev,barrier=1                        wait,check" $LOCALDIR/vendor/etc/fstab.qcom

# manifest
sed -i "/<name>android.hardware.keymaster<\/name>/!b;n;n;c\ \ \ \ \ \ \  <version>3.0</version>" $LOCALDIR/vendor/etc/vintf/manifest.xml
sed -i "/<fqname>@4.0::IKeymasterDevice\/default<\/fqname>/!b;c\ \ \ \ \ \ \ \ <fqname>@3.0::IKeymasterDevice/default</fqname>" $LOCALDIR/vendor/etc/vintf/manifest.xml

# postboot
sed -i "s/start vendor.cdsprpcd/\# start vendor.cdsprpcd/g" $LOCALDIR/vendor/bin/init.qcom.post_boot.sh

# build.prop
sed -i "s/ro.product.vendor.name=lavender/ro.product.vendor.name=whyred/g" $LOCALDIR/vendor/build.prop
sed -i "s/ro.product.vendor.device=lavender/ro.product.vendor.device=whyred/g" $LOCALDIR/vendor/build.prop
sed -i "s/ro.product.vendor.model=Redmi Note 7/ro.product.vendor.model=Redmi Note 5/g" $LOCALDIR/vendor/build.prop
sed -i -e "/build.fingerprint_real/s/lavender/whyred/" $LOCALDIR/vendor/build.prop
sed -i -e "/build.fingerprint_real/s/lavender/whyred/" $LOCALDIR/vendor/build.prop

sed -i "s/ro.product.system.name=lavender/ro.product.system.name=whyred/g" $LOCALDIR/system/system/build.prop
sed -i "s/ro.product.system.device=lavender/ro.product.system.device=whyred/g" $LOCALDIR/system/system/build.prop
sed -i "s/ro.product.system.model=Redmi Note 7/ro.product.system.model=Redmi Note 5/g" $LOCALDIR/system/system/build.prop
sed -i "s/persist.vendor.camera.model=Redmi Note 7/persist.vendor.camera.model=Redmi Note 5/g" $LOCALDIR/system/system/build.prop
sed -i -e "/build.fingerprint_real/s/lavender/whyred/" $LOCALDIR/system/system/build.prop
sed -i -e "/build.fingerprint_real/s/lavender/whyred/" $LOCALDIR/system/system/build.prop

sed -i "s/ro.product.odm.name=lavender/ro.product.odm.name=whyred/g" $LOCALDIR/vendor/odm/etc/build.prop
sed -i "s/ro.product.odm.device=lavender/ro.product.odm.device=whyred/g" $LOCALDIR/vendor/odm/etc/build.prop
sed -i "s/ro.product.odm.model=Redmi Note 7/ro.product.odm.model=Redmi Note 5/g" $LOCALDIR/vendor/odm/etc/build.prop
sed -i -e "/build.fingerprint_real/s/lavender/whyred/" $LOCALDIR/vendor/odm/etc/build.prop
sed -i -e "/build.fingerprint_real/s/lavender/whyred/" $LOCALDIR/vendor/odm/etc/build.prop

sed -i "/ro.miui.notch=1/d" $LOCALDIR/system/system/build.prop
sed -i "s/sys.paper_mode_max_level=255/sys.paper_mode_max_level=400/g" $LOCALDIR/system/system/build.prop

cat $LOCALDIR/whyred/system.prop >> $LOCALDIR/system/system/build.prop
cat $LOCALDIR/whyred/vendor.prop >> $LOCALDIR/vendor/build.prop

# device_features
rm -rf $LOCALDIR/system/system/etc/device_features/lavender.xml
rm -rf $LOCALDIR/vendor/etc/device_features/lavender.xml

# Patch blobs
bash $LOCALDIR/whyred/patch/services_jar.sh

# vendor_file_contexts
echo "Patching file_contexts"
cat $LOCALDIR/whyred/app/config/system_file_contexts >> $LOCALDIR/config/system_file_contexts
cat $LOCALDIR/whyred/app/config/vendor_file_contexts >> $LOCALDIR/config/vendor_file_contexts
cat $LOCALDIR/whyred/audio/config/vendor_file_contexts >> $LOCALDIR/config/vendor_file_contexts
cat $LOCALDIR/whyred/camera/config/vendor_file_contexts >> $LOCALDIR/config/vendor_file_contexts
cat $LOCALDIR/whyred/display/config/vendor_file_contexts >> $LOCALDIR/config/vendor_file_contexts
cat $LOCALDIR/whyred/fingerprint/config/vendor_file_contexts >> $LOCALDIR/config/vendor_file_contexts
cat $LOCALDIR/whyred/keymaster/config/vendor_file_contexts >> $LOCALDIR/config/vendor_file_contexts

# vendor_fs_config
echo "Patching fs_config"
cat $LOCALDIR/whyred/app/config/system_fs_config >> $LOCALDIR/config/system_fs_config
cat $LOCALDIR/whyred/app/config/vendor_fs_config >> $LOCALDIR/config/vendor_fs_config
cat $LOCALDIR/whyred/audio/config/vendor_fs_config >> $LOCALDIR/config/vendor_fs_config
cat $LOCALDIR/whyred/camera/config/vendor_fs_config >> $LOCALDIR/config/vendor_fs_config
cat $LOCALDIR/whyred/display/config/vendor_fs_config >> $LOCALDIR/config/vendor_fs_config
cat $LOCALDIR/whyred/fingerprint/config/vendor_fs_config >> $LOCALDIR/config/vendor_fs_config
cat $LOCALDIR/whyred/keymaster/config/vendor_fs_config >> $LOCALDIR/config/vendor_fs_config

bytesToHuman() {
    b=${1:-0}; d=''; s=0; S=(Bytes {K,M,G,T,P,E,Z,Y}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        let s++
    done
    echo "$b$d ${S[$s]}"
}

# mk img
mk_img() {
vdir=$LOCALDIR/vendor
sdir=$LOCALDIR/system
ssize=3221225472
vsize=2147483648
pvsize=`du -sk $vdir | awk '{$1*=1024;$1=int($1*1.05);printf $1}'`
pssize=`du -sk $sdir | awk '{$1*=1024;$1=int($1*1.05);printf $1}'`
sout=$OUTDIR/system.img
vout=$OUTDIR/vendor.img
vfsconfig=$LOCALDIR/config/vendor_fs_config
sfsconfig=$LOCALDIR/config/system_fs_config
vfcontexts=$LOCALDIR/config/vendor_file_contexts
sfcontexts=$LOCALDIR/config/system_file_contexts

echo "Creating system.img"
echo "system.img size: $(bytesToHuman $pssize)"
$MKUSERIMG -s "$sdir" "$sout" ext4 system $ssize -C $sfsconfig $sfcontexts -T 0  -L system > /dev/null || exit 1

echo "Creating vendor.img"
echo "vendor.img size: $(bytesToHuman $pvsize)"
$MKUSERIMG -s "$vdir" "$vout" ext4 vendor $vsize -C $vfsconfig $vfcontexts -T 0  -L vendor > /dev/null || exit 1

rm -rf $LOCALDIR/config
rm -rf $LOCALDIR/system
rm -rf $LOCALDIR/vendor
}

mk_zip() {
    echo "Creating $NEWZIP"
    $IMG2SDAT $vout -o flashable -v 4 -p vendor > /dev/null
    $IMG2SDAT $sout -o flashable -v 4 -p system > /dev/null
    cd flashable

    echo "Compressing system.new.dat"
    brotli -7 system.new.dat
    echo "Conpressing vendor.new.dat"
    brotli -7 vendor.new.dat

    rm system.new.dat || exit 1
    rm vendor.new.dat || exit 1

    rm -rf ../$NEWZIP
    zip -rv9 ../$NEWZIP *
    cd ..
}

urlencode() {
    echo "$*" | sed 's:%:%25:g;s: :%20:g;s:<:%3C:g;s:>:%3E:g;s:#:%23:g;s:{:%7B:g;s:}:%7D:g;s:|:%7C:g;s:\\:%5C:g;s:\^:%5E:g;s:~:%7E:g;s:\[:%5B:g;s:\]:%5D:g;s:`:%60:g;s:;:%3B:g;s:/:%2F:g;s:?:%3F:g;s^:^%3A^g;s:@:%40:g;s:=:%3D:g;s:&:%26:g;s:\$:%24:g;s:\!:%21:g;s:\*:%2A:g'
}

tg_send() {
    if [[ -z ${BOT_TOKEN} ]]; then
        echo "tg_msg() was called but there was no token!"
        return 1
    fi

    if [[ -z ${CHAT_ID} ]]; then
        echo "tg_msg() was called but there was no chat ID!"
        return 1
    fi

    BOTURL="https://api.telegram.org/bot$BOT_TOKEN/sendMessage"
    TEXT="$1"
    until [ $(echo -n "$TEXT" | wc -m) -eq 0 ]; do
    res=$(curl -s "$BOTURL" -d "chat_id=$CHAT_ID" -d "text=$(urlencode "${TEXT:0:4096}")" -d "parse_mode=Markdown" -d "disable_web_page_preview=true")
    TEXT="${TEXT:4096}"
    done
}

sf_upload() {
/usr/bin/expect << EOD
spawn scp ${2} shekhawat2@frs.sourceforge.net:/home/frs/project/${1}
expect "Password:"
send ${SSHPASS}\n;
interact
EOD
}

mk_img || continue
mk_zip

rm -rf $INDIR $OUTDIR

if [ -f $LOCALDIR/$NEWZIP ]; then
    git remote add up https://${GH_TOKEN}@github.com/shekhawat2/whyred_miuieu_port.git
    git tag $NEWZIP -m $COMMITHASH
    git push up --tags

    ssh-keyscan -t ecdsa -p 22 -H frs.sourceforge.net 2>&1 | tee -a /root/.ssh/known_hosts
    SF_PROJECT=whyred-miui
#    sf_upload ${SF_PROJECT} ${NEWZIP}
    sshpass -e scp ${NEWZIP} shekhawat2@frs.sourceforge.net:/home/frs/project/${SF_PROJECT}/${TYPE}/${VERSION}
    NEWURL="https://sourceforge.net/projects/${SF_PROJECT}/files/${TYPE}/${VERSION}/${NEWZIP}/download"
    zsize=`du -sk $NEWZIP | awk '{$1*=1024;$1=int($1*1.05);printf $1}'`
    printf "[$NEWZIP]($NEWURL)\n" > "$LOCALDIR/info.txt"
    printf "Size: $(bytesToHuman $zsize)" >> "$LOCALDIR/info.txt"
    tg_send "$(cat $LOCALDIR/info.txt)"
else
    exit 0
fi
done
