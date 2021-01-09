.class Lcom/android/server/DisplayFeatureControl$1;
.super Landroid/content/BroadcastReceiver;
.source "DisplayFeatureControl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/android/server/DisplayFeatureControl;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/DisplayFeatureControl;


# direct methods
.method constructor <init>(Lcom/android/server/DisplayFeatureControl;)V
    .registers 2

    iput-object p1, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public synthetic lambda$onReceive$0$DisplayFeatureControl$1()V
    .registers 5

    const/4 v0, 0x0

    :goto_1
    const/16 v1, 0xff

    if-gt v0, v1, :cond_1f

    :try_start_5
    iget-object v1, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    const/4 v2, 0x3

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2, v0, v3}, Lcom/android/server/DisplayFeatureControl;->setFeature(IIII)I

    const-wide/16 v1, 0xa

    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_11
    .catch Ljava/lang/InterruptedException; {:try_start_5 .. :try_end_11} :catch_17
    .catch Landroid/os/RemoteException; {:try_start_5 .. :try_end_11} :catch_12

    goto :goto_1b

    :catch_12
    move-exception v1

    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_1c

    :catch_17
    move-exception v1

    invoke-virtual {v1}, Ljava/lang/InterruptedException;->printStackTrace()V

    :goto_1b
    nop

    :goto_1c
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1f
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 8

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "sys.svi.enable"

    const-string/jumbo v2, "off"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    # getter for: Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/android/server/DisplayFeatureControl;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "action="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " colorAdProp="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "android.intent.action.SCREEN_OFF"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const-string/jumbo v3, "on"

    if-eqz v2, :cond_47

    if-eqz v1, :cond_86

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_86

    iget-object v2, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    # invokes: Lcom/android/server/DisplayFeatureControl;->unregisterLightSensor()V
    invoke-static {v2}, Lcom/android/server/DisplayFeatureControl;->access$100(Lcom/android/server/DisplayFeatureControl;)V

    goto :goto_86

    :cond_47
    const-string v2, "android.intent.action.SCREEN_ON"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_5d

    if-eqz v1, :cond_86

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_86

    iget-object v2, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    # invokes: Lcom/android/server/DisplayFeatureControl;->registerLightSensor()V
    invoke-static {v2}, Lcom/android/server/DisplayFeatureControl;->access$200(Lcom/android/server/DisplayFeatureControl;)V

    goto :goto_86

    :cond_5d
    const-string v2, "com.miui.test.displayfeture"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_73

    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/android/server/-$$Lambda$DisplayFeatureControl$1$POGi85L1pkqkLlKZavQ7ueZiuL8;

    invoke-direct {v3, p0}, Lcom/android/server/-$$Lambda$DisplayFeatureControl$1$POGi85L1pkqkLlKZavQ7ueZiuL8;-><init>(Lcom/android/server/DisplayFeatureControl$1;)V

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_86

    :cond_73
    const-string v2, "com.miui.test.sunlight"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_86

    :try_start_7b
    iget-object v2, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v3, v3, v3}, Lcom/android/server/DisplayFeatureControl;->setFeature(IIII)I
    :try_end_81
    .catch Landroid/os/RemoteException; {:try_start_7b .. :try_end_81} :catch_82

    goto :goto_86

    :catch_82
    move-exception v2

    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    :cond_86
    :goto_86
    return-void
.end method
