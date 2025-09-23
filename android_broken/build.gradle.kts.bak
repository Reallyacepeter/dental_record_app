//// android/build.gradle.kts  (프로젝트 레벨, Kotlin DSL)
//
//import com.android.build.gradle.LibraryExtension
//
//plugins {
//    id("com.android.application") version "8.7.2" apply false
//    id("org.jetbrains.kotlin.android") version "2.0.21" apply false
//    id("com.google.gms.google-services") version "4.4.2" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}
//
///**
// * 구형 서드파티 라이브러리(예: video_thumbnail 0.5.3)가 build.gradle에
// * namespace를 선언하지 않아 AGP 8에서 실패하는 문제를 여기서 주입해 해결.
// */
//subprojects {
//    // Android Library인 서브모듈만 대상
//    plugins.withId("com.android.library") {
//        // android { } 확장에 접근
//        extensions.configure<LibraryExtension>("android") {
//            // 모듈 고유 namespace가 비어 있으면 보정
//            if (namespace.isNullOrBlank()) {
//                when (name) {
//                    // ← pub cache의 모듈 이름
//                    "video_thumbnail" -> namespace = "xyz.justsoft.video_thumbnail"
//
//                    // 필요 시 다른 구형 플러그인도 추가
//                    // "some_legacy_plugin" -> namespace = "com.example.some_legacy_plugin"
//                }
//            }
//        }
//    }
//}

// android/build.gradle.kts (root)

plugins {
    // 버전 명시 금지(= settings에서 관리)
    id("com.android.application") apply false
    id("org.jetbrains.kotlin.android") apply false
    id("com.google.gms.google-services") apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

/**
 * 일부 구형 플러그인(video_thumbnail 0.5.x 등)이 namespace 미기재로
 * AGP 8에서 실패하는 문제 보정.
 * - 타입을 직접 참조하지 않고 런타임 캐스팅으로 안전 처리
 */
subprojects {
    plugins.withId("com.android.library") {
        extensions.findByName("android")?.let { ext ->
            // ext를 동적으로 캐스팅하여 namespace 접근
            val clazz = ext::class
            val nsProp = clazz.members.firstOrNull { it.name == "namespace" }
            // 프로젝트 이름별로 필요한 경우에만 설정
            if (project.name == "video_thumbnail" && nsProp != null) {
                // namespace가 null/blank면 세팅
                val current = try { nsProp.call(ext) as? String } catch (_: Throwable) { null }
                if (current.isNullOrBlank()) {
                    try {
                        val setter = clazz.members.firstOrNull { it.name == "setNamespace" }
                        if (setter != null) {
                            setter.call(ext, "xyz.justsoft.video_thumbnail")
                        }
                    } catch (_: Throwable) { /* no-op */ }
                }
            }
        }
    }
}
