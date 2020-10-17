.class public Lcom/android/server/DisplayFeatureControl;
.super Landroid/os/IDisplayFeatureControl$Stub;
.source "DisplayFeatureControl.java"

#mod by @pritishsingh07


# static fields
.field private static final CABC_MODE:I = 0x7

.field private static final COLOR_INVERT_MODE:I = 0xf

.field private static DEBUG:Z = false

.field private static final ENHANCE_SCREEN_MODE:I = 0x1

.field private static final EYESHIELD_MODE:I = 0x3

.field private static final FRONT_CAMERA_MODE:I = 0xe

.field private static LENGTH:I = 0x0

.field private static LEVEL:I = 0x0

.field private static OFFSET:I = 0x0

.field private static final SMART_ENVIRONMENT_MODE:I = 0x0

.field private static final STANDARD_MODE:I = 0x2

.field private static TAG:Ljava/lang/String;

.field private static color:I

.field private static eye_old_mode:I

.field private static mDeviceName:Ljava/lang/String;

.field private static mode_status:I

.field private static old_mode:I

.field private static old_value:I

.field private static smart_mode:I

.field private static temp_count:I


# instance fields
.field private final COLOR_AD_PROP:Ljava/lang/String;

.field private final COLOR_CABC_MOVIE_PROP:Ljava/lang/String;

.field private final COLOR_CABC_PROP:Ljava/lang/String;

.field private final COLOR_CABC_STILL_PROP:Ljava/lang/String;

.field private final COLOR_SRGB_PROP:Ljava/lang/String;

.field private final COLOR_TEMPRATURE_PROP:Ljava/lang/String;

.field private final COLOR_WHITEPOINT_X_PROP:Ljava/lang/String;

.field private final COLOR_WHITEPOINT_Y_PROP:Ljava/lang/String;

.field private final DF_EXTCOLOR_PROC:Ljava/lang/String;

.field private final EYESHIELD_INVERT_OLD_MODE_PROP:Ljava/lang/String;

.field private final INVERT_SMART_COLOR_TEMPRATURE_PROP:Ljava/lang/String;

.field private UNKNOWN:Ljava/lang/String;

.field private cabc_exist:Ljava/lang/String;

.field private ce_exist:Ljava/lang/String;

.field private df_extcolor_flag:Ljava/lang/String;

.field private mIsCABL:Z

.field private mIsSVI:Z

.field private mLightSensor:Landroid/hardware/Sensor;

.field private mLightSensorEnabled:Z

.field private final mLightSensorListener:Landroid/hardware/SensorEventListener;

.field private mSensorManager:Landroid/hardware/SensorManager;

.field private papermode_level:Ljava/lang/String;

.field private pcc_exit:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-string v0, "DisplayFeatureControl"

    sput-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/android/server/DisplayFeatureControl;->DEBUG:Z

    sput v0, Lcom/android/server/DisplayFeatureControl;->temp_count:I

    const/4 v1, -0x1

    sput v1, Lcom/android/server/DisplayFeatureControl;->old_mode:I

    sput v1, Lcom/android/server/DisplayFeatureControl;->eye_old_mode:I

    sput v1, Lcom/android/server/DisplayFeatureControl;->old_value:I

    sput v0, Lcom/android/server/DisplayFeatureControl;->smart_mode:I

    sput v0, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    const-string/jumbo v0, "jni_displayfeaturecontrol"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    const-string/jumbo v0, "ro.product.device"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/server/DisplayFeatureControl;->mDeviceName:Ljava/lang/String;

    return-void
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 10

    invoke-direct {p0}, Landroid/os/IDisplayFeatureControl$Stub;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mIsCABL:Z

    iput-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mIsSVI:Z

    const-string/jumbo v1, "sys.svi.enable"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_AD_PROP:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.display_cabc"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_CABC_PROP:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.display_cabc_movie"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_CABC_MOVIE_PROP:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.display_cabc_still"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_CABC_STILL_PROP:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.display_prefer"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_TEMPRATURE_PROP:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.display_srgb"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_SRGB_PROP:Ljava/lang/String;

    const-string/jumbo v1, "sys.white.x.value"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_WHITEPOINT_X_PROP:Ljava/lang/String;

    const-string/jumbo v1, "sys.white.y.value"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->COLOR_WHITEPOINT_Y_PROP:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.df.extcolor.proc"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->DF_EXTCOLOR_PROC:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.invert_smart_color_temprature_prop"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->INVERT_SMART_COLOR_TEMPRATURE_PROP:Ljava/lang/String;

    const-string/jumbo v1, "persist.sys.eyeshield_invert_old_mode_prop"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->EYESHIELD_INVERT_OLD_MODE_PROP:Ljava/lang/String;

    const-string v1, "1"

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->UNKNOWN:Ljava/lang/String;

    new-instance v1, Lcom/android/server/DisplayFeatureControl$2;

    invoke-direct {v1, p0}, Lcom/android/server/DisplayFeatureControl$2;-><init>(Lcom/android/server/DisplayFeatureControl;)V

    iput-object v1, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorListener:Landroid/hardware/SensorEventListener;

    sget-object v1, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const-string v2, "DisplayFeatureControl initial..."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/android/server/DisplayFeatureControl;->nativeInitDisplayMode()I

    :try_start_0
    const-string v1, ""

    const/16 v2, 0x400

    new-array v2, v2, [B

    new-instance v3, Ljava/io/File;

    const-string/jumbo v4, "sys/android_lcd/lcd_name"

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    new-instance v4, Ljava/io/FileInputStream;

    invoke-direct {v4, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    const/4 v5, 0x0

    array-length v6, v2

    invoke-virtual {v4, v2, v5, v6}, Ljava/io/FileInputStream;->read([BII)I

    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    new-instance v6, Ljava/lang/String;

    invoke-direct {v6, v2}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    move-object v1, v5

    const-string/jumbo v5, "sys.paper_mode_max_level"

    iget-object v6, p0, Lcom/android/server/DisplayFeatureControl;->UNKNOWN:Ljava/lang/String;

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/android/server/DisplayFeatureControl;->papermode_level:Ljava/lang/String;

    iget-object v5, p0, Lcom/android/server/DisplayFeatureControl;->papermode_level:Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    sput v5, Lcom/android/server/DisplayFeatureControl;->LEVEL:I

    const-string/jumbo v5, "sensor"

    invoke-virtual {p1, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/hardware/SensorManager;

    iput-object v5, p0, Lcom/android/server/DisplayFeatureControl;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v5, p0, Lcom/android/server/DisplayFeatureControl;->mSensorManager:Landroid/hardware/SensorManager;

    const/4 v6, 0x5

    invoke-virtual {v5, v6}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v5

    iput-object v5, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensor:Landroid/hardware/Sensor;

    new-instance v5, Landroid/content/IntentFilter;

    invoke-direct {v5}, Landroid/content/IntentFilter;-><init>()V

    const-string v6, "android.intent.action.SCREEN_OFF"

    invoke-virtual {v5, v6}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v6, "android.intent.action.SCREEN_ON"

    invoke-virtual {v5, v6}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    sget-boolean v6, Lcom/android/server/DisplayFeatureControl;->DEBUG:Z

    if-eqz v6, :cond_0

    const-string v6, "com.miui.test.displayfeture"

    invoke-virtual {v5, v6}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v6, "com.miui.test.sunlight"

    invoke-virtual {v5, v6}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    :cond_0
    new-instance v6, Lcom/android/server/DisplayFeatureControl$1;

    invoke-direct {v6, p0}, Lcom/android/server/DisplayFeatureControl$1;-><init>(Lcom/android/server/DisplayFeatureControl;)V

    invoke-virtual {p1, v6, v5}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    if-eqz v1, :cond_4

    const-string/jumbo v6, "shenchao"

    invoke-virtual {v1, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string/jumbo v7, "sys.panel.display"

    if-eqz v6, :cond_1

    :try_start_1
    const-string v0, "EBBG"

    invoke-static {v7, v0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const v0, 0xfff5e9

    const v6, 0xecfdff

    invoke-direct {p0, v0, v6}, Lcom/android/server/DisplayFeatureControl;->nativeSetParams(II)I

    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/android/server/DisplayFeatureControl;->nativeSetEyeCareParams(I)I

    goto :goto_0

    :cond_1
    const-string/jumbo v6, "tianma"

    invoke-virtual {v1, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    const v8, 0xf6f9ff

    const v9, 0xfff8f0

    if-eqz v6, :cond_2

    const-string v6, "TIANMA"

    invoke-static {v7, v6}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v9, v8}, Lcom/android/server/DisplayFeatureControl;->nativeSetParams(II)I

    invoke-direct {p0, v0}, Lcom/android/server/DisplayFeatureControl;->nativeSetEyeCareParams(I)I

    goto :goto_0

    :cond_2
    const-string/jumbo v0, "huaxing"

    invoke-virtual {v1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "HUAXING"

    invoke-static {v7, v0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v9, v8}, Lcom/android/server/DisplayFeatureControl;->nativeSetParams(II)I

    const/4 v0, 0x3

    invoke-direct {p0, v0}, Lcom/android/server/DisplayFeatureControl;->nativeSetEyeCareParams(I)I

    :cond_3
    :goto_0
    invoke-direct {p0}, Lcom/android/server/DisplayFeatureControl;->getWhitePointXYParam()[I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    :cond_4
    goto :goto_1

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_1
    return-void
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/android/server/DisplayFeatureControl;)V
    .locals 0

    invoke-direct {p0}, Lcom/android/server/DisplayFeatureControl;->unregisterLightSensor()V

    return-void
.end method

.method static synthetic access$200(Lcom/android/server/DisplayFeatureControl;)V
    .locals 0

    invoke-direct {p0}, Lcom/android/server/DisplayFeatureControl;->registerLightSensor()V

    return-void
.end method

.method static synthetic access$300()Z
    .locals 1

    sget-boolean v0, Lcom/android/server/DisplayFeatureControl;->DEBUG:Z

    return v0
.end method

.method static synthetic access$400(Lcom/android/server/DisplayFeatureControl;F)I
    .locals 1

    invoke-direct {p0, p1}, Lcom/android/server/DisplayFeatureControl;->nativeDataCallBack(F)I

    move-result v0

    return v0
.end method

.method private getPropValue(Ljava/lang/String;)I
    .locals 5

    const-string v0, "-1"

    invoke-static {p1, v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    sget-object v2, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "getPropValue pcc = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, "  name = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "   pccString = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return v1

    :cond_0
    const/4 v1, -0x1

    return v1
.end method

.method private getWhitePointXYParam()[I
    .locals 9

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    new-instance v2, Ljava/io/BufferedReader;

    new-instance v3, Ljava/io/FileReader;

    const-string v4, "/sys/android_whitepoint/whitepoint"

    invoke-direct {v3, v4}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v0, v2

    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v1, v2

    nop

    :try_start_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    :goto_0
    goto :goto_1

    :catch_0
    move-exception v2

    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    :catchall_0
    move-exception v2

    goto/16 :goto_3

    :catch_1
    move-exception v2

    :try_start_2
    sget-object v3, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    nop

    if-eqz v0, :cond_0

    :try_start_3
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :cond_0
    :goto_1
    sget-object v2, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const-string v3, "DisplayFeatureControl: yangfan getWhitePointXYParam..."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x2

    new-array v3, v2, [I

    const/4 v4, 0x1

    if-eqz v1, :cond_1

    const-string v5, ","

    invoke-virtual {v1, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    :goto_2
    if-ge v6, v2, :cond_1

    aget-object v7, v5, v6

    const-string v8, "="

    invoke-virtual {v7, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    aget-object v8, v7, v4

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v8

    aput v8, v3, v6

    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    :cond_1
    const/4 v2, 0x0

    aget v5, v3, v2

    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    const-string/jumbo v6, "sys.white.x.value"

    invoke-static {v6, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    aget v5, v3, v4

    invoke-static {v5}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    const-string/jumbo v6, "sys.white.y.value"

    invoke-static {v6, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v7, "x="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget v2, v3, v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ",y="

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget v2, v3, v4

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v5, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-object v3

    :goto_3
    if-eqz v0, :cond_2

    :try_start_4
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_4

    :catch_2
    move-exception v3

    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    :cond_2
    :goto_4
    throw v2
.end method

.method private native nativeDataCallBack(F)I
.end method

.method private native nativeInitDisplayMode()I
.end method

.method private native nativeSetActiveMode(I)I
.end method

.method private native nativeSetCameraMode(I)I
.end method

.method private native nativeSetColorBalance(I)I
.end method

.method private native nativeSetEyeCareParams(I)I
.end method

.method private native nativeSetPCCConfig(IIII)I
.end method

.method private native nativeSetParams(II)I
.end method

.method private registerLightSensor()V
    .locals 4

    sget-boolean v0, Lcom/android/server/DisplayFeatureControl;->DEBUG:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "registerLightSensor mLightSensorEnabled = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v2, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorEnabled:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorEnabled:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorEnabled:Z

    iget-object v0, p0, Lcom/android/server/DisplayFeatureControl;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorListener:Landroid/hardware/SensorEventListener;

    iget-object v2, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensor:Landroid/hardware/Sensor;

    const/4 v3, 0x3

    invoke-virtual {v0, v1, v2, v3}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    :cond_1
    return-void
.end method

.method private setCABL(Z)V
    .locals 5

    sget-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setCABL : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mIsCABL:Z

    if-ne v0, p1, :cond_0

    sget-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Current CABL mode is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v2, "!!"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_0
    if-eqz p1, :cond_1

    const-string v0, "cabl:on\n"

    goto :goto_0

    :cond_1
    const-string v0, "cabl:off\n"

    :goto_0
    :try_start_0
    new-instance v1, Landroid/net/LocalSocket;

    invoke-direct {v1}, Landroid/net/LocalSocket;-><init>()V

    new-instance v2, Landroid/net/LocalSocketAddress;

    const-string/jumbo v3, "pps"

    sget-object v4, Landroid/net/LocalSocketAddress$Namespace;->RESERVED:Landroid/net/LocalSocketAddress$Namespace;

    invoke-direct {v2, v3, v4}, Landroid/net/LocalSocketAddress;-><init>(Ljava/lang/String;Landroid/net/LocalSocketAddress$Namespace;)V

    invoke-virtual {v1, v2}, Landroid/net/LocalSocket;->connect(Landroid/net/LocalSocketAddress;)V

    invoke-virtual {v1}, Landroid/net/LocalSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    invoke-virtual {v1}, Landroid/net/LocalSocket;->close()V

    iput-boolean p1, p0, Lcom/android/server/DisplayFeatureControl;->mIsCABL:Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v1

    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    sget-object v2, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const-string/jumbo v3, "setCABL IOException"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    return-void
.end method

.method private setPropValue(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    const-string v0, "-1"

    invoke-static {p1, v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sget v1, Lcom/android/server/DisplayFeatureControl;->smart_mode:I

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    invoke-static {p1, p2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    if-eqz v0, :cond_1

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "setPropValue pcc = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "  name = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "   value = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {p1, p2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x2

    sput v1, Lcom/android/server/DisplayFeatureControl;->smart_mode:I

    :cond_1
    :goto_0
    return-void
.end method

.method private setSVI(Z)V
    .locals 5

    sget-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "setSVI : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mIsSVI:Z

    if-ne v0, p1, :cond_0

    sget-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Current SVI mode is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v2, "!!"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_0
    if-eqz p1, :cond_1

    const-string/jumbo v0, "svi:on\n"

    goto :goto_0

    :cond_1
    const-string/jumbo v0, "svi:off\n"

    :goto_0
    :try_start_0
    new-instance v1, Landroid/net/LocalSocket;

    invoke-direct {v1}, Landroid/net/LocalSocket;-><init>()V

    new-instance v2, Landroid/net/LocalSocketAddress;

    const-string/jumbo v3, "pps"

    sget-object v4, Landroid/net/LocalSocketAddress$Namespace;->RESERVED:Landroid/net/LocalSocketAddress$Namespace;

    invoke-direct {v2, v3, v4}, Landroid/net/LocalSocketAddress;-><init>(Ljava/lang/String;Landroid/net/LocalSocketAddress$Namespace;)V

    invoke-virtual {v1, v2}, Landroid/net/LocalSocket;->connect(Landroid/net/LocalSocketAddress;)V

    invoke-virtual {v1}, Landroid/net/LocalSocket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V

    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    invoke-virtual {v1}, Landroid/net/LocalSocket;->close()V

    iput-boolean p1, p0, Lcom/android/server/DisplayFeatureControl;->mIsSVI:Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v1

    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    sget-object v2, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const-string/jumbo v3, "setSVI IOException"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    return-void
.end method

.method private unregisterLightSensor()V
    .locals 3

    sget-boolean v0, Lcom/android/server/DisplayFeatureControl;->DEBUG:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "unregisterLightSensor mLightSensorEnabled = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-boolean v2, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorEnabled:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorEnabled:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorEnabled:Z

    iget-object v0, p0, Lcom/android/server/DisplayFeatureControl;->mSensorManager:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lcom/android/server/DisplayFeatureControl;->mLightSensorListener:Landroid/hardware/SensorEventListener;

    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    :cond_1
    return-void
.end method


# virtual methods
.method public setFeature(IIII)I
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    move-object/from16 v0, p0

    move/from16 v1, p2

    move/from16 v2, p3

    sget-object v3, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "GUOQ setFeature value = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v5, " mode = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v5, " mode_status = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, -0x1

    const/4 v4, -0x1

    iget-object v5, v0, Lcom/android/server/DisplayFeatureControl;->UNKNOWN:Ljava/lang/String;

    const-string/jumbo v6, "persist.sys.df.extcolor.proc"

    invoke-static {v6, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    iput-object v5, v0, Lcom/android/server/DisplayFeatureControl;->df_extcolor_flag:Ljava/lang/String;

    iget-object v5, v0, Lcom/android/server/DisplayFeatureControl;->df_extcolor_flag:Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    const/16 v5, 0xf

    const/4 v6, 0x3

    if-eq v1, v5, :cond_0

    if-eq v1, v6, :cond_0

    invoke-static/range {p2 .. p2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v7

    const-string/jumbo v8, "persist.sys.eyeshield_invert_old_mode_prop"

    invoke-direct {v0, v8, v7}, Lcom/android/server/DisplayFeatureControl;->setPropValue(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const-string/jumbo v7, "sys.svi.enable"

    const-string/jumbo v8, "sys.white.y.value"

    const-string/jumbo v9, "sys.white.x.value"

    const-string v10, "df_extcolor_flag_temp "

    const-string/jumbo v11, "temp_count"

    const-string v12, " value  "

    const-string v13, "GUOQ  mode = "

    const-string/jumbo v14, "persist.sys.display_cabc"

    const/4 v15, 0x2

    const-string v5, "1"

    const/4 v6, 0x1

    if-eqz v1, :cond_f

    if-eq v1, v6, :cond_d

    if-eq v1, v15, :cond_b

    const/4 v15, 0x3

    if-eq v1, v15, :cond_8

    const/4 v7, 0x7

    if-eq v1, v7, :cond_3

    const/16 v5, 0xe

    if-eq v1, v5, :cond_2

    const/16 v5, 0xf

    if-eq v1, v5, :cond_1

    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const-string/jumbo v7, "unknown mode"

    invoke-static {v5, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/16 v3, -0x32

    goto/16 :goto_5

    :cond_1
    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const-string v7, "GUOQ: color invert mode, do noting"

    invoke-static {v5, v7}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5

    :cond_2
    invoke-direct {v0, v2}, Lcom/android/server/DisplayFeatureControl;->nativeSetCameraMode(I)I

    move-result v3

    sget v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    and-int/lit8 v5, v5, 0x8

    or-int/lit8 v5, v5, 0x20

    sput v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    goto/16 :goto_5

    :cond_3
    if-eqz v2, :cond_7

    if-eq v2, v6, :cond_6

    const/4 v7, 0x2

    if-eq v2, v7, :cond_6

    const/4 v7, 0x3

    if-eq v2, v7, :cond_5

    const/4 v7, 0x4

    if-eq v2, v7, :cond_4

    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    const-string/jumbo v7, "unknown value in cabc mode"

    invoke-static {v5, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5

    :cond_4
    const-string/jumbo v7, "persist.sys.display_cabc_movie"

    invoke-static {v7, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_5
    const-string/jumbo v7, "persist.sys.display_cabc_still"

    invoke-static {v7, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_6
    invoke-static {v14, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_7
    const-string v5, "2"

    invoke-static {v14, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string/jumbo v7, "persist.sys.display_cabc_movie"

    invoke-static {v7, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string/jumbo v7, "persist.sys.display_cabc_still"

    invoke-static {v7, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_8
    if-lez v2, :cond_9

    sget v7, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    or-int/lit8 v7, v7, 0x8

    sput v7, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    goto :goto_0

    :cond_9
    sget v7, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    and-int/lit8 v7, v7, 0x7

    sput v7, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    :goto_0
    sget-object v7, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "GUOQ mode_status3 = "

    invoke-virtual {v15, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v6, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    invoke-virtual {v15, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v7, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-lez v4, :cond_a

    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v7, Lcom/android/server/DisplayFeatureControl;->temp_count:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_5

    :cond_a
    invoke-direct {v0, v9}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v6

    invoke-direct {v0, v8}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v7

    const/4 v8, 0x3

    invoke-direct {v0, v2, v6, v7, v8}, Lcom/android/server/DisplayFeatureControl;->nativeSetPCCConfig(IIII)I

    move-result v3

    if-lez v2, :cond_15

    iget-object v6, v0, Lcom/android/server/DisplayFeatureControl;->UNKNOWN:Ljava/lang/String;

    invoke-static {v14, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    iput-object v6, v0, Lcom/android/server/DisplayFeatureControl;->cabc_exist:Ljava/lang/String;

    iget-object v6, v0, Lcom/android/server/DisplayFeatureControl;->cabc_exist:Ljava/lang/String;

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_15

    invoke-static {v14, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_b
    if-lez v4, :cond_c

    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v7, Lcom/android/server/DisplayFeatureControl;->temp_count:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :cond_c
    const/4 v5, 0x0

    invoke-direct {v0, v5}, Lcom/android/server/DisplayFeatureControl;->nativeSetActiveMode(I)I

    move-result v3

    invoke-direct {v0, v9}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v5

    invoke-direct {v0, v8}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v6

    const/4 v8, 0x2

    invoke-direct {v0, v2, v5, v6, v8}, Lcom/android/server/DisplayFeatureControl;->nativeSetPCCConfig(IIII)I

    move-result v3

    const-string/jumbo v5, "off"

    invoke-static {v7, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct/range {p0 .. p0}, Lcom/android/server/DisplayFeatureControl;->unregisterLightSensor()V

    :goto_1
    sget v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    and-int/lit8 v5, v5, 0x8

    or-int/lit8 v5, v5, 0x4

    sput v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    goto/16 :goto_5

    :cond_d
    if-lez v4, :cond_e

    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v7, Lcom/android/server/DisplayFeatureControl;->temp_count:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    :cond_e
    const/4 v5, 0x1

    invoke-direct {v0, v5}, Lcom/android/server/DisplayFeatureControl;->nativeSetActiveMode(I)I

    move-result v3

    invoke-direct {v0, v9}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v6

    invoke-direct {v0, v8}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v8

    invoke-direct {v0, v2, v6, v8, v5}, Lcom/android/server/DisplayFeatureControl;->nativeSetPCCConfig(IIII)I

    move-result v3

    const-string/jumbo v5, "off"

    invoke-static {v7, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct/range {p0 .. p0}, Lcom/android/server/DisplayFeatureControl;->unregisterLightSensor()V

    :goto_2
    sget v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    and-int/lit8 v5, v5, 0x8

    const/4 v6, 0x2

    or-int/2addr v5, v6

    sput v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    goto/16 :goto_5

    :cond_f
    sget v6, Lcom/android/server/DisplayFeatureControl;->smart_mode:I

    const/4 v15, 0x1

    add-int/2addr v6, v15

    sput v6, Lcom/android/server/DisplayFeatureControl;->smart_mode:I

    if-lez v4, :cond_10

    sget-object v5, Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v7, Lcom/android/server/DisplayFeatureControl;->temp_count:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_4

    :cond_10
    if-lez v2, :cond_11

    sget v6, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    and-int/lit8 v6, v6, 0x8

    const/4 v10, 0x3

    shr-int/2addr v6, v10

    if-eqz v6, :cond_12

    :cond_11
    sget v6, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    const/4 v10, 0x1

    and-int/2addr v6, v10

    if-nez v6, :cond_13

    :cond_12
    const/4 v6, 0x2

    invoke-direct {v0, v6}, Lcom/android/server/DisplayFeatureControl;->nativeSetActiveMode(I)I

    move-result v3

    :cond_13
    invoke-direct {v0, v9}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v6

    invoke-direct {v0, v8}, Lcom/android/server/DisplayFeatureControl;->getPropValue(Ljava/lang/String;)I

    move-result v8

    const/4 v9, 0x0

    invoke-direct {v0, v2, v6, v8, v9}, Lcom/android/server/DisplayFeatureControl;->nativeSetPCCConfig(IIII)I

    move-result v3

    invoke-static/range {p3 .. p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v6

    const-string/jumbo v8, "persist.sys.display_prefer"

    invoke-direct {v0, v8, v6}, Lcom/android/server/DisplayFeatureControl;->setPropValue(Ljava/lang/String;Ljava/lang/String;)V

    if-gez v2, :cond_14

    invoke-direct {v0, v14, v5}, Lcom/android/server/DisplayFeatureControl;->setPropValue(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    :cond_14
    invoke-static {v14, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :goto_3
    const-string/jumbo v5, "on"

    invoke-direct {v0, v7, v5}, Lcom/android/server/DisplayFeatureControl;->setPropValue(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct/range {p0 .. p0}, Lcom/android/server/DisplayFeatureControl;->registerLightSensor()V

    :goto_4
    sget v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    and-int/lit8 v5, v5, 0x8

    const/4 v6, 0x1

    or-int/2addr v5, v6

    sput v5, Lcom/android/server/DisplayFeatureControl;->mode_status:I

    invoke-static/range {p3 .. p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v5

    const-string/jumbo v6, "persist.sys.invert_smart_color_temprature_prop"

    invoke-direct {v0, v6, v5}, Lcom/android/server/DisplayFeatureControl;->setPropValue(Ljava/lang/String;Ljava/lang/String;)V

    nop

    :cond_15
    :goto_5
    if-eqz v1, :cond_18

    const/4 v5, 0x3

    if-ne v1, v5, :cond_16

    if-nez v2, :cond_18

    :cond_16
    const/4 v5, 0x1

    if-eq v1, v5, :cond_18

    const/4 v5, 0x2

    if-ne v1, v5, :cond_17

    goto :goto_6

    :cond_17
    const/4 v5, 0x3

    if-ne v1, v5, :cond_19

    if-nez v2, :cond_19

    sput v2, Lcom/android/server/DisplayFeatureControl;->old_value:I

    goto :goto_7

    :cond_18
    :goto_6
    sput v1, Lcom/android/server/DisplayFeatureControl;->old_mode:I

    sput v2, Lcom/android/server/DisplayFeatureControl;->old_value:I

    :cond_19
    :goto_7
    return v3
.end method
