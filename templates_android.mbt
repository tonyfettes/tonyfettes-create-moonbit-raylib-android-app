///|
/// AndroidManifest.xml
fn android_manifest_xml(c : ProjectConfig) -> String {
  let theme_name = c.theme_name
  let orientation = c.orientation
  let package_id = c.package_id
  (
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
    $|        android:theme="@style/\{theme_name}">
    #|        <activity
    #|            android:name=".MainActivity"
    #|            android:exported="true"
    #|            android:configChanges="keyboardHidden|screenSize|orientation"
    $|            android:screenOrientation="\{orientation}">
    #|            <intent-filter>
    #|                <action android:name="android.intent.action.MAIN" />
    #|
    #|                <category android:name="android.intent.category.LAUNCHER" />
    #|            </intent-filter>
    #|
    #|            <meta-data
    #|                android:name="android.app.lib_name"
    $|                android:value="\{package_id}" />
    #|        </activity>
    #|    </application>
    #|
    #|</manifest>
    #|
  )
}

///|
/// MainActivity.kt
fn main_activity_kt(c : ProjectConfig) -> String {
  let package_id = c.package_id
  (
    $|package com.example.\{package_id}
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
  )
}

///|
/// res/values/strings.xml
fn strings_xml(c : ProjectConfig) -> String {
  let display_name = c.display_name
  (
    #|<resources>
    $|    <string name="app_name">\{display_name}</string>
    #|</resources>
    #|
  )
}

///|
/// res/values/themes.xml
fn themes_xml(c : ProjectConfig) -> String {
  let theme_name = c.theme_name
  (
    #|<resources xmlns:tools="http://schemas.android.com/tools">
    #|    <!-- Base application theme. -->
    $|    <style name="\{theme_name}" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
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
  )
}

///|
/// res/values-night/themes.xml
fn themes_night_xml(c : ProjectConfig) -> String {
  let theme_name = c.theme_name
  (
    #|<resources xmlns:tools="http://schemas.android.com/tools">
    #|    <!-- Base application theme. -->
    $|    <style name="\{theme_name}" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
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
  )
}
