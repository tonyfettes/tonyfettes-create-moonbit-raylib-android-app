///|
/// Project configuration derived from user input
struct ProjectConfig {
  project_name : String // e.g. "MyBouncingBall"
  package_id : String // e.g. "mybouncingball"
  display_name : String // e.g. "My Bouncing Ball"
  theme_name : String // e.g. "Theme.MyBouncingBall"
  module_name : String // e.g. "username/mybouncingball"
  orientation : String // "landscape" or "portrait"
} derive(Show)

///|
/// Convert PascalCase name to lowercase package id
fn to_package_id(name : String) -> String {
  let buf = StringBuilder::new()
  for ch in name {
    if ch >= 'A' && ch <= 'Z' {
      buf.write_char((ch.to_int() + 32).unsafe_to_char())
    } else {
      buf.write_char(ch)
    }
  }
  buf.to_string()
}

///|
/// Convert PascalCase to display name with spaces
fn to_display_name(name : String) -> String {
  let buf = StringBuilder::new()
  let chars = name.to_array()
  for i, ch in chars {
    if i > 0 && ch >= 'A' && ch <= 'Z' {
      // Insert space before uppercase that follows lowercase
      if chars[i - 1] >= 'a' && chars[i - 1] <= 'z' {
        buf.write_char(' ')
      }
    }
    buf.write_char(ch)
  }
  buf.to_string()
}

///|
/// Convert name to theme name
fn to_theme_name(name : String) -> String {
  "Theme.\{name}"
}

///|
/// Validate that name is PascalCase (starts with uppercase, alphanumeric only)
fn is_valid_name(name : String) -> Bool {
  if name.length() == 0 {
    return false
  }
  let chars = name.to_array()
  if chars[0] < 'A' || chars[0] > 'Z' {
    return false
  }
  for ch in chars {
    if not(
        (ch >= 'A' && ch <= 'Z') ||
        (ch >= 'a' && ch <= 'z') ||
        (ch >= '0' && ch <= '9'),
      ) {
      return false
    }
  }
  true
}

///|
/// Derive all project names from the input name
fn derive_names(
  name : String,
  orientation : String,
  module_owner : String,
) -> ProjectConfig {
  let package_id = to_package_id(name)
  {
    project_name: name,
    package_id,
    display_name: to_display_name(name),
    theme_name: to_theme_name(name),
    module_name: "\{module_owner}/\{package_id}",
    orientation,
  }
}
