#!/usr/bin/env bash
TMPDIR=$LOCALDIR/temp/miui_apk


mkdir ${TMPDIR}
$APKTOOL d -f -s -o ${TMPDIR} ${fmiui}

ress=(progressPrimaryColor
progressPrimaryColorDark
progressbar_indeterminate_circle_color_light
progressbar_indeterminate_circle_color_dark
spinner_list_text_color_normal_light
spinner_list_text_color_normal_dark
edit_text_dialog_color_normal_light
edit_text_dialog_color_normal_dark
hint_edit_text_color_light
hint_edit_text_color_dark
hint_edit_text_dialog_color_light
hint_edit_text_dialog_color_dark
edit_text_search_color_light
edit_text_search_color_dark
sliding_button_bar_on_light
sliding_button_bar_on_dark
progressbar_color_light
progressbar_color_dark
progressbar_circle_color_light
progressbar_circle_color_dark
sliding_btn_slider_on_pressed_color_light
checkbox_btn_on_background_color_light
checkbox_btn_on_background_color_dark)

for res in ${ress[@]}; do
sed -i "/$res/d" ${TMPDIR}/res/values/colors.xml
done
sed -i "/<\/resources>/d" ${TMPDIR}/res/values/colors.xml

cat >> ${TMPDIR}/res/values/colors.xml << EOF
    <color name="progressPrimaryColor">@android:color/accent_device_default_light</color>
    <color name="progressPrimaryColorDark">@android:color/accent_device_default_light</color>
    <color name="progressbar_indeterminate_circle_color_dark">@android:color/accent_device_default_light</color>
    <color name="progressbar_indeterminate_circle_color_light">@android:color/accent_device_default_light</color>
    <color name="spinner_list_text_color_normal_light">@android:color/accent_device_default_light</color>
    <color name="spinner_list_text_color_normal_dark">@android:color/accent_device_default_light</color>
    <color name="edit_text_dialog_color_normal_light">@android:color/accent_device_default_light</color>
    <color name="edit_text_dialog_color_normal_dark">@android:color/accent_device_default_light</color>
    <color name="hint_edit_text_color_light">@android:color/accent_device_default_light</color>
    <color name="hint_edit_text_color_dark">@android:color/accent_device_default_light</color>
    <color name="hint_edit_text_dialog_color_light">@android:color/accent_device_default_light</color>
    <color name="hint_edit_text_dialog_color_dark">@android:color/accent_device_default_light</color>
    <color name="edit_text_search_color_light">@android:color/accent_device_default_light</color>
    <color name="edit_text_search_color_dark">@android:color/accent_device_default_light</color>
    <color name="sliding_button_bar_on_light">@android:color/accent_device_default_light</color>
    <color name="sliding_button_bar_on_dark">@android:color/accent_device_default_light</color>
    <color name="progressbar_color_light">@android:color/accent_device_default_light</color>
    <color name="progressbar_color_dark">@android:color/accent_device_default_light</color>
    <color name="progressbar_circle_color_light">@android:color/accent_device_default_light</color>
    <color name="progressbar_circle_color_dark">@android:color/accent_device_default_light</color>
    <color name="sliding_btn_slider_on_pressed_color_light">@android:color/accent_device_default_light</color>
    <color name="checkbox_btn_on_background_color_dark">@android:color/accent_device_default_light</color>
    <color name="checkbox_btn_on_background_color_light">@android:color/accent_device_default_light</color>
</resources>
EOF

$APKTOOL b ${TMPDIR}

java -jar ${TOOLS}/signapk/signapk.jar ${TOOLS}/keys/platform.x509.pem ${TOOLS}/keys/platform.pk8 "${TMPDIR}/dist/miui.apk" "${fmiui}"

rm -rf "${TMPDIR}"
