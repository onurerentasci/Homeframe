plugins {
    base
}

tasks.register("test") {
    group = LifecycleBasePlugin.VERIFICATION_GROUP
    description = "Runs every JVM/Android test available in the current sprint."
    dependsOn(":runtime-android:test")
}
