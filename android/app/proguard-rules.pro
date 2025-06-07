
# Adjust
-keep class com.adjust.sdk.**{ *; }
-keep class com.google.android.gms.common.ConnectionResult {
    int SUCCESS;
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient {
    com.google.android.gms.ads.identifier.AdvertisingIdClient$Info getAdvertisingIdInfo(android.content.Context);
}
-keep class com.google.android.gms.ads.identifier.AdvertisingIdClient$Info {
    java.lang.String getId();
    boolean isLimitAdTrackingEnabled();
}
-keep public class com.android.installreferrer.**{ *; }
# 不在商店須加上規則
-keep public class com.adjust.sdk.**{ *; }

# Google Play Referrer API
-keep public class com.android.installreferrer.**{ *; }
-dontwarn org.bouncycastle.jsse.BCSSLParameters
-dontwarn org.bouncycastle.jsse.BCSSLSocket
-dontwarn org.bouncycastle.jsse.provider.BouncyCastleJsseProvider
-dontwarn org.conscrypt.Conscrypt$Version
-dontwarn org.conscrypt.Conscrypt
-dontwarn org.conscrypt.ConscryptHostnameVerifier
-dontwarn org.openjsse.javax.net.ssl.SSLParameters
-dontwarn org.openjsse.javax.net.ssl.SSLSocket
-dontwarn org.openjsse.net.ssl.OpenJSSE

-if class androidx.credentials.CredentialManager
-keep class androidx.credentials.playservices.** {
  *;
}

# fastjson
-keep class com.alibaba.fastjson.** { *; }
-keep class com.alibaba.fastjson.parser.** { *; }

# Apache Commons
-keep class org.apache.commons.** { *; }

# BouncyCastle
-keep class org.bouncycastle.** { *; }

# Conscrypt
-keep class org.conscrypt.** { *; }

# OpenJSSE
-keep class org.openjsse.** { *; }

# 防止 Crashlytics relocation 問題
-keep class com.google.firebase.crashlytics.buildtools.reloc.** { *; }

# Keep aliagentsdk 全部
-keep class com.alibaba.aliagentsdk.** { *; }