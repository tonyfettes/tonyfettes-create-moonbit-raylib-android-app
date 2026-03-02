///|
/// AndroidManifest.xml
fn android_manifest_xml(c : ProjectConfig) -> String {
  let theme_name = c.theme_name
  let orientation = c.orientation
  let package_id = c.package_id
  "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\"\n    xmlns:tools=\"http://schemas.android.com/tools\">\n\n    <uses-feature android:glEsVersion=\"0x00020000\" android:required=\"true\" />\n\n    <application\n        android:allowBackup=\"true\"\n        android:dataExtractionRules=\"@xml/data_extraction_rules\"\n        android:fullBackupContent=\"@xml/backup_rules\"\n        android:icon=\"@mipmap/ic_launcher\"\n        android:label=\"@string/app_name\"\n        android:roundIcon=\"@mipmap/ic_launcher_round\"\n        android:supportsRtl=\"true\"\n        android:theme=\"@style/\{theme_name}\">\n        <activity\n            android:name=\".MainActivity\"\n            android:exported=\"true\"\n            android:configChanges=\"keyboardHidden|screenSize|orientation\"\n            android:screenOrientation=\"\{orientation}\">\n            <intent-filter>\n                <action android:name=\"android.intent.action.MAIN\" />\n\n                <category android:name=\"android.intent.category.LAUNCHER\" />\n            </intent-filter>\n\n            <meta-data\n                android:name=\"android.app.lib_name\"\n                android:value=\"\{package_id}\" />\n        </activity>\n    </application>\n\n</manifest>\n"
}

///|
/// MainActivity.kt
fn main_activity_kt(c : ProjectConfig) -> String {
  let package_id = c.package_id
  "package com.example.\{package_id}\n\nimport android.app.NativeActivity\nimport android.os.Bundle\nimport android.view.WindowManager\nimport androidx.core.view.WindowCompat\nimport androidx.core.view.WindowInsetsCompat\nimport androidx.core.view.WindowInsetsControllerCompat\n\nclass MainActivity : NativeActivity() {\n\n    override fun onCreate(savedInstanceState: Bundle?) {\n        super.onCreate(savedInstanceState)\n        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)\n    }\n\n    override fun onWindowFocusChanged(hasFocus: Boolean) {\n        super.onWindowFocusChanged(hasFocus)\n        if (hasFocus) {\n            hideSystemUi()\n        }\n    }\n\n    private fun hideSystemUi() {\n        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)\n        windowInsetsController.systemBarsBehavior =\n            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE\n        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())\n    }\n}\n"
}

///|
/// res/values/strings.xml
fn strings_xml(c : ProjectConfig) -> String {
  let display_name = c.display_name
  "<resources>\n    <string name=\"app_name\">\{display_name}</string>\n</resources>\n"
}

///|
/// res/values/themes.xml
fn themes_xml(c : ProjectConfig) -> String {
  let theme_name = c.theme_name
  "<resources xmlns:tools=\"http://schemas.android.com/tools\">\n    <!-- Base application theme. -->\n    <style name=\"\{theme_name}\" parent=\"Theme.MaterialComponents.DayNight.DarkActionBar\">\n        <!-- Primary brand color. -->\n        <item name=\"colorPrimary\">@color/purple_500</item>\n        <item name=\"colorPrimaryVariant\">@color/purple_700</item>\n        <item name=\"colorOnPrimary\">@color/white</item>\n        <!-- Secondary brand color. -->\n        <item name=\"colorSecondary\">@color/teal_200</item>\n        <item name=\"colorSecondaryVariant\">@color/teal_700</item>\n        <item name=\"colorOnSecondary\">@color/black</item>\n        <!-- Status bar color. -->\n        <item name=\"android:statusBarColor\">?attr/colorPrimaryVariant</item>\n        <!-- Customize your theme here. -->\n    </style>\n</resources>\n"
}

///|
/// res/values-night/themes.xml
fn themes_night_xml(c : ProjectConfig) -> String {
  let theme_name = c.theme_name
  "<resources xmlns:tools=\"http://schemas.android.com/tools\">\n    <!-- Base application theme. -->\n    <style name=\"\{theme_name}\" parent=\"Theme.MaterialComponents.DayNight.DarkActionBar\">\n        <!-- Primary brand color. -->\n        <item name=\"colorPrimary\">@color/purple_200</item>\n        <item name=\"colorPrimaryVariant\">@color/purple_700</item>\n        <item name=\"colorOnPrimary\">@color/black</item>\n        <!-- Secondary brand color. -->\n        <item name=\"colorSecondary\">@color/teal_200</item>\n        <item name=\"colorSecondaryVariant\">@color/teal_200</item>\n        <item name=\"colorOnSecondary\">@color/black</item>\n        <!-- Status bar color. -->\n        <item name=\"android:statusBarColor\">?attr/colorPrimaryVariant</item>\n        <!-- Customize your theme here. -->\n    </style>\n</resources>\n"
}
