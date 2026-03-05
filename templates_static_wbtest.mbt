///|
test "gitignore" {
  inspect(
    gitignore(),
    content=(
      #|*.iml
      #|.gradle
      #|/local.properties
      #|.idea/
      #|.DS_Store
      #|build/
      #|/captures
      #|.externalNativeBuild
      #|.cxx
      #|local.properties
      #|_build/
      #|.mooncakes/
      #|*.jks
    ),
  )
}

///|
test "proguard_rules" {
  inspect(
    proguard_rules(),
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
}

///|
test "colors_xml" {
  inspect(
    colors_xml(),
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
}

///|
test "backup_rules_xml" {
  inspect(
    backup_rules_xml(),
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
}

///|
test "data_extraction_rules_xml" {
  inspect(
    data_extraction_rules_xml(),
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
}

///|
test "ic_launcher_background_xml" {
  inspect(
    ic_launcher_background_xml(),
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
}

///|
test "ic_launcher_foreground_xml" {
  inspect(
    ic_launcher_foreground_xml(),
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
}

///|
test "ic_launcher_xml" {
  inspect(
    ic_launcher_xml(),
    content=(
      #|<?xml version="1.0" encoding="utf-8"?>
      #|<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
      #|    <background android:drawable="@drawable/ic_launcher_background" />
      #|    <foreground android:drawable="@drawable/ic_launcher_foreground" />
      #|    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
      #|</adaptive-icon>
    ),
  )
}

///|
test "ic_launcher_round_xml" {
  inspect(
    ic_launcher_round_xml(),
    content=(
      #|<?xml version="1.0" encoding="utf-8"?>
      #|<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
      #|    <background android:drawable="@drawable/ic_launcher_background" />
      #|    <foreground android:drawable="@drawable/ic_launcher_foreground" />
      #|    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
      #|</adaptive-icon>
    ),
  )
}

///|
test "root_build_gradle_kts" {
  inspect(
    root_build_gradle_kts(),
    content=(
      #|// Top-level build file where you can add configuration options common to all sub-projects/modules.
      #|plugins {
      #|    alias(libs.plugins.android.application) apply false
      #|}
    ),
  )
}

///|
test "gradle_properties" {
  inspect(
    gradle_properties(),
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
}

///|
test "libs_versions_toml" {
  inspect(
    libs_versions_toml(),
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
}

///|
test "gradle_wrapper_properties" {
  inspect(
    gradle_wrapper_properties(),
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
}

///|
test "gradlew_script" {
  inspect(
    gradlew_script(),
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
}

///|
test "gradlew_bat_script" {
  let s = gradlew_bat_script()
  // Verify it starts with @rem and contains key sections
  inspect(
    s.contains("@rem"),
    content=(
      #|true
    ),
  )
  inspect(
    s.contains("JAVA_HOME"),
    content=(
      #|true
    ),
  )
  inspect(
    s.contains("gradle-wrapper.jar"),
    content=(
      #|true
    ),
  )
}
