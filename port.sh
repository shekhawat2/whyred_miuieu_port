#!/usr/bin/env bash
export LOCALDIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
export TOOLS=${LOCALDIR}/tools
export PATCHDIR=${LOCALDIR}/patch
export DEVICE=lavender
export TYPE=china
export VERSION=beta
export SDAT2IMG=${TOOLS}/sdat2img.py
export IMG2SDAT=${TOOLS}/img2sdat.py
export IMGEXTRACT=${TOOLS}/imgextractor.py
export MKUSERIMG=${TOOLS}/mkuserimg_mke2fs.sh
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

URL="https://hugeota.d.miui.com/21.1.6/miui_LAVENDER_21.1.6_8ede0c913c_10.0.zip"
ZIPNAME=$(echo ${URL} | cut -d / -f 5)
NEWZIP=$(sed "s/lavender/whyred/g;s/LAVENDER/WHYRED/g;s/Lavender/Whyred/g;s/HMNote7/HMNote5Pro/g;s/.zip/-$date.zip/g" <<< $ZIPNAME)
rm -rf ${INDIR} ${OUTDIR}
mkdir -p ${INDIR}
mkdir -p ${OUTDIR}

rm -rf ${LOCALDIR}/flashable/system.*
rm -rf ${LOCALDIR}/flashable/vendor.*

git config --global user.email "anandsingh215@yahoo.com"
git config --global user.name "Anand Shekhawat"

# download and Unzip
echo "Downloading ${ZIPNAME}"
aria2c -x16 -j$(nproc) -q -d "${INDIR}" -o "${ZIPNAME}" ${URL}

partitions=(system vendor)
for partition in ${partitions[@]}; do
echo "Extracting ${partition} to ${INDIR}"
7z e "${INDIR}/${ZIPNAME}" ${partition}.new.dat.br ${partition}.transfer.list -o"$INDIR" > /dev/null
brotli -df ${INDIR}/${partition}.new.dat.br
$SDAT2IMG ${INDIR}/${partition}.transfer.list ${INDIR}/${partition}.new.dat ${INDIR}/${partition}.img > /dev/null
rm -rf ${INDIR}/${partition}.transfer.list ${INDIR}/${partition}.new.dat*
python3 $IMGEXTRACT ${INDIR}/${partition}.img .
rm -rf ${INDIR}/${partition}.img
done

# import APKTOOL frameworks
echo "Importing APKTOOL Frameworks"
${APKTOOL} if ${fframeworkres} > /dev/null
${APKTOOL} if ${fframeworkextres} > /dev/null
${APKTOOL} if ${fmiui} > /dev/null
${APKTOOL} if ${fmiuisystem} > /dev/null

# fetch gapps
ssh-keyscan -t ecdsa -p 22 -H git.rip 2>&1 | tee -a /root/.ssh/known_hosts
if [ ! -d "${LOCALDIR}/gapps" ]; then
git clone git@git.rip:shekhawat2/miui_gapps -b main ${LOCALDIR}/gapps
fi
if [ ! -d "${LOCALDIR}/xapps" ]; then
git clone git@git.rip:shekhawat2/miui_xapps -b main ${LOCALDIR}/xapps
fi

patch_rom() {
echo "Patching system and vendor"
rm ${VENDORDIR}/etc/init/android.hardware.gatekeeper@1.0-service-qti.rc
rm ${VENDORDIR}/etc/init/android.hardware.keymaster@4.0-service-qti.rc
# recovery-from-boot.p
rm -rf ${SYSTEMDIR}/system/recovery-from-boot.p

# apply patch
bash ${PATCHDIR}/services_jar.sh

# data-app
rm -rf ${SYSTEMDIR}/system/data-app
rm -rf ${VENDORDIR}/data-app
# app
apps=(AiAsstVision Mipay VoiceAssist VoiceTrigger SogouInput MiuiAccessibility greenguard mab UPTsmService Updater \
    MiuiSuperMarket AnalyticsCore HybridAccessory HybridPlatform MiuiAudioMonitor MSA PrintRecommendationService \
    KSICibaEngine TranslationService TSMClient WMService XMCloudEngine YouDaoEngine \
    Browser MiuiVideo MiuiCamera NewHome Music QuickSearchBox PersonalAssistant YellowPage ContentExtension \
    TrichromeLibrary WebViewGoogle aiasst_service)
for app in ${apps[@]}; do
rm -rf ${SYSTEMDIR}/system/app/${app}
rm -rf ${SYSTEMDIR}/system/priv-app/${app}
rm -rf ${SYSTEMDIR}/system/product/app/${app}
rm -rf ${SYSTEMDIR}/system/product/priv-app/${app}
done

# theme
rm -rf ${SYSTEMDIR}/system/media/theme/miui_mod_icons
# vendor/overlay
rm -rf ${VENDORDIR}/app/NotchOverlay
rm -rf ${VENDORDIR}/overlay/DevicesOverlay.apk
rm -rf ${VENDORDIR}/overlay/DevicesAndroidOverlay.apk

rsync -ra ${LOCALDIR}/whyred/audio/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/camera/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/display/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/fingerprint/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/keymaster/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/sensors/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/thermal/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/wifi/vendor/ ${VENDORDIR}
rsync -ra ${LOCALDIR}/whyred/app/vendor/ ${VENDORDIR}

rsync -ra ${LOCALDIR}/gapps/system/ ${LOCALDIR}/system
rsync -ra ${LOCALDIR}/xapps/system/ ${LOCALDIR}/system
rsync -ra ${LOCALDIR}/whyred/app/system/ ${LOCALDIR}/system
rsync -ra ${LOCALDIR}/customizations/system/ ${LOCALDIR}/system

# generate overlays
${LOCALDIR}/overlay/build.sh accent
${LOCALDIR}/overlay/build.sh custom
${LOCALDIR}/overlay/build.sh whyred

#fstab
sed -i "s/forceencrypt/encryptable/g" ${VENDORDIR}/etc/fstab.qcom
sed -i "/\/dev\/block\/bootdevice\/by-name\/system/d" ${VENDORDIR}/etc/fstab.qcom
sed -i "\/dev\/block\/bootdevice\/by-name\/userdata/a /dev/block/bootdevice/by-name/cust       /cust                  ext4   ro,nosuid,nodev,barrier=1                        wait,check" ${VENDORDIR}/etc/fstab.qcom

# manifest
sed -i "/<name>android.hardware.keymaster<\/name>/!b;n;n;c\ \ \ \ \ \ \  <version>3.0</version>" ${VENDORDIR}/etc/vintf/manifest.xml
sed -i "/<fqname>@4.0::IKeymasterDevice\/default<\/fqname>/!b;c\ \ \ \ \ \ \ \ <fqname>@3.0::IKeymasterDevice/default</fqname>" ${VENDORDIR}/etc/vintf/manifest.xml

# postboot
sed -i "s/start vendor.cdsprpcd/\# start vendor.cdsprpcd/g" ${VENDORDIR}/bin/init.qcom.post_boot.sh

# build.prop
sprop="${SYSTEMDIR}/system/build.prop"
vprop="${VENDORDIR}/build.prop"
oprop="${VENDORDIR}/odm/etc/build.prop"
pprop="${SYSTEMDIR}/system/product/build.prop"

fp="xiaomi/lavender/lavender:10/QKQ1.190910.002/V12.0.2.0.QFGINXM:user/release-keys"
sp="2020-12-01"
sed -i "s|lavender|whyred|g;s|Redmi Note 7|Redmi Note 5|g;s|build.fingerprint|build.fingerprint_real|g;s|ro.build.version.security_patch|ro.build.version.security_patch_real|g" ${sprop}
sed -i "s|lavender|whyred|g;s|Redmi Note 7|Redmi Note 5|g;s|build.fingerprint|build.fingerprint_real|g;s|ro.vendor.build.security_patch|ro.vendor.build.security_patch_real|g" ${vprop}
sed -i "s|lavender|whyred|g;s|Redmi Note 7|Redmi Note 5|g;s|build.fingerprint|build.fingerprint_real|g" ${oprop}
sed -i "/ro.system.build.fingerprint_real/i ro.build.fingerprint=$fp" ${sprop}
sed -i "/ro.system.build.fingerprint_real/i ro.system.build.fingerprint=$fp|g" ${sprop}
sed -i "/ro.vendor.build.fingerprint_real/i ro.vendor.build.fingerprint=$fp" ${vprop}
sed -i "/ro.odm.build.fingerprint_real/i ro.odm.build.fingerprint=$fp" ${oprop}
sed -i "/ro.build.version.security_patch_real/i ro.build.version.security_patch=$sp" ${sprop}
sed -i "/ro.vendor.build.security_patch_real/i ro.vendor.build.security_patch=$sp" ${vprop}

sed -i "s|ro.product.locale=.*|ro.product.locale=en|g" ${sprop}
sed -i "s|persist.sys.timezone=.*|persist.sys.timezone=Asia/Calcutta|g" ${sprop}

sed -i "s/ro.control_privapp_permissions=enforce/ro.control_privapp_permissions=log/g" ${vprop}
sed -i "/ro.miui.notch=1/d" ${sprop}
sed -i "s/sys.paper_mode_max_level=255/sys.paper_mode_max_level=400/g" ${sprop}

cat ${LOCALDIR}/whyred/system.prop >> ${sprop}
cat ${LOCALDIR}/whyred/vendor.prop >> ${vprop}
cat ${LOCALDIR}/whyred/product.prop >> ${pprop}

# device_features
rm -rf ${SYSTEMDIR}/system/etc/device_features/lavender.xml
rm -rf ${VENDORDIR}/etc/device_features/lavender.xml

# Patch blobs
#bash ${LOCALDIR}/whyred/patch/services_jar.sh
#bash ${LOCALDIR}/whyred/patch/miui_apk.sh

# file_contexts
echo "Patching file_contexts"
cat ${LOCALDIR}/gapps/config/system_file_contexts >> ${LOCALDIR}/config/system_file_contexts
cat ${LOCALDIR}/xapps/config/system_file_contexts >> ${LOCALDIR}/config/system_file_contexts
cat ${LOCALDIR}/overlay/config/system_file_contexts >> ${LOCALDIR}/config/system_file_contexts
cat ${LOCALDIR}/whyred/app/config/system_file_contexts >> ${LOCALDIR}/config/system_file_contexts
cat ${LOCALDIR}/customizations/config/system_file_contexts >> ${LOCALDIR}/config/system_file_contexts
cat ${LOCALDIR}/whyred/app/config/vendor_file_contexts >> ${LOCALDIR}/config/vendor_file_contexts
cat ${LOCALDIR}/whyred/audio/config/vendor_file_contexts >> ${LOCALDIR}/config/vendor_file_contexts
cat ${LOCALDIR}/whyred/camera/config/vendor_file_contexts >> ${LOCALDIR}/config/vendor_file_contexts
cat ${LOCALDIR}/whyred/display/config/vendor_file_contexts >> ${LOCALDIR}/config/vendor_file_contexts
cat ${LOCALDIR}/whyred/fingerprint/config/vendor_file_contexts >> ${LOCALDIR}/config/vendor_file_contexts
cat ${LOCALDIR}/whyred/keymaster/config/vendor_file_contexts >> ${LOCALDIR}/config/vendor_file_contexts
cat ${LOCALDIR}/overlay/config/vendor_file_contexts >> ${LOCALDIR}/config/vendor_file_contexts

# fs_config
echo "Patching fs_config"
cat ${LOCALDIR}/gapps/config/system_fs_config >> ${LOCALDIR}/config/system_fs_config
cat ${LOCALDIR}/xapps/config/system_fs_config >> ${LOCALDIR}/config/system_fs_config
cat ${LOCALDIR}/overlay/config/system_fs_config >> ${LOCALDIR}/config/system_fs_config
cat ${LOCALDIR}/whyred/app/config/system_fs_config >> ${LOCALDIR}/config/system_fs_config
cat ${LOCALDIR}/customizations/config/system_fs_config >> ${LOCALDIR}/config/system_fs_config
cat ${LOCALDIR}/whyred/app/config/vendor_fs_config >> ${LOCALDIR}/config/vendor_fs_config
cat ${LOCALDIR}/whyred/audio/config/vendor_fs_config >> ${LOCALDIR}/config/vendor_fs_config
cat ${LOCALDIR}/whyred/camera/config/vendor_fs_config >> ${LOCALDIR}/config/vendor_fs_config
cat ${LOCALDIR}/whyred/display/config/vendor_fs_config >> ${LOCALDIR}/config/vendor_fs_config
cat ${LOCALDIR}/whyred/fingerprint/config/vendor_fs_config >> ${LOCALDIR}/config/vendor_fs_config
cat ${LOCALDIR}/whyred/keymaster/config/vendor_fs_config >> ${LOCALDIR}/config/vendor_fs_config
cat ${LOCALDIR}/overlay/config/vendor_fs_config >> ${LOCALDIR}/config/vendor_fs_config
}

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
ssize=3221225472
vsize=2147483648
pvsize=`du -sk ${VENDORDIR} | awk '{$1*=1024;printf $1}'`
pssize=`du -sk ${SYSTEMDIR} | awk '{$1*=1024;printf $1}'`
sout=${OUTDIR}/system.img
vout=${OUTDIR}/vendor.img
vfsconfig=${LOCALDIR}/config/vendor_fs_config
sfsconfig=${LOCALDIR}/config/system_fs_config
vfcontexts=${LOCALDIR}/config/vendor_file_contexts
sfcontexts=${LOCALDIR}/config/system_file_contexts

echo "Creating system.img"
echo "system.img size: $(bytesToHuman $pssize)"
$MKUSERIMG -s "${SYSTEMDIR}" "$sout" ext4 system $ssize -C $sfsconfig $sfcontexts -T 0  -L system > /dev/null || exit 1

echo "Creating vendor.img"
echo "vendor.img size: $(bytesToHuman $pvsize)"
$MKUSERIMG -s "${VENDORDIR}" "$vout" ext4 vendor $vsize -C $vfsconfig $vfcontexts -T 0  -L vendor > /dev/null || exit 1

rm -rf ${LOCALDIR}/config
rm -rf ${SYSTEMDIR}
rm -rf ${VENDORDIR}
}

mk_zip() {
    echo "Creating ${NEWZIP}"
    rm -rf ${NEWZIP}
    cp flashable/flashable.zip ${NEWZIP}
    $IMG2SDAT $vout -o flashable -v 4 -p vendor > /dev/null
    $IMG2SDAT $sout -o flashable -v 4 -p system > /dev/null
    cd flashable

    echo "Compressing system.new.dat"
    brotli -7 system.new.dat
    echo "Conpressing vendor.new.dat"
    brotli -7 vendor.new.dat

    rm system.new.dat || exit 1
    rm vendor.new.dat || exit 1

    zip -rv9 ../${NEWZIP} boot.img system.new.dat.br system.patch.dat system.transfer.list vendor.new.dat.br vendor.patch.dat vendor.transfer.list
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

    BOTURL="https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"
    TEXT="$1"
    until [ $(echo -n "$TEXT" | wc -m) -eq 0 ]; do
    res=$(curl -s "${BOTURL}" -d "chat_id=${CHAT_ID}" -d "text=$(urlencode "${TEXT:0:4096}")" -d "parse_mode=Markdown" -d "disable_web_page_preview=true")
    TEXT="${TEXT:4096}"
    done
}

patch_rom
mk_img || continue
mk_zip

rm -rf ${INDIR} ${OUTDIR}

if [ -f ${LOCALDIR}/${NEWZIP} ]; then
    ssh-keyscan -t ecdsa -p 22 -H frs.sourceforge.net 2>&1 | tee -a /root/.ssh/known_hosts
    SF_PROJECT=whyred-miui
if [ "${1}" == "release" ]; then
    scp ${NEWZIP} shekhawat2@frs.sourceforge.net:/home/frs/project/${SF_PROJECT}/${TYPE^^}/${VERSION^^}
    NEWURL="https://sourceforge.net/projects/${SF_PROJECT}/files/${TYPE^^}/${VERSION^^}/${NEWZIP}/download"
elif [ "${1}" == "test" ]; then
    scp ${NEWZIP} shekhawat2@frs.sourceforge.net:/home/frs/project/${SF_PROJECT}/testing/${TYPE^^}/${VERSION^^}
    NEWURL="https://sourceforge.net/projects/${SF_PROJECT}/files/testing/${TYPE^^}/${VERSION^^}/${NEWZIP}/download"
else
    curl "https://bashupload.com/${NEWZIP}" --data-binary "@${NEWZIP}"
fi
    zsize=`du -sk ${NEWZIP} | awk '{$1*=1024;printf $1}'`
    printf "[${NEWZIP}]($NEWURL)\n" > "${LOCALDIR}/info.txt"
    printf "Size: $(bytesToHuman $zsize)" >> "${LOCALDIR}/info.txt"
    tg_send "$(cat ${LOCALDIR}/info.txt)"
else
    exit 0
fi
