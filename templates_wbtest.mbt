///|
fn test_config2() -> ProjectConfig {
  derive_names("MyBouncingBall", "landscape", "user")
}

///|
test "starter_main_mbt" {
  inspect(starter_main_mbt(test_config2()), content=(
    #|///|
    #|fn main {
    #|  // Initialization
    #|  let screen_width = 800
    #|  let screen_height = 450
    #|  @raylib.init_window(
    #|    screen_width, screen_height, "My Bouncing Ball",
    #|  )
    #|  let mut ball_position_x : Float = Float::from_int(@raylib.get_screen_width()) /
    #|    2.0
    #|  let mut ball_position_y : Float = Float::from_int(@raylib.get_screen_height()) /
    #|    2.0
    #|  let mut ball_speed_x : Float = 5.0
    #|  let mut ball_speed_y : Float = 4.0
    #|  let ball_radius = 20
    #|  let mut pause = false
    #|  let mut frames_counter = 0
    #|  @raylib.set_target_fps(60)
    #|
    #|  // Main game loop
    #|  while not(@raylib.window_should_close()) {
    #|    // Update
    #|    if @raylib.is_key_pressed(@raylib.KeySpace) || @raylib.is_gesture_detected(@raylib.GestureTap) {
    #|      pause = not(pause)
    #|    }
    #|    if not(pause) {
    #|      ball_position_x += ball_speed_x
    #|      ball_position_y += ball_speed_y
    #|
    #|      // Check walls collision for bouncing
    #|      if ball_position_x >=
    #|        Float::from_int(@raylib.get_screen_width() - ball_radius) ||
    #|        ball_position_x <= Float::from_int(ball_radius) {
    #|        ball_speed_x = -ball_speed_x
    #|      }
    #|      if ball_position_y >=
    #|        Float::from_int(@raylib.get_screen_height() - ball_radius) ||
    #|        ball_position_y <= Float::from_int(ball_radius) {
    #|        ball_speed_y = -ball_speed_y
    #|      }
    #|    } else {
    #|      frames_counter += 1
    #|    }
    #|
    #|    // Draw
    #|    @raylib.begin_drawing()
    #|    @raylib.clear_background(@raylib.raywhite)
    #|    @raylib.draw_circle_v(
    #|      @raylib.Vector2::new(ball_position_x, ball_position_y),
    #|      Float::from_int(ball_radius),
    #|      @raylib.maroon,
    #|    )
    #|    @raylib.draw_text(
    #|      "PRESS SPACE or TAP to PAUSE",
    #|      10,
    #|      @raylib.get_screen_height() - 25,
    #|      20,
    #|      @raylib.lightgray,
    #|    )
    #|
    #|    // On pause, we draw a blinking message
    #|    if pause && frames_counter / 30 % 2 != 0 {
    #|      @raylib.draw_text("PAUSED", 350, 200, 30, @raylib.gray)
    #|    }
    #|    @raylib.draw_fps(10, 10)
    #|    @raylib.end_drawing()
    #|  }
    #|
    #|  // De-Initialization
    #|  @raylib.close_window()
    #|}
    #|
  ))
}

///|
test "gen_moon_mod_json" {
  inspect(gen_moon_mod_json(test_config2()), content=(
    #|{
    #|  "name": "user/mybouncingball",
    #|  "version": "0.1.0",
    #|  "deps": {
    #|    "tonyfettes/raylib": "0.2.2"
    #|  },
    #|  "preferred-target": "native"
    #|}
    #|
  ))
}

///|
test "gen_moon_pkg_content" {
  inspect(gen_moon_pkg_content(), content=(
    #|import {
    #|  "tonyfettes/raylib",
    #|}
    #|
    #|options(
    #|  "is-main": true,
    #|)
  ))
}

///|
test "android_manifest_xml" {
  inspect(android_manifest_xml(test_config2()), content=(
    #|<?xml version="1.0" encoding="utf-8"?>
    #|<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    #|    xmlns:tools="http://schemas.android.com/tools">
    #|
    #|    <uses-feature android:glEsVersion="0x00020000" android:required="true" />
    #|
    #|    <application
    #|        android:allowBackup="true"
    #|        android:dataExtractionRules="@xml/data_extraction_rules"
    #|        android:fullBackupContent="@xml/backup_rules"
    #|        android:icon="@mipmap/ic_launcher"
    #|        android:label="@string/app_name"
    #|        android:roundIcon="@mipmap/ic_launcher_round"
    #|        android:supportsRtl="true"
    #|        android:theme="@style/Theme.MyBouncingBall">
    #|        <activity
    #|            android:name=".MainActivity"
    #|            android:exported="true"
    #|            android:configChanges="keyboardHidden|screenSize|orientation"
    #|            android:screenOrientation="landscape">
    #|            <intent-filter>
    #|                <action android:name="android.intent.action.MAIN" />
    #|
    #|                <category android:name="android.intent.category.LAUNCHER" />
    #|            </intent-filter>
    #|
    #|            <meta-data
    #|                android:name="android.app.lib_name"
    #|                android:value="mybouncingball" />
    #|        </activity>
    #|    </application>
    #|
    #|</manifest>
    #|
  ))
}

///|
test "main_activity_kt" {
  inspect(main_activity_kt(test_config2()), content=(
    #|package com.example.mybouncingball
    #|
    #|import android.app.NativeActivity
    #|import android.os.Bundle
    #|import android.view.WindowManager
    #|import androidx.core.view.WindowCompat
    #|import androidx.core.view.WindowInsetsCompat
    #|import androidx.core.view.WindowInsetsControllerCompat
    #|
    #|class MainActivity : NativeActivity() {
    #|
    #|    override fun onCreate(savedInstanceState: Bundle?) {
    #|        super.onCreate(savedInstanceState)
    #|        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
    #|    }
    #|
    #|    override fun onWindowFocusChanged(hasFocus: Boolean) {
    #|        super.onWindowFocusChanged(hasFocus)
    #|        if (hasFocus) {
    #|            hideSystemUi()
    #|        }
    #|    }
    #|
    #|    private fun hideSystemUi() {
    #|        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
    #|        windowInsetsController.systemBarsBehavior =
    #|            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
    #|        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
    #|    }
    #|}
    #|
  ))
}

///|
test "strings_xml" {
  inspect(strings_xml(test_config2()), content=(
    #|<resources>
    #|    <string name="app_name">My Bouncing Ball</string>
    #|</resources>
    #|
  ))
}

///|
test "themes_xml" {
  inspect(themes_xml(test_config2()), content=(
    #|<resources xmlns:tools="http://schemas.android.com/tools">
    #|    <!-- Base application theme. -->
    #|    <style name="Theme.MyBouncingBall" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
    #|        <!-- Primary brand color. -->
    #|        <item name="colorPrimary">@color/purple_500</item>
    #|        <item name="colorPrimaryVariant">@color/purple_700</item>
    #|        <item name="colorOnPrimary">@color/white</item>
    #|        <!-- Secondary brand color. -->
    #|        <item name="colorSecondary">@color/teal_200</item>
    #|        <item name="colorSecondaryVariant">@color/teal_700</item>
    #|        <item name="colorOnSecondary">@color/black</item>
    #|        <!-- Status bar color. -->
    #|        <item name="android:statusBarColor">?attr/colorPrimaryVariant</item>
    #|        <!-- Customize your theme here. -->
    #|    </style>
    #|</resources>
    #|
  ))
}

///|
test "themes_night_xml" {
  inspect(themes_night_xml(test_config2()), content=(
    #|<resources xmlns:tools="http://schemas.android.com/tools">
    #|    <!-- Base application theme. -->
    #|    <style name="Theme.MyBouncingBall" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
    #|        <!-- Primary brand color. -->
    #|        <item name="colorPrimary">@color/purple_200</item>
    #|        <item name="colorPrimaryVariant">@color/purple_700</item>
    #|        <item name="colorOnPrimary">@color/black</item>
    #|        <!-- Secondary brand color. -->
    #|        <item name="colorSecondary">@color/teal_200</item>
    #|        <item name="colorSecondaryVariant">@color/teal_200</item>
    #|        <item name="colorOnSecondary">@color/black</item>
    #|        <!-- Status bar color. -->
    #|        <item name="android:statusBarColor">?attr/colorPrimaryVariant</item>
    #|        <!-- Customize your theme here. -->
    #|    </style>
    #|</resources>
    #|
  ))
}

///|
test "cmake_lists_txt" {
  inspect(cmake_lists_txt(test_config2()), content=(
    #|cmake_minimum_required(VERSION 3.22.1)
    #|project("mybouncingball" C)
    #|
    #|set(MOONBIT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../moonbit)
    #|set(NATIVE_APP_GLUE_DIR ${ANDROID_NDK}/sources/android/native_app_glue)
    #|
    #|# Refresh .mooncakes at configure time so add_subdirectory finds CMakeLists.txt & stubs.
    #|find_program(MOON_EXECUTABLE moon REQUIRED)
    #|execute_process(
    #|    COMMAND ${MOON_EXECUTABLE} check --target native
    #|    WORKING_DIRECTORY ${MOONBIT_DIR}
    #|    RESULT_VARIABLE MOON_RESULT
    #|)
    #|if(NOT MOON_RESULT EQUAL 0)
    #|    message(FATAL_ERROR "moon check failed (exit ${MOON_RESULT})")
    #|endif()
    #|
    #|# Pull in raylib + raylib_moonbit targets; sets RAYLIB_MOONBIT_MOON_HOME
    #|set(RAYLIB_MOONBIT_DIR ${MOONBIT_DIR}/.mooncakes/tonyfettes/raylib)
    #|add_subdirectory(${RAYLIB_MOONBIT_DIR} raylib_build)
    #|
    #|set(MOONBIT_GENERATED_C
    #|    ${MOONBIT_DIR}/_build/native/debug/build/mybouncingball.c)
    #|add_custom_target(moonbit_codegen ALL
    #|    COMMAND ${MOON_EXECUTABLE} build --target native
    #|    WORKING_DIRECTORY ${MOONBIT_DIR}
    #|    BYPRODUCTS ${MOONBIT_GENERATED_C}
    #|    COMMENT "Compiling MoonBit to C"
    #|)
    #|
    #|# Compile runtime.c in isolation: only MOON_HOME/include, no raylib paths.
    #|# internal/raylib/external/dirent.h would shadow system dirent.h otherwise.
    #|add_library(moonbit_runtime OBJECT
    #|    ${RAYLIB_MOONBIT_MOON_HOME}/lib/runtime.c)
    #|target_include_directories(moonbit_runtime PRIVATE
    #|    ${RAYLIB_MOONBIT_MOON_HOME}/include)
    #|target_compile_options(moonbit_runtime PRIVATE
    #|    -fwrapv -fno-strict-aliasing -Wno-unused-value)
    #|
    #|add_library(mybouncingball SHARED
    #|    ${MOONBIT_GENERATED_C}
    #|    $<TARGET_OBJECTS:moonbit_runtime>
    #|    ${NATIVE_APP_GLUE_DIR}/android_native_app_glue.c
    #|)
    #|target_include_directories(mybouncingball PRIVATE
    #|    ${NATIVE_APP_GLUE_DIR})
    #|target_compile_definitions(mybouncingball PRIVATE PLATFORM_ANDROID)
    #|set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -u ANativeActivity_onCreate")
    #|# raylib_moonbit brings in: stubs + raylib core + Android system libs +
    #|# MOON_HOME/include + RAYLIB_SRC_DIR — all transitively via PUBLIC properties.
    #|add_dependencies(mybouncingball moonbit_codegen)
    #|target_link_libraries(mybouncingball raylib_moonbit)
  ))
}

///|
test "settings_gradle_kts" {
  inspect(settings_gradle_kts(test_config2()), content=(
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
    #|rootProject.name = "My Bouncing Ball"
    #|include(":app")
    #|
  ))
}

///|
test "app_build_gradle_kts" {
  inspect(app_build_gradle_kts(test_config2()), content=(
    #|plugins {
    #|    alias(libs.plugins.android.application)
    #|}
    #|
    #|android {
    #|    namespace = "com.example.mybouncingball"
    #|    compileSdk {
    #|        version = release(36) {
    #|            minorApiLevel = 1
    #|        }
    #|    }
    #|
    #|    defaultConfig {
    #|        applicationId = "com.example.mybouncingball"
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
  ))
}

///|
test "replace_all" {
  inspect(replace_all("hello {{NAME}} and {{NAME}}", "{{NAME}}", "world"), content=(
    #|hello world and world
  ))
}
