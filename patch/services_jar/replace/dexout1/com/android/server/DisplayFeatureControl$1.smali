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
    .locals 0

    iput-object p1, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public synthetic lambda$onReceive$0$DisplayFeatureControl$1()V
    .locals 4

    const/4 v0, 0x0

    :goto_0
    const/16 v1, 0xff

    if-gt v0, v1, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    const/4 v2, 0x3

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2, v0, v3}, Lcom/android/server/DisplayFeatureControl;->setFeature(IIII)I

    const-wide/16 v1, 0xa

    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v1

    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_2

    :catch_1
    move-exception v1

    invoke-virtual {v1}, Ljava/lang/InterruptedException;->printStackTrace()V

    :goto_1
    nop

    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 5

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "sys.svi.enable"

    const-string/jumbo v2, "off"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

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

    if-eqz v2, :cond_0

    if-eqz v1, :cond_3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    invoke-static {v2}, Lcom/android/server/DisplayFeatureControl;->access$100(Lcom/android/server/DisplayFeatureControl;)V

    goto :goto_0

    :cond_0
    const-string v2, "android.intent.action.SCREEN_ON"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    if-eqz v1, :cond_3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    invoke-static {v2}, Lcom/android/server/DisplayFeatureControl;->access$200(Lcom/android/server/DisplayFeatureControl;)V

    goto :goto_0

    :cond_1
    const-string v2, "com.miui.test.displayfeture"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    new-instance v2, Ljava/lang/Thread;

    new-instance v3, Lcom/android/server/-$$Lambda$DisplayFeatureControl$1$POGi85L1pkqkLlKZavQ7ueZiuL8;

    invoke-direct {v3, p0}, Lcom/android/server/-$$Lambda$DisplayFeatureControl$1$POGi85L1pkqkLlKZavQ7ueZiuL8;-><init>(Lcom/android/server/DisplayFeatureControl$1;)V

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    goto :goto_0

    :cond_2
    const-string v2, "com.miui.test.sunlight"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    :try_start_0
    iget-object v2, p0, Lcom/android/server/DisplayFeatureControl$1;->this$0:Lcom/android/server/DisplayFeatureControl;

    const/4 v3, 0x0

    invoke-virtual {v2, v3, v3, v3, v3}, Lcom/android/server/DisplayFeatureControl;->setFeature(IIII)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    invoke-virtual {v2}, Landroid/os/RemoteException;->printStackTrace()V

    :cond_3
    :goto_0
    return-void
.end method
