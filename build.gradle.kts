plugins {
    base
    id("com.android.library") version "9.1.1" apply false
}

tasks.register("test") {
    group = LifecycleBasePlugin.VERIFICATION_GROUP
    description = "Runs every JVM/Android test available in the current sprint."
    dependsOn(":runtime-android:test")
}
