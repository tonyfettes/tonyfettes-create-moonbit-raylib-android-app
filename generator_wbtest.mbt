///|
async fn read_text(path : String) -> String {
  @fs.read_file(path).text()
}

///|
async test "generate creates directory structure" {
  let config = derive_names("GenTestDirs", "landscape", "testuser")
  let name = config.project_name
  let pkg = config.package_id
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  generate(config)
  // Verify directories exist
  assert_true(@fs.exists(name))
  assert_true(@fs.exists("\{name}/app"))
  assert_true(@fs.exists("\{name}/app/src/main/cpp"))
  assert_true(@fs.exists("\{name}/app/src/main/java/com/example/\{pkg}"))
  assert_true(@fs.exists("\{name}/app/src/main/moonbit"))
  assert_true(@fs.exists("\{name}/app/src/main/res/drawable"))
  assert_true(@fs.exists("\{name}/app/src/main/res/mipmap-anydpi"))
  assert_true(@fs.exists("\{name}/app/src/main/res/values"))
  assert_true(@fs.exists("\{name}/app/src/main/res/values-night"))
  assert_true(@fs.exists("\{name}/app/src/main/res/xml"))
  assert_true(@fs.exists("\{name}/gradle/wrapper"))
  // Cleanup
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates root files with correct content" {
  let config = derive_names("GenTestRoot", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  generate(config)
  inspect(
    read_text("\{name}/.gitignore"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/settings.gradle.kts"),
    content=(
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
      #|rootProject.name = "Gen Test Root"
      #|include(":app")
      #|
    ),
  )
  inspect(
    read_text("\{name}/build.gradle.kts"),
    content=(
      #|// Top-level build file where you can add configuration options common to all sub-projects/modules.
      #|plugins {
      #|    alias(libs.plugins.android.application) apply false
      #|}
    ),
  )
  inspect(
    read_text("\{name}/gradle.properties"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/gradlew"),
    content=(
      #|#!/bin/sh
      #|
      #|#
      #|# Copyright © 2015 the original authors.
      #|#
      #|# Licensed under the Apache License, Version 2.0 (the "License");
      #|# you may not use this file except in compliance with the License.
      #|# You may obtain a copy of the License at
      #|#
      #|#      https://www.apache.org/licenses/LICENSE-2.0
      #|#
      #|# Unless required by applicable law or agreed to in writing, software
      #|# distributed under the License is distributed on an "AS IS" BASIS,
      #|# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      #|# See the License for the specific language governing permissions and
      #|# limitations under the License.
      #|#
      #|# SPDX-License-Identifier: Apache-2.0
      #|#
      #|
      #|##############################################################################
      #|#
      #|#   Gradle start up script for POSIX generated by Gradle.
      #|#
      #|#   Important for running:
      #|#
      #|#   (1) You need a POSIX-compliant shell to run this script. If your /bin/sh is
      #|#       noncompliant, but you have some other compliant shell such as ksh or
      #|#       bash, then to run this script, type that shell name before the whole
      #|#       command line, like:
      #|#
      #|#           ksh Gradle
      #|#
      #|#       Busybox and similar reduced shells will NOT work, because this script
      #|#       requires all of these POSIX shell features:
      #|#         * functions;
      #|#         * expansions «$var», «${var}», «${var:-default}», «${var+SET}»,
      #|#           «${var#prefix}», «${var%suffix}», and «$( cmd )»;
      #|#         * compound commands having a testable exit status, especially «case»;
      #|#         * various built-in commands including «command», «set», and «ulimit».
      #|#
      #|#   Important for patching:
      #|#
      #|#   (2) This script targets any POSIX shell, so it avoids extensions provided
      #|#       by Bash, Ksh, etc; in particular arrays are avoided.
      #|#
      #|#       The "traditional" practice of packing multiple parameters into a
      #|#       space-separated string is a well documented source of bugs and security
      #|#       problems, so this is (mostly) avoided, by progressively accumulating
      #|#       options in "$@", and eventually passing that to Java.
      #|#
      #|#       Where the inherited environment variables (DEFAULT_JVM_OPTS, JAVA_OPTS,
      #|#       and GRADLE_OPTS) rely on word-splitting, this is performed explicitly;
      #|#       see the in-line comments for details.
      #|#
      #|#       There are tweaks for specific operating systems such as AIX, CygWin,
      #|#       Darwin, MinGW, and NonStop.
      #|#
      #|#   (3) This script is generated from the Groovy template
      #|#       https://github.com/gradle/gradle/blob/HEAD/platforms/jvm/plugins-application/src/main/resources/org/gradle/api/internal/plugins/unixStartScript.txt
      #|#       within the Gradle project.
      #|#
      #|#       You can find Gradle at https://github.com/gradle/gradle/.
      #|#
      #|##############################################################################
      #|
      #|# Attempt to set APP_HOME
      #|
      #|# Resolve links: $0 may be a link
      #|app_path=$0
      #|
      #|# Need this for daisy-chained symlinks.
      #|while
      #|    APP_HOME=${app_path%"${app_path##*/}"}  # leaves a trailing /; empty if no leading path
      #|    [ -h "$app_path" ]
      #|do
      #|    ls=$( ls -ld "$app_path" )
      #|    link=${ls#*' -> '}
      #|    case $link in             #(
      #|      /*)   app_path=$link ;; #(
      #|      *)    app_path=$APP_HOME$link ;;
      #|    esac
      #|done
      #|
      #|# This is normally unused
      #|# shellcheck disable=SC2034
      #|APP_BASE_NAME=${0##*/}
      #|# Discard cd standard output in case $CDPATH is set (https://github.com/gradle/gradle/issues/25036)
      #|APP_HOME=$( cd -P "${APP_HOME:-./}" > /dev/null && printf '%s\n' "$PWD" ) || exit
      #|
      #|# Use the maximum available, or set MAX_FD != -1 to use that value.
      #|MAX_FD=maximum
      #|
      #|warn () {
      #|    echo "$*"
      #|} >&2
      #|
      #|die () {
      #|    echo
      #|    echo "$*"
      #|    echo
      #|    exit 1
      #|} >&2
      #|
      #|# OS specific support (must be 'true' or 'false').
      #|cygwin=false
      #|msys=false
      #|darwin=false
      #|nonstop=false
      #|case "$( uname )" in                #(
      #|  CYGWIN* )         cygwin=true  ;; #(
      #|  Darwin* )         darwin=true  ;; #(
      #|  MSYS* | MINGW* )  msys=true    ;; #(
      #|  NONSTOP* )        nonstop=true ;;
      #|esac
      #|
      #|CLASSPATH="\"\""
      #|
      #|
      #|# Determine the Java command to use to start the JVM.
      #|if [ -n "$JAVA_HOME" ] ; then
      #|    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
      #|        # IBM's JDK on AIX uses strange locations for the executables
      #|        JAVACMD=$JAVA_HOME/jre/sh/java
      #|    else
      #|        JAVACMD=$JAVA_HOME/bin/java
      #|    fi
      #|    if [ ! -x "$JAVACMD" ] ; then
      #|        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME
      #|
      #|Please set the JAVA_HOME variable in your environment to match the
      #|location of your Java installation."
      #|    fi
      #|else
      #|    JAVACMD=java
      #|    if ! command -v java >/dev/null 2>&1
      #|    then
      #|        die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
      #|
      #|Please set the JAVA_HOME variable in your environment to match the
      #|location of your Java installation."
      #|    fi
      #|fi
      #|
      #|# Increase the maximum file descriptors if we can.
      #|if ! "$cygwin" && ! "$darwin" && ! "$nonstop" ; then
      #|    case $MAX_FD in #(
      #|      max*)
      #|        # In POSIX sh, ulimit -H is undefined. That's why the result is checked to see if it worked.
      #|        # shellcheck disable=SC2039,SC3045
      #|        MAX_FD=$( ulimit -H -n ) ||
      #|            warn "Could not query maximum file descriptor limit"
      #|    esac
      #|    case $MAX_FD in  #(
      #|      '' | soft) :;; #(
      #|      *)
      #|        # In POSIX sh, ulimit -n is undefined. That's why the result is checked to see if it worked.
      #|        # shellcheck disable=SC2039,SC3045
      #|        ulimit -n "$MAX_FD" ||
      #|            warn "Could not set maximum file descriptor limit to $MAX_FD"
      #|    esac
      #|fi
      #|
      #|# Collect all arguments for the java command, stacking in reverse order:
      #|#   * args from the command line
      #|#   * the main class name
      #|#   * -classpath
      #|#   * -D...appname settings
      #|#   * --module-path (only if needed)
      #|#   * DEFAULT_JVM_OPTS, JAVA_OPTS, and GRADLE_OPTS environment variables.
      #|
      #|# For Cygwin or MSYS, switch paths to Windows format before running java
      #|if "$cygwin" || "$msys" ; then
      #|    APP_HOME=$( cygpath --path --mixed "$APP_HOME" )
      #|    CLASSPATH=$( cygpath --path --mixed "$CLASSPATH" )
      #|
      #|    JAVACMD=$( cygpath --unix "$JAVACMD" )
      #|
      #|    # Now convert the arguments - kludge to limit ourselves to /bin/sh
      #|    for arg do
      #|        if
      #|            case $arg in                                #(
      #|              -*)   false ;;                            # don't mess with options #(
      #|              /?*)  t=${arg#/} t=/${t%%/*}              # looks like a POSIX filepath
      #|                    [ -e "$t" ] ;;                      #(
      #|              *)    false ;;
      #|            esac
      #|        then
      #|            arg=$( cygpath --path --ignore --mixed "$arg" )
      #|        fi
      #|        # Roll the args list around exactly as many times as the number of
      #|        # args, so each arg winds up back in the position where it started, but
      #|        # possibly modified.
      #|        #
      #|        # NB: a `for` loop captures its iteration list before it begins, so
      #|        # changing the positional parameters here affects neither the number of
      #|        # iterations, nor the values presented in `arg`.
      #|        shift                   # remove old arg
      #|        set -- "$@" "$arg"      # push replacement arg
      #|    done
      #|fi
      #|
      #|
      #|# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
      #|DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'
      #|
      #|# Collect all arguments for the java command:
      #|#   * DEFAULT_JVM_OPTS, JAVA_OPTS, and optsEnvironmentVar are not allowed to contain shell fragments,
      #|#     and any embedded shellness will be escaped.
      #|#   * For example: A user cannot expect ${Hostname} to be expanded, as it is an environment variable and will be
      #|#     treated as '${Hostname}' itself on the command line.
      #|
      #|set -- \
      #|        "-Dorg.gradle.appname=$APP_BASE_NAME" \
      #|        -classpath "$CLASSPATH" \
      #|        -jar "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" \
      #|        "$@"
      #|
      #|# Stop when "xargs" is not available.
      #|if ! command -v xargs >/dev/null 2>&1
      #|then
      #|    die "xargs is not available"
      #|fi
      #|
      #|# Use "xargs" to parse quoted args.
      #|#
      #|# With -n1 it outputs one arg per line, with the quotes and backslashes removed.
      #|#
      #|# In Bash we could simply go:
      #|#
      #|#   readarray ARGS < <( xargs -n1 <<<"$var" ) &&
      #|#   set -- "${ARGS[@]}" "$@"
      #|#
      #|# but POSIX shell has neither arrays nor command substitution, so instead we
      #|# post-process each arg (as a line of input to sed) to backslash-escape any
      #|# character that might be a shell metacharacter, then use eval to reverse
      #|# that process (while maintaining the separation between arguments), and wrap
      #|# the whole thing up as a single "set" statement.
      #|#
      #|# This will of course break if any of these variables contains a newline or
      #|# an unmatched quote.
      #|#
      #|
      #|eval "set -- $(
      #|        printf '%s\n' "$DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS" |
      #|        xargs -n1 |
      #|        sed ' s~[^-[:alnum:]+,./:=@_]~\\&~g; ' |
      #|        tr '\n' ' '
      #|    )" '"$@"'
      #|
      #|exec "$JAVACMD" "$@"
    ),
  )
  // gradlew.bat has \r\n, use property check
  let bat = read_text("\{name}/gradlew.bat")
  inspect(
    bat.contains("@rem"),
    content=(
      #|true
    ),
  )
  inspect(
    bat.contains("gradle-wrapper.jar"),
    content=(
      #|true
    ),
  )
  // Cleanup
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates gradle wrapper files" {
  let config = derive_names("GenTestGradle", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  generate(config)
  inspect(
    read_text("\{name}/gradle/libs.versions.toml"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/gradle/wrapper/gradle-wrapper.properties"),
    content=(
      #|distributionBase=GRADLE_USER_HOME
      #|distributionPath=wrapper/dists
      #|distributionSha256Sum=72f44c9f8ebcb1af43838f45ee5c4aa9c5444898b3468ab3f4af7b6076c5bc3f
      #|distributionUrl=https\://services.gradle.org/distributions/gradle-9.2.1-bin.zip
      #|networkTimeout=10000
      #|validateDistributionUrl=true
      #|zipStoreBase=GRADLE_USER_HOME
      #|zipStorePath=wrapper/dists
    ),
  )
  // Verify gradle-wrapper.jar exists
  assert_true(@fs.exists("\{name}/gradle/wrapper/gradle-wrapper.jar"))
  // Cleanup
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates android and app files" {
  let config = derive_names("GenTestAndroid", "landscape", "testuser")
  let name = config.project_name
  let pkg = config.package_id
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  generate(config)
  inspect(
    read_text("\{name}/app/build.gradle.kts"),
    content=(
      #|plugins {
      #|    alias(libs.plugins.android.application)
      #|}
      #|
      #|android {
      #|    namespace = "com.example.gentestandroid"
      #|    compileSdk {
      #|        version = release(36) {
      #|            minorApiLevel = 1
      #|        }
      #|    }
      #|
      #|    defaultConfig {
      #|        applicationId = "com.example.gentestandroid"
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
    ),
  )
  inspect(
    read_text("\{name}/app/proguard-rules.pro"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/AndroidManifest.xml"),
    content=(
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
      #|        android:theme="@style/Theme.GenTestAndroid">
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
      #|                android:value="gentestandroid" />
      #|        </activity>
      #|    </application>
      #|
      #|</manifest>
      #|
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/java/com/example/\{pkg}/MainActivity.kt"),
    content=(
      #|package com.example.gentestandroid
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
    ),
  )
  // Cleanup
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates resource files" {
  let config = derive_names("GenTestRes", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  generate(config)
  inspect(
    read_text("\{name}/app/src/main/res/values/colors.xml"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/values/strings.xml"),
    content=(
      #|<resources>
      #|    <string name="app_name">Gen Test Res</string>
      #|</resources>
      #|
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/values/themes.xml"),
    content=(
      #|<resources xmlns:tools="http://schemas.android.com/tools">
      #|    <!-- Base application theme. -->
      #|    <style name="Theme.GenTestRes" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/values-night/themes.xml"),
    content=(
      #|<resources xmlns:tools="http://schemas.android.com/tools">
      #|    <!-- Base application theme. -->
      #|    <style name="Theme.GenTestRes" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/xml/backup_rules.xml"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/xml/data_extraction_rules.xml"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/drawable/ic_launcher_background.xml"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/drawable/ic_launcher_foreground.xml"),
    content=(
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
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/mipmap-anydpi/ic_launcher.xml"),
    content=(
      #|<?xml version="1.0" encoding="utf-8"?>
      #|<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
      #|    <background android:drawable="@drawable/ic_launcher_background" />
      #|    <foreground android:drawable="@drawable/ic_launcher_foreground" />
      #|    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
      #|</adaptive-icon>
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/mipmap-anydpi/ic_launcher_round.xml"),
    content=(
      #|<?xml version="1.0" encoding="utf-8"?>
      #|<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
      #|    <background android:drawable="@drawable/ic_launcher_background" />
      #|    <foreground android:drawable="@drawable/ic_launcher_foreground" />
      #|    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
      #|</adaptive-icon>
    ),
  )
  // Cleanup
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates moonbit and cmake files" {
  let config = derive_names("GenTestMoonbit", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  generate(config)
  inspect(
    read_text("\{name}/app/src/main/cpp/CMakeLists.txt"),
    content=(
      #|cmake_minimum_required(VERSION 3.22.1)
      #|project("gentestmoonbit" C)
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
      #|    ${MOONBIT_DIR}/_build/native/debug/build/gentestmoonbit.c)
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
      #|add_library(gentestmoonbit SHARED
      #|    ${MOONBIT_GENERATED_C}
      #|    $<TARGET_OBJECTS:moonbit_runtime>
      #|    ${NATIVE_APP_GLUE_DIR}/android_native_app_glue.c
      #|)
      #|target_include_directories(gentestmoonbit PRIVATE
      #|    ${NATIVE_APP_GLUE_DIR})
      #|target_compile_definitions(gentestmoonbit PRIVATE PLATFORM_ANDROID)
      #|set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -u ANativeActivity_onCreate")
      #|# raylib_moonbit brings in: stubs + raylib core + Android system libs +
      #|# MOON_HOME/include + RAYLIB_SRC_DIR — all transitively via PUBLIC properties.
      #|add_dependencies(gentestmoonbit moonbit_codegen)
      #|target_link_libraries(gentestmoonbit raylib_moonbit)
    ),
  )
  let moonbit_dir = "\{name}/app/src/main/moonbit"
  inspect(
    read_text("\{moonbit_dir}/main.mbt"),
    content=(
      #|///|
      #|fn main {
      #|  // Initialization
      #|  let screen_width = 800
      #|  let screen_height = 450
      #|  @raylib.init_window(
      #|    screen_width, screen_height, "Gen Test Moonbit",
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
    ),
  )
  inspect(
    read_text("\{moonbit_dir}/moon.mod.json"),
    content=(
      #|{
      #|  "name": "testuser/gentestmoonbit",
      #|  "version": "0.1.0",
      #|  "deps": {
      #|    "tonyfettes/raylib": "0.2.2"
      #|  },
      #|  "preferred-target": "native"
      #|}
      #|
    ),
  )
  inspect(
    read_text("\{moonbit_dir}/moon.pkg"),
    content=(
      #|import {
      #|  "tonyfettes/raylib",
      #|}
      #|
      #|options(
      #|  "is-main": true,
      #|)
    ),
  )
  // Cleanup
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate skips existing directory" {
  let config = derive_names("GenTestSkip", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  // Create the directory manually
  @fs.mkdir(name, permission=0o755)
  // generate should return early without creating sub-directories
  generate(config)
  let entries = @fs.readdir(name, sort=true)
  // Directory should be empty since generate returned early
  inspect(entries, content="[]")
  // Cleanup
  @fs.rmdir(name, recursive=true)
}
