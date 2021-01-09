.class Lcom/android/server/DisplayFeatureControl$2;
.super Ljava/lang/Object;
.source "DisplayFeatureControl.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/DisplayFeatureControl;
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

    iput-object p1, p0, Lcom/android/server/DisplayFeatureControl$2;->this$0:Lcom/android/server/DisplayFeatureControl;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .registers 3

    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .registers 6

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    # getter for: Lcom/android/server/DisplayFeatureControl;->DEBUG:Z
    invoke-static {}, Lcom/android/server/DisplayFeatureControl;->access$300()Z

    move-result v1

    if-eqz v1, :cond_24

    # getter for: Lcom/android/server/DisplayFeatureControl;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/android/server/DisplayFeatureControl;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "onSensorChanged receiver : lux = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_24
    iget-object v1, p0, Lcom/android/server/DisplayFeatureControl$2;->this$0:Lcom/android/server/DisplayFeatureControl;

    # invokes: Lcom/android/server/DisplayFeatureControl;->nativeDataCallBack(F)I
    invoke-static {v1, v0}, Lcom/android/server/DisplayFeatureControl;->access$400(Lcom/android/server/DisplayFeatureControl;F)I

    return-void
.end method
