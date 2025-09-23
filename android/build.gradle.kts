// --- 붙여넣기 시작 (파일 맨 위) ---
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // AGP 버전은 프로젝트에 맞게 유지하세요. (이미 따로 선언되어 있으면 중복 주의)
        classpath("com.google.gms:google-services:4.4.2")
    }
}
// --- 붙여넣기 끝 ---

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
