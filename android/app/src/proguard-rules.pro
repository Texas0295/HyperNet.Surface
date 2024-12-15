-keepclassmembers class kotlin.Metadata { *; }
-keep class dev.solsynth.solian.** { *; }
-keep public class dev.solsynth.solian.data.** { public *; }
-keepclassmembers class dev.solsynth.solian.data.** { *; }

-keepattributes *Annotation*
-keepattributes Signature
-keepattributes EnclosingMethod

-keep class com.google.gson.** { *; }

-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}