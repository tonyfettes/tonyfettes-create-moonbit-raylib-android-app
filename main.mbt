///| MoonBit + Raylib Android project scaffolding tool

///|

///|
/// Usage: moon run . -- <ProjectName> [--orientation landscape|portrait] [--module-owner <owner>]
async fn main {
  let args = @env.args()
  // Parse arguments (skip program name)
  let mut project_name = ""
  let mut orientation = "landscape"
  let mut module_owner = "username"
  let mut i = 1
  while i < args.length() {
    if args[i] == "--orientation" {
      i += 1
      if i < args.length() {
        orientation = args[i]
      } else {
        println("Error: --orientation requires a value (landscape or portrait)")
        return
      }
    } else if args[i] == "--module-owner" {
      i += 1
      if i < args.length() {
        module_owner = args[i]
      } else {
        println("Error: --module-owner requires a value")
        return
      }
    } else if args[i] == "--help" || args[i] == "-h" {
      print_usage()
      return
    } else if args[i].length() > 0 && args[i].to_array()[0] == '-' {
      println("Error: Unknown option '\{args[i]}'")
      print_usage()
      return
    } else if project_name == "" {
      project_name = args[i]
    } else {
      println("Error: Unexpected argument '\{args[i]}'")
      print_usage()
      return
    }
    i += 1
  }

  if project_name == "" {
    println("Error: Project name is required.")
    println("")
    print_usage()
    return
  }

  if not(is_valid_name(project_name)) {
    println(
      "Error: Project name must be PascalCase (start with uppercase, alphanumeric only).",
    )
    println("  Example: MyBouncingBall, RaylibGame, SpaceInvaders2026")
    return
  }

  if orientation != "landscape" && orientation != "portrait" {
    println("Error: Orientation must be 'landscape' or 'portrait'.")
    return
  }

  let config = derive_names(project_name, orientation, module_owner)
  generate(config)
}

///|
fn print_usage() -> Unit {
  println("Usage: moon run . -- <ProjectName> [options]")
  println("")
  println("Create a new MoonBit + Raylib Android game project.")
  println("")
  println("Arguments:")
  println("  <ProjectName>              PascalCase name (e.g. MyBouncingBall)")
  println("")
  println("Options:")
  println(
    "  --orientation <value>      Screen orientation: landscape (default) or portrait",
  )
  println(
    "  --module-owner <value>     MoonBit module owner (default: username)",
  )
  println("  -h, --help                 Show this help message")
}
