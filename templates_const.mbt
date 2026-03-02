///|
/// Root .gitignore
fn gitignore() -> String {
  let s =
    #|*.iml
    #|.gradle
    #|/local.properties
    #|.idea/
    #|.DS_Store
    #|/build
    #|/captures
    #|.externalNativeBuild
    #|.cxx
    #|local.properties
    #|_build/
    #|.mooncakes/
    #|*.jks
  s
}

///|
/// app/proguard-rules.pro
fn proguard_rules() -> String {
  let s =
    #|# Add project specific ProGuard rules here.
    #|# You can control the set of applied configuration files using the
    #|# proguardFiles setting in build.gradle.
    #|#
    #|# For more details, see
    #|#   http://developer.android.com/guide/developing/tools/proguard.html
    #|
    #|# If your project uses WebView with JS, uncomment the following
    #|# and specify the fully qualified class name to the JavaScript interface
    #|# class:
    #|#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
    #|#   public *;
    #|#}
    #|
    #|# Uncomment this to preserve the line number information for
    #|# debugging stack traces.
    #|#-keepattributes SourceFile,LineNumberTable
    #|
    #|# If you keep the line number information, uncomment this to
    #|# hide the original source file name.
    #|#-renamesourcefileattribute SourceFile
  s
}

///|
/// res/values/colors.xml
fn colors_xml() -> String {
  let s =
    #|<?xml version="1.0" encoding="utf-8"?>
    #|<resources>
    #|    <color name="purple_200">#FFBB86FC</color>
    #|    <color name="purple_500">#FF6200EE</color>
    #|    <color name="purple_700">#FF3700B3</color>
    #|    <color name="teal_200">#FF03DAC5</color>
    #|    <color name="teal_700">#FF018786</color>
    #|    <color name="black">#FF000000</color>
    #|    <color name="white">#FFFFFFFF</color>
    #|</resources>
  s
}

///|
/// res/xml/backup_rules.xml
fn backup_rules_xml() -> String {
  let s =
    #|<?xml version="1.0" encoding="utf-8"?><!--
    #|   Sample backup rules file; uncomment and customize as necessary.
    #|   See https://developer.android.com/guide/topics/data/autobackup
    #|   for details.
    #|   Note: This file is ignored for devices older than API 31
    #|   See https://developer.android.com/about/versions/12/backup-restore
    #|-->
    #|<full-backup-content>
    #|    <!--
    #|   <include domain="sharedpref" path="."/>
    #|   <exclude domain="sharedpref" path="device.xml"/>
    #|-->
    #|</full-backup-content>
  s
}

///|
/// res/xml/data_extraction_rules.xml
fn data_extraction_rules_xml() -> String {
  let s =
    #|<?xml version="1.0" encoding="utf-8"?><!--
    #|   Sample data extraction rules file; uncomment and customize as necessary.
    #|   See https://developer.android.com/about/versions/12/backup-restore#xml-changes
    #|   for details.
    #|-->
    #|<data-extraction-rules>
    #|    <cloud-backup>
    #|        <!-- TODO: Use <include> and <exclude> to control what is backed up.
    #|        <include .../>
    #|        <exclude .../>
    #|        -->
    #|    </cloud-backup>
    #|    <!--
    #|    <device-transfer>
    #|        <include .../>
    #|        <exclude .../>
    #|    </device-transfer>
    #|    -->
    #|</data-extraction-rules>
  s
}

///|
/// res/drawable/ic_launcher_background.xml
fn ic_launcher_background_xml() -> String {
  let s =
    #|<?xml version="1.0" encoding="utf-8"?>
    #|<vector xmlns:android="http://schemas.android.com/apk/res/android"
    #|    android:width="108dp"
    #|    android:height="108dp"
    #|    android:viewportWidth="108"
    #|    android:viewportHeight="108">
    #|    <path
    #|        android:fillColor="#37474F"
    #|        android:pathData="M0,0h108v108h-108z" />
    #|</vector>
  s
}

///|
/// res/drawable/ic_launcher_foreground.xml
fn ic_launcher_foreground_xml() -> String {
  let s =
    #|<vector xmlns:android="http://schemas.android.com/apk/res/android"
    #|    android:width="108dp"
    #|    android:height="108dp"
    #|    android:viewportWidth="108"
    #|    android:viewportHeight="108">
    #|
    #|    <!-- 8 spike lines through center -->
    #|    <path
    #|        android:fillColor="#00000000"
    #|        android:pathData="M54,27L54,81 M27,54L81,54 M34.9,34.9L73.1,73.1 M73.1,34.9L34.9,73.1"
    #|        android:strokeColor="#FFFFFF"
    #|        android:strokeLineCap="round"
    #|        android:strokeWidth="4" />
    #|
    #|    <!-- Tip circles at each spike end -->
    #|    <path
    #|        android:fillColor="#FFFFFF"
    #|        android:pathData="M50.5,27a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z M50.5,81a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z M23.5,54a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z M77.5,54a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z M69.6,34.9a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z M69.6,73.1a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z M31.4,73.1a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z M31.4,34.9a3.5,3.5,0,1,0,7,0a3.5,3.5,0,1,0,-7,0z" />
    #|
    #|    <!-- Bomb body -->
    #|    <path
    #|        android:fillColor="#FFFFFF"
    #|        android:pathData="M39,54a15,15,0,1,0,30,0a15,15,0,1,0,-30,0z" />
    #|
    #|</vector>
  s
}

///|
/// res/mipmap-anydpi/ic_launcher.xml
fn ic_launcher_xml() -> String {
  let s =
    #|<?xml version="1.0" encoding="utf-8"?>
    #|<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    #|    <background android:drawable="@drawable/ic_launcher_background" />
    #|    <foreground android:drawable="@drawable/ic_launcher_foreground" />
    #|    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
    #|</adaptive-icon>
  s
}

///|
/// res/mipmap-anydpi/ic_launcher_round.xml
fn ic_launcher_round_xml() -> String {
  let s =
    #|<?xml version="1.0" encoding="utf-8"?>
    #|<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    #|    <background android:drawable="@drawable/ic_launcher_background" />
    #|    <foreground android:drawable="@drawable/ic_launcher_foreground" />
    #|    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
    #|</adaptive-icon>
  s
}
