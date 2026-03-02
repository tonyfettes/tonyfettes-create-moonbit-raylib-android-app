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
  assert_eq(read_text("\{name}/.gitignore"), gitignore())
  assert_eq(read_text("\{name}/settings.gradle.kts"), settings_gradle_kts(config))
  assert_eq(read_text("\{name}/build.gradle.kts"), root_build_gradle_kts())
  assert_eq(read_text("\{name}/gradle.properties"), gradle_properties())
  assert_eq(read_text("\{name}/gradlew"), gradlew_script())
  assert_eq(read_text("\{name}/gradlew.bat"), gradlew_bat_script())
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
  assert_eq(
    read_text("\{name}/gradle/libs.versions.toml"),
    libs_versions_toml(),
  )
  assert_eq(
    read_text("\{name}/gradle/wrapper/gradle-wrapper.properties"),
    gradle_wrapper_properties(),
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
  assert_eq(read_text("\{name}/app/build.gradle.kts"), app_build_gradle_kts(config))
  assert_eq(read_text("\{name}/app/proguard-rules.pro"), proguard_rules())
  assert_eq(
    read_text("\{name}/app/src/main/AndroidManifest.xml"),
    android_manifest_xml(config),
  )
  assert_eq(
    read_text("\{name}/app/src/main/java/com/example/\{pkg}/MainActivity.kt"),
    main_activity_kt(config),
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
  assert_eq(read_text("\{name}/app/src/main/res/values/colors.xml"), colors_xml())
  assert_eq(
    read_text("\{name}/app/src/main/res/values/strings.xml"),
    strings_xml(config),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/values/themes.xml"),
    themes_xml(config),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/values-night/themes.xml"),
    themes_night_xml(config),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/xml/backup_rules.xml"),
    backup_rules_xml(),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/xml/data_extraction_rules.xml"),
    data_extraction_rules_xml(),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/drawable/ic_launcher_background.xml"),
    ic_launcher_background_xml(),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/drawable/ic_launcher_foreground.xml"),
    ic_launcher_foreground_xml(),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/mipmap-anydpi/ic_launcher.xml"),
    ic_launcher_xml(),
  )
  assert_eq(
    read_text("\{name}/app/src/main/res/mipmap-anydpi/ic_launcher_round.xml"),
    ic_launcher_round_xml(),
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
  assert_eq(
    read_text("\{name}/app/src/main/cpp/CMakeLists.txt"),
    cmake_lists_txt(config),
  )
  let moonbit_dir = "\{name}/app/src/main/moonbit"
  assert_eq(read_text("\{moonbit_dir}/main.mbt"), starter_main_mbt(config))
  assert_eq(read_text("\{moonbit_dir}/moon.mod.json"), gen_moon_mod_json(config))
  assert_eq(read_text("\{moonbit_dir}/moon.pkg"), gen_moon_pkg_content())
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
