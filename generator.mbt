///|
/// Write a file with default permissions
async fn write_file(path : String, content : String) -> Unit {
  @fs.write_file(path, content, create=0o644)
}

///|
/// Write a binary file with default permissions
async fn write_bytes(path : String, content : Bytes) -> Unit {
  @fs.write_file(path, content, create=0o644)
}

///|
/// Write a file with executable permissions
async fn write_executable(path : String, content : String) -> Unit {
  @fs.write_file(path, content, create=0o755)
}

///|
/// Detect the Android SDK directory by checking environment variables
/// and well-known default installation paths.
async fn detect_android_sdk() -> String? {
  match @sys.get_env_var("ANDROID_HOME") {
    Some(v) => return Some(v)
    None => ()
  }
  match @sys.get_env_var("ANDROID_SDK_ROOT") {
    Some(v) => return Some(v)
    None => ()
  }
  // Probe well-known default paths
  match @sys.get_env_var("HOME") {
    Some(home) => {
      let macos_path = "\{home}/Library/Android/sdk"
      if @fs.exists(macos_path) {
        return Some(macos_path)
      }
      let linux_path = "\{home}/Android/Sdk"
      if @fs.exists(linux_path) {
        return Some(linux_path)
      }
    }
    None => ()
  }
  match @sys.get_env_var("LOCALAPPDATA") {
    Some(appdata) => {
      let win_path = "\{appdata}/Android/Sdk"
      if @fs.exists(win_path) {
        return Some(win_path)
      }
    }
    None => ()
  }
  match @sys.get_env_var("USERPROFILE") {
    Some(profile) => {
      let win_path = "\{profile}/AppData/Local/Android/Sdk"
      if @fs.exists(win_path) {
        return Some(win_path)
      }
    }
    None => ()
  }
  None
}

///|
/// Generate the complete project
async fn generate(config : ProjectConfig) -> Unit raise Error {
  let name = config.project_name
  let pkg = config.package_id

  // Check if output directory already exists
  if @fs.exists(name) {
    println("Error: Directory '\{name}' already exists.")
    return
  }

  println("Creating project '\{name}'...")

  // Create directory tree
  let dirs = [
    "\{name}",
    "\{name}/app",
    "\{name}/app/src/main/cpp",
    "\{name}/app/src/main/java/com/example/\{pkg}",
    "\{name}/app/src/main/moonbit",
    "\{name}/app/src/main/res/drawable",
    "\{name}/app/src/main/res/mipmap-anydpi",
    "\{name}/app/src/main/res/values",
    "\{name}/app/src/main/res/values-night",
    "\{name}/app/src/main/res/xml",
    "\{name}/gradle/wrapper",
  ]
  for dir in dirs {
    @fs.mkdir(dir, permission=0o755, recursive=true)
  }

  // Write all project files

  // Root files
  write_file("\{name}/.gitignore", gitignore())
  write_file("\{name}/settings.gradle.kts", settings_gradle_kts(config))
  write_file("\{name}/build.gradle.kts", root_build_gradle_kts())
  write_file("\{name}/gradle.properties", gradle_properties())
  write_executable("\{name}/gradlew", gradlew_script())
  write_file("\{name}/gradlew.bat", gradlew_bat_script())

  // Gradle wrapper
  write_file("\{name}/gradle/libs.versions.toml", libs_versions_toml())
  write_file(
    "\{name}/gradle/wrapper/gradle-wrapper.properties",
    gradle_wrapper_properties(),
  )

  // Decode and write gradle-wrapper.jar
  let jar_bytes = base64_decode(gradle_wrapper_jar_base64)
  write_bytes("\{name}/gradle/wrapper/gradle-wrapper.jar", jar_bytes)

  // App build files
  write_file("\{name}/app/build.gradle.kts", app_build_gradle_kts(config))
  write_file("\{name}/app/proguard-rules.pro", proguard_rules())

  // Android manifest and Kotlin sources
  write_file(
    "\{name}/app/src/main/AndroidManifest.xml",
    android_manifest_xml(config),
  )
  write_file(
    "\{name}/app/src/main/java/com/example/\{pkg}/MainActivity.kt",
    main_activity_kt(config),
  )

  // Resources
  write_file("\{name}/app/src/main/res/values/colors.xml", colors_xml())
  write_file("\{name}/app/src/main/res/values/strings.xml", strings_xml(config))
  write_file("\{name}/app/src/main/res/values/themes.xml", themes_xml(config))
  write_file(
    "\{name}/app/src/main/res/values-night/themes.xml",
    themes_night_xml(config),
  )
  write_file(
    "\{name}/app/src/main/res/xml/backup_rules.xml",
    backup_rules_xml(),
  )
  write_file(
    "\{name}/app/src/main/res/xml/data_extraction_rules.xml",
    data_extraction_rules_xml(),
  )
  write_file(
    "\{name}/app/src/main/res/drawable/ic_launcher_background.xml",
    ic_launcher_background_xml(),
  )
  write_file(
    "\{name}/app/src/main/res/drawable/ic_launcher_foreground.xml",
    ic_launcher_foreground_xml(),
  )
  write_file(
    "\{name}/app/src/main/res/mipmap-anydpi/ic_launcher.xml",
    ic_launcher_xml(),
  )
  write_file(
    "\{name}/app/src/main/res/mipmap-anydpi/ic_launcher_round.xml",
    ic_launcher_round_xml(),
  )

  // CMakeLists.txt
  write_file("\{name}/app/src/main/cpp/CMakeLists.txt", cmake_lists_txt(config))

  // MoonBit sources
  let moonbit_dir = "\{name}/app/src/main/moonbit"
  write_file("\{moonbit_dir}/main.mbt", starter_main_mbt(config))
  write_file("\{moonbit_dir}/moon.mod.json", gen_moon_mod_json(config))
  write_file("\{moonbit_dir}/moon.pkg", gen_moon_pkg_content())

  // Run moon install to fetch dependencies
  println("Installing MoonBit dependencies...")
  let exit_code = @process.run("moon", ["install"], cwd=moonbit_dir)
  if exit_code != 0 {
    println(
      "Warning: 'moon install' exited with code \{exit_code}. You may need to run it manually.",
    )
  }

  // Try to detect Android SDK and write local.properties
  let lp_path = "\{name}/local.properties"
  match detect_android_sdk() {
    Some(dir) => {
      write_file(lp_path, "sdk.dir=\{dir}\n")
      println("Detected Android SDK, wrote local.properties")
    }
    None =>
      raise Failure::Failure(
        "Could not detect Android SDK. Please install Android Studio (https://developer.android.com/studio) or set the ANDROID_HOME environment variable.",
      )
  }

  // Initialize git repository
  println("Initializing git repository...")
  let git_init_code = @process.run("git", ["init"], cwd=name)
  if git_init_code != 0 {
    println(
      "Warning: 'git init' exited with code \{git_init_code}. You may need to run it manually.",
    )
  }

  // Success message
  println("")
  println("Project '\{name}' created successfully!")
  println("")
  println("Next steps:")
  println("  cd \{name}")
  println("  ./gradlew assembleDebug --no-daemon")
  println("")
  println("Install on device:")
  println("  adb install -r app/build/outputs/apk/debug/app-debug.apk")
  println(
    "  adb shell am start -n com.example.\{pkg}/com.example.\{pkg}.MainActivity",
  )
}
