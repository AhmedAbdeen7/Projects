-dontwarn com.google.errorprone.annotations.**
-dontwarn javax.annotation.**
-keep class com.google.crypto.tink.** { *; }
# Google HTTP Client
-keep class com.google.api.client.http.** { *; }
-keep class com.google.api.client.util.** { *; }

# Joda-Time
-keep class org.joda.time.** { *; }
-dontwarn org.joda.time.**
