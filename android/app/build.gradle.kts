plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.jara.jara_universal_search"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.jara.jara_universal_search"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // D22: Play's Wear form factor demands `uses-feature watch
    // required=true`, and that flag filters the phone build out of Play
    // entirely — one manifest cannot serve both stores. The shared
    // manifest stays required=false (side-loading and development work
    // for both form factors); the wear flavour's manifest overrides it
    // to true for store submission. Build the watch with:
    //   flutter build appbundle --flavor wear -t lib/main_watch.dart
    flavorDimensions += "form"
    productFlavors {
        create("phone") {
            dimension = "form"
            isDefault = true
        }
        create("wear") {
            dimension = "form"
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
