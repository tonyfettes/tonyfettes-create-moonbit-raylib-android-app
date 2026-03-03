///|
async fn read_text(path : String) -> String {
  @fs.read_file(path).text()
}

///|
/// Mutex to serialize tests that set ANDROID_HOME
let env_mutex : @semaphore.Semaphore = @semaphore.Semaphore::new(1)

///|
async test "generate creates directory structure" {
  let config = derive_names("GenTestDirs", "landscape", "testuser")
  let name = config.project_name
  let pkg = config.package_id
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  env_mutex.acquire()
  @sys.set_env_var("ANDROID_HOME", "/tmp/fake-sdk")
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
  @sys.unset_env_var("ANDROID_HOME")
  env_mutex.release()
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates root files with correct content" {
  let config = derive_names("GenTestRoot", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  env_mutex.acquire()
  @sys.set_env_var("ANDROID_HOME", "/tmp/fake-sdk")
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
  @sys.unset_env_var("ANDROID_HOME")
  env_mutex.release()
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates gradle wrapper files" {
  let config = derive_names("GenTestGradle", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  env_mutex.acquire()
  @sys.set_env_var("ANDROID_HOME", "/tmp/fake-sdk")
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
  @sys.unset_env_var("ANDROID_HOME")
  env_mutex.release()
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
  env_mutex.acquire()
  @sys.set_env_var("ANDROID_HOME", "/tmp/fake-sdk")
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
  @sys.unset_env_var("ANDROID_HOME")
  env_mutex.release()
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates resource files" {
  let config = derive_names("GenTestRes", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  env_mutex.acquire()
  @sys.set_env_var("ANDROID_HOME", "/tmp/fake-sdk")
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
      #|        android:fillColor="#3DDC84"
      #|        android:pathData="M0,0h108v108h-108z" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M9,0L9,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M19,0L19,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M29,0L29,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M39,0L39,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M49,0L49,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M59,0L59,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M69,0L69,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M79,0L79,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M89,0L89,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M99,0L99,108"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,9L108,9"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,19L108,19"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,29L108,29"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,39L108,39"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,49L108,49"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,59L108,59"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,69L108,69"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,79L108,79"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,89L108,89"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M0,99L108,99"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M19,29L89,29"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M19,39L89,39"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M19,49L89,49"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M19,59L89,59"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M19,69L89,69"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M19,79L89,79"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M29,19L29,89"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M39,19L39,89"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M49,19L49,89"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M59,19L59,89"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M69,19L69,89"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|    <path
      #|        android:fillColor="#00000000"
      #|        android:pathData="M79,19L79,89"
      #|        android:strokeWidth="0.8"
      #|        android:strokeColor="#33FFFFFF" />
      #|</vector>
    ),
  )
  inspect(
    read_text("\{name}/app/src/main/res/drawable/ic_launcher_foreground.xml"),
    content=(
      #|<vector xmlns:android="http://schemas.android.com/apk/res/android"
      #|    xmlns:aapt="http://schemas.android.com/aapt"
      #|    android:width="108dp"
      #|    android:height="108dp"
      #|    android:viewportWidth="108"
      #|    android:viewportHeight="108">
      #|    <path android:pathData="M31,63.928c0,0 6.4,-11 12.1,-13.1c7.2,-2.6 26,-1.4 26,-1.4l38.1,38.1L107,108.928l-32,-1L31,63.928z">
      #|        <aapt:attr name="android:fillColor">
      #|            <gradient
      #|                android:endX="85.84757"
      #|                android:endY="92.4963"
      #|                android:startX="42.9492"
      #|                android:startY="49.59793"
      #|                android:type="linear">
      #|                <item
      #|                    android:color="#44000000"
      #|                    android:offset="0.0" />
      #|                <item
      #|                    android:color="#00000000"
      #|                    android:offset="1.0" />
      #|            </gradient>
      #|        </aapt:attr>
      #|    </path>
      #|    <path
      #|        android:fillColor="#FFFFFF"
      #|        android:fillType="nonZero"
      #|        android:pathData="M65.3,45.828l3.8,-6.6c0.2,-0.4 0.1,-0.9 -0.3,-1.1c-0.4,-0.2 -0.9,-0.1 -1.1,0.3l-3.9,6.7c-6.3,-2.8 -13.4,-2.8 -19.7,0l-3.9,-6.7c-0.2,-0.4 -0.7,-0.5 -1.1,-0.3C38.8,38.328 38.7,38.828 38.9,39.228l3.8,6.6C36.2,49.428 31.7,56.028 31,63.928h46C76.3,56.028 71.8,49.428 65.3,45.828zM43.4,57.328c-0.8,0 -1.5,-0.5 -1.8,-1.2c-0.3,-0.7 -0.1,-1.5 0.4,-2.1c0.5,-0.5 1.4,-0.7 2.1,-0.4c0.7,0.3 1.2,1 1.2,1.8C45.3,56.528 44.5,57.328 43.4,57.328L43.4,57.328zM64.6,57.328c-0.8,0 -1.5,-0.5 -1.8,-1.2s-0.1,-1.5 0.4,-2.1c0.5,-0.5 1.4,-0.7 2.1,-0.4c0.7,0.3 1.2,1 1.2,1.8C66.5,56.528 65.6,57.328 64.6,57.328L64.6,57.328z"
      #|        android:strokeWidth="1"
      #|        android:strokeColor="#00000000" />
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
  @sys.unset_env_var("ANDROID_HOME")
  env_mutex.release()
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate creates moonbit and cmake files" {
  let config = derive_names("GenTestMoonbit", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  env_mutex.acquire()
  @sys.set_env_var("ANDROID_HOME", "/tmp/fake-sdk")
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
      #|  @raylib.init_window(800, 450, "Gen Test Moonbit")
      #|  @raylib.set_target_fps(60)
      #|  while not(@raylib.window_should_close()) {
      #|    @raylib.begin_drawing()
      #|    @raylib.clear_background(@raylib.raywhite)
      #|    let text = "Hello, World!"
      #|    let font_size = 20
      #|    @raylib.draw_text(
      #|      text,
      #|      (@raylib.get_screen_width() - @raylib.measure_text(text, font_size)) / 2,
      #|      @raylib.get_screen_height() / 2,
      #|      font_size,
      #|      @raylib.lightgray,
      #|    )
      #|    @raylib.end_drawing()
      #|  }
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
  @sys.unset_env_var("ANDROID_HOME")
  env_mutex.release()
  @fs.rmdir(name, recursive=true)
}

///|
async test "generate detects SDK from default path when env vars unset" {
  let config = derive_names("GenTestSdkFallback", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  // Create a fake SDK directory at the macOS default path
  let fake_home = "gen-test-sdk-home"
  let fake_sdk = "\{fake_home}/Library/Android/sdk"
  if @fs.exists(fake_home) {
    @fs.rmdir(fake_home, recursive=true)
  }
  @fs.mkdir(fake_sdk, permission=0o755, recursive=true)
  env_mutex.acquire()
  @sys.unset_env_var("ANDROID_HOME")
  @sys.unset_env_var("ANDROID_SDK_ROOT")
  let original_home = @sys.get_env_var("HOME")
  @sys.set_env_var("HOME", fake_home)
  generate(config)
  // Verify local.properties was written with the auto-detected path
  inspect(read_text("\{name}/local.properties"), content="sdk.dir=\{fake_sdk}\n")
  // Restore environment
  match original_home {
    Some(h) => @sys.set_env_var("HOME", h)
    None => @sys.unset_env_var("HOME")
  }
  env_mutex.release()
  @fs.rmdir(name, recursive=true)
  @fs.rmdir(fake_home, recursive=true)
}

///|
async test "generate escapes backslashes in SDK path for local.properties" {
  let config = derive_names("GenTestSdkWinPath", "landscape", "testuser")
  let name = config.project_name
  if @fs.exists(name) {
    @fs.rmdir(name, recursive=true)
  }
  env_mutex.acquire()
  // Simulate a Windows-style SDK path with backslashes
  @sys.set_env_var("ANDROID_HOME", "C:\\Users\\mbt\\AppData\\Local\\Android\\Sdk")
  generate(config)
  // Verify backslashes are converted to forward slashes in local.properties
  inspect(
    read_text("\{name}/local.properties"),
    content="sdk.dir=C:/Users/mbt/AppData/Local/Android/Sdk\n",
  )
  @sys.unset_env_var("ANDROID_HOME")
  env_mutex.release()
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
