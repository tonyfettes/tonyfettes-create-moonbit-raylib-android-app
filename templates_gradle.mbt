///|
/// settings.gradle.kts
fn settings_gradle_kts(c : ProjectConfig) -> String {
  let display_name = c.display_name
  (
    #|pluginManagement {
    #|    repositories {
    #|        google {
    #|            content {
    #|                includeGroupByRegex("com\\.android.*")
    #|                includeGroupByRegex("com\\.google.*")
    #|                includeGroupByRegex("androidx.*")
    #|            }
    #|        }
    #|        mavenCentral()
    #|        gradlePluginPortal()
    #|    }
    #|}
    #|plugins {
    #|    id("org.gradle.toolchains.foojay-resolver-convention") version "1.0.0"
    #|}
    #|dependencyResolutionManagement {
    #|    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    #|    repositories {
    #|        google()
    #|        mavenCentral()
    #|    }
    #|}
    $|rootProject.name = "\{display_name}"
    #|include(":app")
    #|
  )
}

///|
/// build.gradle.kts (root)
fn root_build_gradle_kts() -> String {
  (
    #|// Top-level build file where you can add configuration options common to all sub-projects/modules.
    #|plugins {
    #|    alias(libs.plugins.android.application) apply false
    #|}
  )
}

///|
/// app/build.gradle.kts
fn app_build_gradle_kts(c : ProjectConfig) -> String {
  let package_id = c.package_id
  (
    #|plugins {
    #|    alias(libs.plugins.android.application)
    #|}
    #|
    #|android {
    $|    namespace = "com.example.\{package_id}"
    #|    compileSdk {
    #|        version = release(36) {
    #|            minorApiLevel = 1
    #|        }
    #|    }
    #|
    #|    defaultConfig {
    $|        applicationId = "com.example.\{package_id}"
    #|        minSdk = 26
    #|        targetSdk = 36
    #|        versionCode = 1
    #|        versionName = "0.1.0"
    #|
    #|        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    #|
    #|        ndk {
    #|            abiFilters += listOf("arm64-v8a", "armeabi-v7a", "x86_64")
    #|        }
    #|        externalNativeBuild {
    #|            cmake {
    #|                arguments("-DANDROID_STL=c++_shared")
    #|            }
    #|        }
    #|    }
    #|
    #|    signingConfigs {
    #|        create("release") {
    #|            storeFile = rootProject.file("release-key.jks")
    #|            storePassword = "android"
    #|            keyAlias = "release"
    #|            keyPassword = "android"
    #|        }
    #|    }
    #|    buildTypes {
    #|        release {
    #|            isMinifyEnabled = false
    #|            proguardFiles(
    #|                getDefaultProguardFile("proguard-android-optimize.txt"),
    #|                "proguard-rules.pro"
    #|            )
    #|            signingConfig = signingConfigs.getByName("release")
    #|        }
    #|    }
    #|    compileOptions {
    #|        sourceCompatibility = JavaVersion.VERSION_11
    #|        targetCompatibility = JavaVersion.VERSION_11
    #|    }
    #|    externalNativeBuild {
    #|        cmake {
    #|            path = file("src/main/cpp/CMakeLists.txt")
    #|            version = "3.22.1"
    #|        }
    #|    }
    #|}
    #|
    #|dependencies {
    #|    implementation(libs.androidx.core.ktx)
    #|    implementation(libs.androidx.appcompat)
    #|    implementation(libs.material)
    #|    testImplementation(libs.junit)
    #|    androidTestImplementation(libs.androidx.junit)
    #|    androidTestImplementation(libs.androidx.espresso.core)
    #|}
    #|
  )
}

///|
/// gradle.properties
fn gradle_properties() -> String {
  (
    #|# Project-wide Gradle settings.
    #|# IDE (e.g. Android Studio) users:
    #|# Gradle settings configured through the IDE *will override*
    #|# any settings specified in this file.
    #|# For more details on how to configure your build environment visit
    #|# http://www.gradle.org/docs/current/userguide/build_environment.html
    #|# Specifies the JVM arguments used for the daemon process.
    #|# The setting is particularly useful for tweaking memory settings.
    #|org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
    #|# When configured, Gradle will run in incubating parallel mode.
    #|# This option should only be used with decoupled projects. For more details, visit
    #|# https://developer.android.com/r/tools/gradle-multi-project-decoupled-projects
    #|# org.gradle.parallel=true
    #|# AndroidX package structure to make it clearer which packages are bundled with the
    #|# Android operating system, and which are packaged with your app's APK
    #|# https://developer.android.com/topic/libraries/support-library/androidx-rn
    #|android.useAndroidX=true
    #|# Kotlin code style for this project: "official" or "obsolete":
    #|kotlin.code.style=official
    #|# Enables namespacing of each library's R class so that its R class includes only the
    #|# resources declared in the library itself and none from the library's dependencies,
    #|# thereby reducing the size of the R class for that library
    #|android.nonTransitiveRClass=true
  )
}

///|
/// gradle/libs.versions.toml
fn libs_versions_toml() -> String {
  let s =
    #|[versions]
    #|agp = "9.0.1"
    #|coreKtx = "1.10.1"
    #|junit = "4.13.2"
    #|junitVersion = "1.1.5"
    #|espressoCore = "3.5.1"
    #|appcompat = "1.6.1"
    #|material = "1.10.0"
    #|
    #|[libraries]
    #|androidx-core-ktx = { group = "androidx.core", name = "core-ktx", version.ref = "coreKtx" }
    #|junit = { group = "junit", name = "junit", version.ref = "junit" }
    #|androidx-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitVersion" }
    #|androidx-espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espressoCore" }
    #|androidx-appcompat = { group = "androidx.appcompat", name = "appcompat", version.ref = "appcompat" }
    #|material = { group = "com.google.android.material", name = "material", version.ref = "material" }
    #|
    #|[plugins]
    #|android-application = { id = "com.android.application", version.ref = "agp" }
  s
}

///|
/// gradle/wrapper/gradle-wrapper.properties
fn gradle_wrapper_properties() -> String {
  (
    #|distributionBase=GRADLE_USER_HOME
    #|distributionPath=wrapper/dists
    #|distributionSha256Sum=72f44c9f8ebcb1af43838f45ee5c4aa9c5444898b3468ab3f4af7b6076c5bc3f
    #|distributionUrl=https\://services.gradle.org/distributions/gradle-9.2.1-bin.zip
    #|networkTimeout=10000
    #|validateDistributionUrl=true
    #|zipStoreBase=GRADLE_USER_HOME
    #|zipStorePath=wrapper/dists
  )
}
