//plugins {
//    id("com.android.application")
//    id("kotlin-android")
//    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//    id("dev.flutter.flutter-gradle-plugin")
//    id("com.google.gms.google-services")
//}
//
//android {
//    namespace = "com.example.dental_record_app"
//    compileSdk = 35 // 명시적 설정
//    ndkVersion = "27.0.12077973" // 플러그인에서 요구하는 버전
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_1_8
//        targetCompatibility = JavaVersion.VERSION_1_8
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_1_8.toString()
//    }
//
//    defaultConfig {
//        applicationId = "com.example.dental_record_app"
//        minSdk = 23
//        targetSdk = 35 // 명시적 설정
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    buildTypes {
//        release {
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
//
//dependencies {
//    implementation(platform("com.google.firebase:firebase-bom:32.1.1"))
//    implementation("com.google.firebase:firebase-firestore-ktx")
//    implementation("androidx.documentfile:documentfile:1.0.1")
//    implementation("androidx.activity:activity-ktx:1.7.2")
//    implementation("androidx.core:core-ktx:1.10.1")
//}
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.dental_record_app" // 실제 앱 패키지 이름으로 변경
    compileSdk = 35
    buildToolsVersion = "35.0.0" // 명시적으로 설정


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.dental_record_app" // 실제 앱 패키지 이름으로 변경

        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        multiDexEnabled = true // 필요한 경우 추가
    }

    buildTypes {
        release {
            // 코드 축소 활성화
            isMinifyEnabled = true
            // 리소스 축소 활성화
            isShrinkResources = true

            // ProGuard 규칙 파일 설정
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            // 디버그 빌드에서는 축소 비활성화
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.." // Adjust the path if needed
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22") // 필요시 추가
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
    implementation("androidx.activity:activity-compose:1.8.1")
    implementation(platform("androidx.compose:compose-bom:2023.03.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-graphics")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.material3:material3")
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
    androidTestImplementation(platform("androidx.compose:compose-bom:2023.03.00"))
    androidTestImplementation("androidx.compose.ui:ui-test-junit4")
    debugImplementation("androidx.compose.ui:ui-tooling")
    debugImplementation("androidx.compose.ui:ui-test-manifest")
}